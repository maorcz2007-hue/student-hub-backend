import path from 'path';
import fs from 'fs';
import { prisma } from '../../config/database.js';
import { env } from '../../config/environment.js';
export async function uploadFile(req, res, next) {
    try {
        const userId = req.user?.id;
        const file = req.file;
        if (!file) {
            return res.status(400).json({ success: false, message: 'No file uploaded' });
        }
        const newFile = await prisma.file.create({
            data: {
                userId: userId,
                name: file.originalname,
                path: file.filename,
                mimeType: file.mimetype,
                size: file.size,
                folder: req.body.folder || 'root',
            },
        });
        return res.status(201).json({ success: true, file: newFile });
    }
    catch (error) {
        next(error);
    }
}
export async function getFiles(req, res, next) {
    try {
        const userId = req.user?.id;
        const { folder } = req.query;
        const files = await prisma.file.findMany({
            where: {
                userId,
                folder: folder || 'root',
            },
            orderBy: { createdAt: 'desc' },
        });
        if (files.length === 0) {
            // Mock default system files for easy dev onboarding
            const mockFiles = [
                { id: '1', name: 'Lecture Notes - Week 1.pdf', mimeType: 'application/pdf', size: 2411724, folder: 'root', createdAt: new Date().toISOString() },
                { id: '2', name: 'Assignment Template.docx', mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', size: 159744, folder: 'root', createdAt: new Date().toISOString() },
                { id: '3', name: 'Grade Report.xlsx', mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', size: 91136, folder: 'root', createdAt: new Date().toISOString() },
            ];
            return res.status(200).json({ success: true, files: mockFiles });
        }
        return res.status(200).json({ success: true, files });
    }
    catch (error) {
        next(error);
    }
}
export async function downloadFile(req, res, next) {
    try {
        const { id } = req.params;
        const userId = req.user?.id;
        const file = await prisma.file.findFirst({
            where: { id, userId },
        });
        if (!file) {
            return res.status(404).json({ success: false, message: 'File not found or unauthorized' });
        }
        const uploadDir = path.resolve(env.UPLOAD_DIR);
        const filePath = path.resolve(path.join(uploadDir, file.path));
        // Verify the resolved path starts with the base upload directory to prevent path traversal
        if (!filePath.startsWith(uploadDir)) {
            return res.status(400).json({ success: false, message: 'Access denied: Invalid file path' });
        }
        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ success: false, message: 'Physical file not found on disk' });
        }
        return res.download(filePath, file.name);
    }
    catch (error) {
        next(error);
    }
}
export async function deleteFile(req, res, next) {
    try {
        const { id } = req.params;
        const userId = req.user?.id;
        const file = await prisma.file.findFirst({
            where: { id, userId },
        });
        if (!file) {
            return res.status(404).json({ success: false, message: 'File not found or unauthorized' });
        }
        // Delete physical file
        const uploadDir = path.resolve(env.UPLOAD_DIR);
        const filePath = path.resolve(path.join(uploadDir, file.path));
        // Verify the resolved path starts with the base upload directory to prevent path traversal
        if (!filePath.startsWith(uploadDir)) {
            return res.status(400).json({ success: false, message: 'Access denied: Invalid file path' });
        }
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }
        await prisma.file.delete({ where: { id } });
        return res.status(200).json({ success: true, message: 'File deleted successfully' });
    }
    catch (error) {
        next(error);
    }
}
