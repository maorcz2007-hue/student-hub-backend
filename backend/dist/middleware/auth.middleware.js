import jwt from 'jsonwebtoken';
import { env } from '../config/environment.js';
import { prisma } from '../config/database.js';
export const authenticate = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({ success: false, message: 'Unauthorized: No token provided' });
        }
        const token = authHeader.split(' ')[1];
        if (!token) {
            return res.status(401).json({ success: false, message: 'Unauthorized: Token is empty' });
        }
        const decoded = jwt.verify(token, env.JWT_SECRET);
        const user = await prisma.user.findUnique({
            where: { id: decoded.id },
            select: { id: true, email: true, role: true, isVerified: true },
        });
        if (!user) {
            return res.status(401).json({ success: false, message: 'Unauthorized: User not found' });
        }
        req.user = user;
        return next();
    }
    catch (error) {
        if (error instanceof jwt.TokenExpiredError) {
            return res.status(401).json({ success: false, message: 'Unauthorized: Token expired' });
        }
        return res.status(401).json({ success: false, message: 'Unauthorized: Invalid token' });
    }
};
export const authorize = (...roles) => {
    return (req, res, next) => {
        if (!req.user) {
            return res.status(401).json({ success: false, message: 'Unauthorized' });
        }
        if (!roles.includes(req.user.role)) {
            return res.status(403).json({
                success: false,
                message: 'Forbidden: You do not have permission to perform this action',
            });
        }
        return next();
    };
};
