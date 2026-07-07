import { Router } from 'express';
import { getNotifications, markAsRead, markAllRead } from './notifications.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = Router();

router.use(authenticate);

router.get('/', getNotifications);
router.put('/read-all', markAllRead);
router.put('/:id/read', markAsRead);

export default router;
