import { Router } from 'express';
import { getEvents, createEvent, deleteEvent } from './calendar.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.use(authenticate);
router.get('/', getEvents);
router.post('/', createEvent);
router.delete('/:id', deleteEvent);
export default router;
