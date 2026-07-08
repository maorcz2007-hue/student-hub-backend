import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { prisma } from '../../config/database.js';
import { env } from '../../config/environment.js';
import { hashPassword, comparePassword } from '../../utils/hash.js';
import { logger } from '../../utils/logger.js';

function generateTokens(user: { id: string; email: string; role: string }) {
  const accessToken = jwt.sign(
    { id: user.id, email: user.email, role: user.role },
    env.JWT_SECRET,
    { expiresIn: env.JWT_EXPIRES_IN as any }
  );

  const refreshToken = jwt.sign(
    { id: user.id, email: user.email, role: user.role },
    env.JWT_REFRESH_SECRET,
    { expiresIn: env.JWT_REFRESH_EXPIRES_IN as any }
  );

  const decoded = jwt.decode(accessToken) as { exp: number };
  const expiresAt = new Date(decoded.exp * 1000).toISOString();

  return { accessToken, refreshToken, expiresAt };
}

export async function register(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password, fullName, studentId, role } = req.body;

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ success: false, message: 'Email already in use' });
    }

    const passwordHash = await hashPassword(password);

    // Create user and profile
    const userRole = role || 'STUDENT';
    const user = await prisma.$transaction(async (tx: any) => {
      const newUser = await tx.user.create({
        data: {
          email,
          passwordHash,
          fullName,
          role: userRole,
          isVerified: true, // Default to true for easy dev onboarding
        },
      });

      if (userRole === 'STUDENT') {
        const customId = studentId || `STU-${Date.now().toString().slice(-6)}`;
        await tx.student.create({
          data: {
            userId: newUser.id,
            studentId: customId,
            university: 'MIT',
            faculty: 'Engineering',
            department: 'Computer Science',
            year: 1,
            semester: 1,
          },
        });
      }

      // Create default user settings
      await tx.userSettings.create({
        data: {
          userId: newUser.id,
        },
      });

      return newUser;
    });

    const tokens = generateTokens(user);

    // Persist session
    await prisma.session.create({
      data: {
        userId: user.id,
        token: tokens.refreshToken,
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
      },
    });

    // Fetch complete user profile if student
    const fullUser = await prisma.user.findUnique({
      where: { id: user.id },
      include: { studentProfile: true },
    });

    logger.info(`User registered successfully: ${email}`);

    return res.status(201).json({
      success: true,
      user: {
        id: fullUser?.id,
        email: fullUser?.email,
        fullName: fullUser?.fullName,
        role: fullUser?.role,
        studentId: fullUser?.studentProfile?.studentId,
        university: fullUser?.studentProfile?.university,
        faculty: fullUser?.studentProfile?.faculty,
        department: fullUser?.studentProfile?.department,
        year: fullUser?.studentProfile?.year,
        semester: fullUser?.studentProfile?.semester,
        bio: fullUser?.studentProfile?.bio,
        createdAt: fullUser?.createdAt,
        updatedAt: fullUser?.updatedAt,
      },
      ...tokens,
    });
  } catch (error) {
    next(error);
  }
}

export async function login(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ success: false, message: 'Email and password are required' });
    }

    const user = await prisma.user.findUnique({
      where: { email },
      include: { studentProfile: true },
    });

    if (!user) {
      return res.status(400).json({ success: false, message: 'Invalid email or password' });
    }

    const isMatch = await comparePassword(password, user.passwordHash);
    if (!isMatch) {
      return res.status(400).json({ success: false, message: 'Invalid email or password' });
    }

    const tokens = generateTokens(user);

    // Persist session
    await prisma.session.create({
      data: {
        userId: user.id,
        token: tokens.refreshToken,
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });

    logger.info(`User logged in successfully: ${email}`);

    return res.status(200).json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        role: user.role,
        studentId: user.studentProfile?.studentId,
        university: user.studentProfile?.university,
        faculty: user.studentProfile?.faculty,
        department: user.studentProfile?.department,
        year: user.studentProfile?.year,
        semester: user.studentProfile?.semester,
        bio: user.studentProfile?.bio,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      },
      ...tokens,
    });
  } catch (error) {
    logger.error('Login error:', error);
    return res.status(500).json({ success: false, message: 'Internal server error during login' });
  }
}

export async function refresh(req: Request, res: Response, next: NextFunction) {
  try {
    const { refreshToken } = req.body;

    // Verify token exists in database
    const session = await prisma.session.findUnique({
      where: { token: refreshToken },
    });

    if (!session || session.expiresAt < new Date()) {
      if (session) {
        await prisma.session.delete({ where: { id: session.id } });
      }
      return res.status(401).json({ success: false, message: 'Refresh token invalid or expired' });
    }

    let decoded: any;
    try {
      decoded = jwt.verify(refreshToken, env.JWT_REFRESH_SECRET);
    } catch (err) {
      await prisma.session.delete({ where: { id: session.id } });
      return res.status(401).json({ success: false, message: 'Refresh token invalid' });
    }

    const user = await prisma.user.findUnique({ where: { id: decoded.id } });
    if (!user) {
      return res.status(401).json({ success: false, message: 'User not found' });
    }

    const tokens = generateTokens(user);

    // Update session expiration
    await prisma.session.update({
      where: { id: session.id },
      data: {
        token: tokens.refreshToken,
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });

    return res.status(200).json({
      success: true,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiresAt: tokens.expiresAt,
    });
  } catch (error) {
    next(error);
  }
}

export async function logout(req: Request, res: Response, next: NextFunction) {
  try {
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.split(' ')[1];
      // Optional: blacklist access token or clear matching sessions
    }

    const { refreshToken } = req.body;
    if (refreshToken) {
      await prisma.session.deleteMany({
        where: { token: refreshToken },
      });
    }

    return res.status(200).json({ success: true, message: 'Logged out successfully' });
  } catch (error) {
    next(error);
  }
}

export async function forgotPassword(req: Request, res: Response, next: NextFunction) {
  try {
    const { email } = req.body;
    // Just mock email dispatch in dev mode
    logger.info(`Password reset requested for: ${email}`);
    return res.status(200).json({ success: true, message: 'Reset email sent' });
  } catch (error) {
    next(error);
  }
}
