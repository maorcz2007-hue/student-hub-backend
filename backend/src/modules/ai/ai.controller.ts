import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';
import { logger } from '../../utils/logger.js';

export async function chatWithAI(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const studentId = req.user?.id;
    const { message, provider } = req.body;

    if (!message) {
      return res.status(400).json({ success: false, message: 'Message is required' });
    }

    // Default provider is GEMINI or OPENAI
    const aiProvider = provider || 'GEMINI';
    logger.info(`AI chat request using provider: ${aiProvider}`);

    let aiResponseText = '';

    // Generate intelligent academic mock responses based on input questions
    const msgLower = message.toLowerCase();
    if (msgLower.includes('bst') || msgLower.includes('binary search tree')) {
      aiResponseText = 'A Binary Search Tree (BST) is a node-based binary tree data structure where each node has at most two children. The left subtree of a node contains only nodes with keys lesser than the node’s key, and the right subtree contains only nodes with keys greater than the node’s key. Insertion and lookup take O(log n) on average.';
    } else if (msgLower.includes('study plan') || msgLower.includes('schedule')) {
      aiResponseText = 'Based on your upcoming deadlines, here is a suggested study plan:\n1. Today (2h): Work on Data Structures HW3 (Implement BST insertion/traversal).\n2. Tomorrow (1.5h): Review Linear Algebra Chapter 4.\n3. Friday (2h): Draft the Physics Lab report.';
    } else if (msgLower.includes('quiz') || msgLower.includes('test')) {
      aiResponseText = 'Let\'s do a quick quiz on Data Structures!\nQuestion: What is the worst-case time complexity of searching in a BST?\nA) O(1)\nB) O(log n)\nC) O(n)\nReply with your answer and I\'ll grade it!';
    } else {
      aiResponseText = `I received your message: "${message}". I can help you summarize lecture notes, explain assignments, suggest study schedules, or generate quizzes. Let me know what academic topic you want to cover!`;
    }

    // Persist conversation history to database
    const history = await prisma.aIHistory.create({
      data: {
        studentId: studentId!,
        messages: [
          { role: 'user', content: message, timestamp: new Date().toISOString() },
          { role: 'assistant', content: aiResponseText, timestamp: new Date().toISOString() },
        ],
        provider: aiProvider,
        model: 'gemini-1.5-flash',
      },
    });

    return res.status(200).json({
      success: true,
      response: aiResponseText,
      historyId: history.id,
    });
  } catch (error) {
    next(error);
  }
}

export async function getAIHistory(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const studentId = req.user?.id;
    const history = await prisma.aIHistory.findMany({
      where: { studentId },
      orderBy: { createdAt: 'desc' },
      take: 10,
    });

    return res.status(200).json({ success: true, history });
  } catch (error) {
    next(error);
  }
}
