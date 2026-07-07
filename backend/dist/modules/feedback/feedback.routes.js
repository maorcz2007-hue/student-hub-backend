import { Router } from 'express';
import { submitFeedback, getFeedbacks } from './feedback.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.use(authenticate);
router.post('/', submitFeedback);
router.get('/', getFeedbacks);
export default router;
