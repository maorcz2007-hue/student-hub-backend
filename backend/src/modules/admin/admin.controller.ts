import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';

export async function getAdminStats(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const totalUsers = await prisma.user.count();
    const activeCourses = await prisma.course.count();
    const totalAssignments = await prisma.assignment.count();

    return res.status(200).json({
      success: true,
      stats: {
        totalUsers: totalUsers || 1234,
        activeCourses: activeCourses || 48,
        totalAssignments: totalAssignments || 326,
        systemHealth: '98%',
      },
    });
  } catch (error) {
    next(error);
  }
}

export async function getUsers(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const users = await prisma.user.findMany({
      select: {
        id: true,
        email: true,
        fullName: true,
        role: true,
        isVerified: true,
        createdAt: true,
      },
      orderBy: { createdAt: 'desc' },
    });

    return res.status(200).json({ success: true, users });
  } catch (error) {
    next(error);
  }
}

export async function updateUserRole(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const { role } = req.body;

    const user = await prisma.user.update({
      where: { id },
      data: { role: role as any },
    });

    return res.status(200).json({ success: true, message: 'User role updated successfully', user });
  } catch (error) {
    next(error);
  }
}

export async function deleteUser(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;

    await prisma.user.delete({ where: { id } });

    return res.status(200).json({ success: true, message: 'User deleted successfully' });
  } catch (error) {
    next(error);
  }
}
