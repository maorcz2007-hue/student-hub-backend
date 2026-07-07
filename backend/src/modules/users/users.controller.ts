import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';
import { logger } from '../../utils/logger.js';

export async function getProfile(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  try {
    const userId = req.user?.id;

    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        studentProfile: true,
        userSettings: true,
      },
    });

    if (!user) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }

    return res.status(200).json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        role: user.role,
        avatarUrl: user.avatarUrl,
        studentId: user.studentProfile?.studentId,
        university: user.studentProfile?.university,
        faculty: user.studentProfile?.faculty,
        department: user.studentProfile?.department,
        year: user.studentProfile?.year,
        semester: user.studentProfile?.semester,
        bio: user.studentProfile?.bio,
        settings: user.userSettings,
      },
    });
  } catch (error) {
    next(error);
  }
}

export async function updateProfile(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  try {
    const userId = req.user?.id;
    const { fullName, nickname, bio, university, faculty, department, year, semester } = req.body;

    const updatedUser = await prisma.$transaction(async (tx: any) => {
      const user = await tx.user.update({
        where: { id: userId },
        data: {
          fullName,
        },
      });

      if (user.role === 'STUDENT') {
        await tx.student.update({
          where: { userId },
          data: {
            bio,
            university,
            faculty,
            department,
            year: year ? parseInt(year, 10) : undefined,
            semester: semester ? parseInt(semester, 10) : undefined,
          },
        });
      }

      return user;
    });

    logger.info(`Profile updated for user: ${userId}`);

    return res.status(200).json({
      success: true,
      message: 'Profile updated successfully',
    });
  } catch (error) {
    next(error);
  }
}

export async function getSettings(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  try {
    const userId = req.user?.id;
    const settings = await prisma.userSettings.findUnique({
      where: { userId },
    });

    return res.status(200).json({ success: true, settings });
  } catch (error) {
    next(error);
  }
}

export async function updateSettings(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  try {
    const userId = req.user?.id;
    const { theme, themeColor, language, pushEnabled, emailEnabled } = req.body;

    const settings = await prisma.userSettings.update({
      where: { userId },
      data: {
        theme,
        themeColor,
        language,
        pushEnabled,
        emailEnabled,
      },
    });

    return res.status(200).json({ success: true, settings });
  } catch (error) {
    next(error);
  }
}
