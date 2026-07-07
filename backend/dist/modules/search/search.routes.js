import { Router } from 'express';
import { searchEverything } from './search.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
const router = Router();
router.get('/', authenticate, searchEverything);
export default router;
