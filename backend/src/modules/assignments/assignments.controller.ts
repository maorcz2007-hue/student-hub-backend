import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../../middleware/auth.middleware.js';
import { prisma } from '../../config/database.js';

export async function getAssignments(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const studentId = req.user?.id;
    const { category, priority, status } = req.query;

    // Fetch student active enrollments
    const enrollments = await prisma.enrollment.findMany({
      where: { studentId, status: 'ACTIVE' },
      select: { courseId: true },
    });
    const courseIds = enrollments.map((e: any) => e.courseId);

    const assignments = await prisma.assignment.findMany({
      where: {
        courseId: { in: courseIds },
        ...(category && { type: category as any }),
        ...(priority && { priority: priority as any }),
      },
      include: {
        course: { select: { name: true } },
        submissions: {
          where: { studentId },
        },
      },
      orderBy: { dueDate: 'asc' },
    });

    // Format list for UI
    const formatted = assignments.map((a: any) => {
      const sub = a.submissions[0];
      return {
        id: a.id,
        title: a.title,
        description: a.description,
        course: a.course.name,
        dueDate: a.dueDate.toISOString(),
        priority: a.priority.toLowerCase(),
        completed: sub?.status === 'SUBMITTED' || sub?.status === 'GRADED',
        progress: sub?.score ? sub.score / a.maxScore : 0.0,
      };
    });

    return res.status(200).json({ success: true, assignments: formatted });
  } catch (error) {
    next(error);
  }
}

export async function createAssignment(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { title, description, courseId, dueDate, priority, type, maxScore } = req.body;

    const assignment = await prisma.assignment.create({
      data: {
        title,
        description,
        courseId,
        dueDate: new Date(dueDate),
        priority: priority as any,
        type: type as any,
        maxScore: maxScore ? parseInt(maxScore, 10) : 100,
      },
    });

    return res.status(201).json({ success: true, assignment });
  } catch (error) {
    next(error);
  }
}

export async function getAssignmentById(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const studentId = req.user?.id;

    const assignment = await prisma.assignment.findUnique({
      where: { id },
      include: {
        course: { select: { name: true } },
        submissions: { where: { studentId } },
      },
    });

    if (!assignment) {
      return res.status(404).json({ success: false, message: 'Assignment not found' });
    }

    const sub = assignment.submissions[0];
    const formatted = {
      id: assignment.id,
      title: assignment.title,
      description: assignment.description,
      course: assignment.course.name,
      dueDate: assignment.dueDate.toISOString(),
      priority: assignment.priority.toLowerCase(),
      estimatedTime: assignment.estimatedTime,
      teacherNotes: assignment.teacherNotes,
      completed: sub?.status === 'SUBMITTED' || sub?.status === 'GRADED',
      progress: sub?.score ? sub.score / assignment.maxScore : 0.0,
      submission: sub,
    };

    return res.status(200).json({ success: true, assignment: formatted });
  } catch (error) {
    next(error);
  }
}

export async function submitAssignment(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const studentId = req.user?.id;
    const { attachments } = req.body;

    const submission = await prisma.assignmentSubmission.upsert({
      where: {
        assignmentId_studentId: {
          assignmentId: id,
          studentId: studentId!,
        },
      },
      update: {
        status: 'SUBMITTED',
        submittedAt: new Date(),
        attachments,
      },
      create: {
        assignmentId: id,
        studentId: studentId!,
        status: 'SUBMITTED',
        submittedAt: new Date(),
        attachments,
      },
    });

    return res.status(200).json({ success: true, submission });
  } catch (error) {
    next(error);
  }
}
