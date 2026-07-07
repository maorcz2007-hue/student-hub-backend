import { Router } from 'express';
import { getProfile, updateProfile, getSettings, updateSettings } from './users.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
// Apply auth middleware to all profile routes
router.use(authenticate);
router.get('/profile', getProfile);
router.put('/profile', updateProfile);
router.get('/settings', getSettings);
router.put('/settings', updateSettings);
export default router;
