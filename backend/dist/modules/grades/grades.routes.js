import { Router } from 'express';
import { getGradesOverview } from './grades.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.get('/', authenticate, getGradesOverview);
export default router;
