import { Router } from 'express';
import { getAdminStats, getUsers, updateUserRole, deleteUser } from './admin.controller.js';
import { authenticate, authorize } from '../../middleware/auth.middleware.js';

const router = Router();

router.use(authenticate);
router.use(authorize('ADMIN'));

router.get('/stats', getAdminStats);
router.get('/users', getUsers);
router.put('/users/:id/role', updateUserRole);
router.delete('/users/:id', deleteUser);

export default router;
