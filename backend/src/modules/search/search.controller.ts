import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';

export async function searchEverything(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const userId = req.user?.id;
    const { query } = req.query;

    if (!query) {
      return res.status(400).json({ success: false, message: 'Search query is required' });
    }

    const searchQuery = String(query);

    // Search assignments
    const assignments = await prisma.assignment.findMany({
      where: {
        OR: [
          { title: { contains: searchQuery, mode: 'insensitive' } },
          { description: { contains: searchQuery, mode: 'insensitive' } },
        ],
      },
      include: { course: { select: { name: true } } },
      take: 5,
    });

    // Search courses
    const courses = await prisma.course.findMany({
      where: {
        OR: [
          { name: { contains: searchQuery, mode: 'insensitive' } },
          { code: { contains: searchQuery, mode: 'insensitive' } },
        ],
      },
      take: 5,
    });

    // Search files
    const files = await prisma.file.findMany({
      where: {
        userId,
        name: { contains: searchQuery, mode: 'insensitive' },
      },
      take: 5,
    });

    // Format unified search results
    const results = [
      ...assignments.map((a: any) => ({
        id: a.id,
        title: a.title,
        type: 'Assignment',
        subtitle: a.course.name,
      })),
      ...courses.map((c: any) => ({
        id: c.id,
        title: c.name,
        type: 'Course',
        subtitle: c.code,
      })),
      ...files.map((f: any) => ({
        id: f.id,
        title: f.name,
        type: 'File',
        subtitle: `${f.mimeType} • ${(f.size / 1024).toFixed(1)} KB`,
      })),
    ];

    return res.status(200).json({ success: true, results });
  } catch (error) {
    next(error);
  }
}
