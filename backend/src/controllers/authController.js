const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const prisma = require('../config/db');
const { OAuth2Client } = require('google-auth-library');
const appleSignin = require('apple-signin-auth');
const { Resend } = require('resend');

const resend = new Resend(process.env.RESEND_API_KEY);

const googleClient = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

const generateToken = (userId, role) => {
  return jwt.sign({ id: userId, role }, process.env.JWT_SECRET, {
    expiresIn: '30d',
  });
};

exports.register = async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    // Validate input
    if (!name || !email || !password) {
      return res.status(400).json({ message: 'Please provide all required fields' });
    }

    // Check if user exists
    const userExists = await prisma.user.findUnique({ where: { email } });
    if (userExists) {
      return res.status(400).json({ message: 'User already exists with this email' });
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create user
    const user = await prisma.user.create({
      data: {
        name,
        email,
        password: hashedPassword,
        role: role || 'STUDENT',
      },
    });

    if (user) {
      // Send verification email using Resend
      try {
        await resend.emails.send({
          from: 'onboarding@resend.dev',
          to: user.email,
          subject: 'Welcome to Students APK - Verify Your Email',
          html: `<p>Welcome, ${user.name}!</p><p>Please verify your email to get started.</p>`
        });
      } catch (emailError) {
        console.error('Failed to send verification email:', emailError);
      }

      res.status(201).json({
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        token: generateToken(user.id, user.role),
      });
    } else {
      res.status(400).json({ message: 'Invalid user data received' });
    }
  } catch (error) {
    console.error('Register error:', error);
    res.status(500).json({ message: 'Server Error during registration' });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({ message: 'Please provide email and password' });
    }

    // Find user
    const user = await prisma.user.findUnique({ where: { email } });

    // Compare passwords
    if (user && (await bcrypt.compare(password, user.password))) {
      res.json({
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        token: generateToken(user.id, user.role),
      });
    } else {
      res.status(401).json({ message: 'Invalid email or password' });
    }
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server Error during login' });
  }
};

exports.getMe = async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.user.id },
      select: { id: true, name: true, email: true, role: true }, // Don't return password
    });

    if (user) {
      res.json(user);
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (error) {
    console.error('GetMe error:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};

exports.socialLogin = async (req, res) => {
  try {
    const { provider, token, email, fullName } = req.body;

    if (!provider || !token) {
      return res.status(400).json({ message: 'Provider and token are required' });
    }

    let verifiedEmail = email;
    let verifiedName = fullName;

    // Verify token based on provider
    if (provider === 'google') {
      try {
        const ticket = await googleClient.verifyIdToken({
          idToken: token,
          audience: process.env.GOOGLE_CLIENT_ID,
        });
        const payload = ticket.getPayload();
        verifiedEmail = payload.email;
        if (!verifiedName) verifiedName = payload.name;
      } catch (err) {
        console.error('Google token verification failed:', err);
        return res.status(401).json({ message: 'Invalid Google token' });
      }
    } else if (provider === 'apple') {
      try {
        const payload = await appleSignin.verifyIdToken(token, {
          audience: process.env.APPLE_CLIENT_ID,
          ignoreExpiration: true,
        });
        verifiedEmail = payload.email;
      } catch (err) {
        console.error('Apple token verification failed:', err);
        return res.status(401).json({ message: 'Invalid Apple token' });
      }
    } else {
      return res.status(400).json({ message: 'Unsupported provider' });
    }

    if (!verifiedEmail) {
      return res.status(400).json({ message: 'Email could not be extracted from OAuth provider' });
    }

    // Find or create user
    let user = await prisma.user.findUnique({ where: { email: verifiedEmail } });

    if (!user) {
      // Create new user with random password since they use social login
      const randomPassword = Math.random().toString(36).slice(-10);
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(randomPassword, salt);

      user = await prisma.user.create({
        data: {
          fullName: verifiedName || 'User',
          email: verifiedEmail,
          passwordHash: hashedPassword,
          role: 'STUDENT',
          isVerified: true,
        },
      });
    }

    // Return our standard JWT response
    res.json({
      id: user.id,
      name: user.fullName || user.name, // Support both new fullName and legacy name
      email: user.email,
      role: user.role,
      token: generateToken(user.id, user.role),
    });

  } catch (error) {
    console.error('Social Login error:', error);
    res.status(500).json({ message: 'Server Error during social login' });
  }
};

exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;
    if (!email) return res.status(400).json({ message: 'Email is required' });
    
    // Check if user exists
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return res.status(404).json({ message: 'User not found' });

    // Send password reset email using Resend
    try {
      await resend.emails.send({
        from: 'onboarding@resend.dev',
        to: email,
        subject: 'Password Reset',
        html: '<p>You requested a password reset. Click the link to reset your password.</p>'
      });
    } catch (emailError) {
      console.error('Resend error:', emailError);
      return res.status(500).json({ message: 'Failed to send password reset email' });
    }
    
    res.json({ message: 'Password reset link sent to email' });
  } catch (error) {
    console.error('Forgot password error:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};

exports.verifyEmail = async (req, res) => {
  try {
    const { token } = req.body;
    if (!token) return res.status(400).json({ message: 'Token is required' });

    // Mock verify token logic
    console.log(`Mock: Verifying email with token ${token}`);
    
    res.json({ message: 'Email verified successfully' });
  } catch (error) {
    console.error('Verify email error:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};
