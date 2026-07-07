const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const authMiddleware = require('../middlewares/authMiddleware');

// POST /api/auth/register
router.post('/register', authController.register);

// POST /api/auth/login
router.post('/login', authController.login);

// POST /api/auth/social-login
router.post('/social-login', authController.socialLogin);

// GET /api/auth/me (Protected Route Example)
router.get('/me', authMiddleware, authController.getMe);

// POST /api/auth/forgot-password
router.post('/forgot-password', authController.forgotPassword);

// POST /api/auth/verify-email
router.post('/verify-email', authController.verifyEmail);

module.exports = router;
