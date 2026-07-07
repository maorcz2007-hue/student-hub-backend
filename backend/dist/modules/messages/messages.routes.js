import { Router } from 'express';
import { getConversations, createConversation, getConversationMessages } from './messages.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.use(authenticate);
router.get('/conversations', getConversations);
router.post('/conversations', createConversation);
router.get('/conversations/:id/messages', getConversationMessages);
export default router;
