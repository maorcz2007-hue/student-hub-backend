import { Router } from 'express';
import { uploadFile, getFiles, downloadFile, deleteFile } from './files.controller.js';
import { authenticate } from '../../middleware/auth.middleware.js';
import { upload } from '../../middleware/upload.middleware.js';

const router = Router();

router.use(authenticate);

router.post('/upload', upload.single('file'), uploadFile);
router.get('/', getFiles);
router.get('/:id/download', downloadFile);
router.delete('/:id', deleteFile);

export default router;
