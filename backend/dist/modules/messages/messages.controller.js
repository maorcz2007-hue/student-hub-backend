import { prisma } from '../../config/database.js';
export async function getConversations(req, res, next) {
    try {
        const userId = req.user?.id;
        // Fetch conversation memberships
        const memberships = await prisma.messageParticipant.findMany({
            where: { userId },
            include: {
                conversation: {
                    include: {
                        participants: {
                            include: {
                                user: {
                                    select: { id: true, fullName: true, avatarUrl: true },
                                },
                            },
                        },
                        messages: {
                            orderBy: { createdAt: 'desc' },
                            take: 1,
                        },
                    },
                },
            },
        });
        if (memberships.length === 0) {
            // Mock conversations for easier dev onboarding
            const mockConversations = [
                { id: '1', name: 'Study Group CS201', lastMessage: 'Alex: Did anyone finish the BST?', time: new Date().toISOString(), unread: 3, isGroup: true },
                { id: '2', name: 'Dr. Smith', lastMessage: 'Your assignment has been graded', time: new Date(Date.now() - 2 * 3600 * 1000).toISOString(), unread: 1, isGroup: false },
                { id: '3', name: 'Sarah Johnson', lastMessage: 'Thanks for the notes!', time: new Date(Date.now() - 5 * 3600 * 1000).toISOString(), unread: 0, isGroup: false },
            ];
            return res.status(200).json({ success: true, conversations: mockConversations });
        }
        const formatted = memberships.map((m) => {
            const conv = m.conversation;
            const lastMsg = conv.messages[0];
            const otherParticipants = conv.participants.filter((p) => p.userId !== userId);
            const isGroup = conv.type === 'GROUP';
            const name = isGroup ? conv.name : otherParticipants[0]?.user.fullName || 'Chat';
            return {
                id: conv.id,
                name,
                lastMessage: lastMsg?.content || 'No messages yet',
                time: lastMsg?.createdAt.toISOString() || conv.createdAt.toISOString(),
                unread: 0, // Simplify for demo/dev mode
                isGroup,
                isPinned: m.isPinned,
            };
        });
        return res.status(200).json({ success: true, conversations: formatted });
    }
    catch (error) {
        next(error);
    }
}
export async function createConversation(req, res, next) {
    try {
        const userId = req.user?.id;
        const { name, type, participantIds } = req.body;
        const ids = Array.from(new Set([userId, ...participantIds]));
        const conversation = await prisma.$transaction(async (tx) => {
            const conv = await tx.conversation.create({
                data: {
                    name: name || undefined,
                    type: type || 'PRIVATE',
                    createdBy: userId,
                },
            });
            // Add participants
            await tx.messageParticipant.createMany({
                data: ids.map((pId) => ({
                    conversationId: conv.id,
                    userId: pId,
                })),
            });
            return conv;
        });
        return res.status(201).json({ success: true, conversation });
    }
    catch (error) {
        next(error);
    }
}
export async function getConversationMessages(req, res, next) {
    try {
        const { id } = req.params;
        const userId = req.user?.id;
        // Check membership
        const membership = await prisma.messageParticipant.findUnique({
            where: {
                conversationId_userId: {
                    conversationId: id,
                    userId: userId,
                },
            },
        });
        if (!membership) {
            return res.status(403).json({ success: false, message: 'Forbidden: Not a chat participant' });
        }
        const messages = await prisma.message.findMany({
            where: { conversationId: id },
            orderBy: { createdAt: 'asc' },
            include: {
                sender: {
                    select: { id: true, fullName: true, avatarUrl: true },
                },
            },
        });
        return res.status(200).json({ success: true, messages });
    }
    catch (error) {
        next(error);
    }
}
