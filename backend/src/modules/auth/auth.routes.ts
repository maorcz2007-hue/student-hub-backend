import { Router } from 'express';
import { register, login, refresh, logout, forgotPassword } from './auth.controller.js';
import { validateRequest } from '../../middleware/validation.middleware.js';
import { registerSchema, loginSchema, refreshTokenSchema, forgotPasswordSchema } from './auth.schema.js';

const router = Router();

router.post('/register', validateRequest(registerSchema), register);
router.post('/login', validateRequest(loginSchema), login);
router.post('/refresh', validateRequest(refreshTokenSchema), refresh);
router.post('/logout', logout);
router.post('/forgot-password', validateRequest(forgotPasswordSchema), forgotPassword);

export default router;
