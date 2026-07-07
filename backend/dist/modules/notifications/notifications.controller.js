import { prisma } from '../../config/database.js';
export async function getNotifications(req, res, next) {
    try {
        const userId = req.user?.id;
        const notifications = await prisma.notification.findMany({
            where: { userId },
            orderBy: { createdAt: 'desc' },
            take: 20,
        });
        if (notifications.length === 0) {
            // Mock notifications if DB is empty for easy dev onboarding
            const mockNotifications = [
                { id: '1', title: 'New Grade Posted', body: 'Data Structures HW2: A (96%)', isRead: false, createdAt: new Date().toISOString() },
                { id: '2', title: 'Assignment Due', body: 'Data Structures HW3 is due tomorrow', isRead: false, createdAt: new Date(Date.now() - 2 * 3600 * 1000).toISOString() },
                { id: '3', title: 'New Message', body: 'Dr. Smith sent you a message', isRead: true, createdAt: new Date(Date.now() - 5 * 3600 * 1000).toISOString() },
            ];
            return res.status(200).json({ success: true, notifications: mockNotifications });
        }
        return res.status(200).json({ success: true, notifications });
    }
    catch (error) {
        next(error);
    }
}
export async function markAsRead(req, res, next) {
    try {
        const { id } = req.params;
        const userId = req.user?.id;
        const notification = await prisma.notification.findFirst({
            where: { id, userId },
        });
        if (!notification) {
            return res.status(404).json({ success: false, message: 'Notification not found or unauthorized' });
        }
        await prisma.notification.update({
            where: { id },
            data: { isRead: true },
        });
        return res.status(200).json({ success: true, message: 'Notification marked as read' });
    }
    catch (error) {
        next(error);
    }
}
export async function markAllRead(req, res, next) {
    try {
        const userId = req.user?.id;
        await prisma.notification.updateMany({
            where: { userId, isRead: false },
            data: { isRead: true },
        });
        return res.status(200).json({ success: true, message: 'All notifications marked as read' });
    }
    catch (error) {
        next(error);
    }
}
