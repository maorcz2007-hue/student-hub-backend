import { Router } from 'express';
import { chatWithAI, getAIHistory } from './ai.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.use(authenticate);
router.post('/chat', chatWithAI);
router.get('/history', getAIHistory);
export default router;
