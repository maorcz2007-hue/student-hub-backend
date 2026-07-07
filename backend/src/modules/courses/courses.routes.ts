import { Router } from 'express';
import { getCourses, getCourseById, getCourseResources } from './courses.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';

const router = Router();

router.use(authenticate);

router.get('/', getCourses);
router.get('/:id', getCourseById);
router.get('/:id/resources', getCourseResources);

export default router;
