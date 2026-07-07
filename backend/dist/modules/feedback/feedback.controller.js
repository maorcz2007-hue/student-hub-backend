import { prisma } from '../../config/database.js';
export async function submitFeedback(req, res, next) {
    try {
        const userId = req.user?.id;
        const { type, title, description, rating } = req.body;
        if (!title || !description) {
            return res.status(400).json({ success: false, message: 'Title and description are required' });
        }
        const feedback = await prisma.feedback.create({
            data: {
                userId: userId,
                type: type || 'SUGGESTION',
                title,
                description,
                rating: rating ? parseInt(rating, 10) : undefined,
            },
        });
        return res.status(201).json({ success: true, message: 'Feedback submitted successfully', feedback });
    }
    catch (error) {
        next(error);
    }
}
export async function getFeedbacks(req, res, next) {
    try {
        // Only admins can see feedback list
        if (req.user?.role !== 'ADMIN') {
            return res.status(403).json({ success: false, message: 'Forbidden: Access denied' });
        }
        const feedbacks = await prisma.feedback.findMany({
            orderBy: { createdAt: 'desc' },
            include: {
                user: { select: { fullName: true, email: true } },
            },
        });
        return res.status(200).json({ success: true, feedbacks });
    }
    catch (error) {
        next(error);
    }
}
