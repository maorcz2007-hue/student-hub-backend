import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';

export async function getEvents(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const userId = req.user?.id;

    // Fetch personal and academic events
    const events = await prisma.calendarEvent.findMany({
      where: { userId },
      orderBy: { startTime: 'asc' },
    });

    // Also fetch class schedules to display on the calendar
    const enrollments = await prisma.enrollment.findMany({
      where: { studentId: userId, status: 'ACTIVE' },
      select: { courseId: true },
    });
    const courseIds = enrollments.map((e: any) => e.courseId);

    const classSchedules = await prisma.courseSchedule.findMany({
      where: { courseId: { in: courseIds } },
      include: { course: { select: { name: true } } },
    });

    // Format all events
    const formattedEvents = [
      ...events.map((e: any) => ({
        id: e.id,
        title: e.title,
        description: e.description,
        startTime: e.startTime.toISOString(),
        endTime: e.endTime.toISOString(),
        type: e.type.toLowerCase(),
      })),
      ...classSchedules.map((s: any) => ({
        id: s.id,
        title: s.course.name,
        description: `Regular class at Room ${s.room}`,
        // Calculate dynamic dates for current week or mock static format
        startTime: new Date().toISOString(), 
        endTime: new Date().toISOString(),
        type: 'class',
      })),
    ];

    return res.status(200).json({ success: true, events: formattedEvents });
  } catch (error) {
    next(error);
  }
}

export async function createEvent(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const userId = req.user?.id;
    const { title, description, startTime, endTime, type, courseId, reminderMinutes } = req.body;

    const event = await prisma.calendarEvent.create({
      data: {
        userId: userId!,
        title,
        description,
        startTime: new Date(startTime),
        endTime: new Date(endTime),
        type: type || 'PERSONAL',
        courseId,
        reminderMinutes: reminderMinutes ? parseInt(reminderMinutes, 10) : undefined,
      },
    });

    return res.status(201).json({ success: true, event });
  } catch (error) {
    next(error);
  }
}

export async function deleteEvent(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const userId = req.user?.id;

    const event = await prisma.calendarEvent.findFirst({
      where: { id, userId },
    });

    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found or unauthorized' });
    }

    await prisma.calendarEvent.delete({ where: { id } });

    return res.status(200).json({ success: true, message: 'Event deleted successfully' });
  } catch (error) {
    next(error);
  }
}
