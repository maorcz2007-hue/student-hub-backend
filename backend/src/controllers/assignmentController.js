const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.getAssignments = async (req, res) => {
  try {
    const userId = req.user.id;

    // Get all assignments for courses the user is enrolled in
    const enrollments = await prisma.enrollment.findMany({
      where: { studentId: userId },
      select: { courseId: true }
    });
    
    const courseIds = enrollments.map(e => e.courseId);

    const assignments = await prisma.assignment.findMany({
      where: {
        courseId: { in: courseIds }
      },
      include: {
        course: { select: { name: true, code: true } },
        submissions: {
          where: { studentId: userId }
        }
      },
      orderBy: { dueDate: 'asc' }
    });

    res.json(assignments);
  } catch (error) {
    console.error('Error fetching assignments:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.addAssignment = async (req, res) => {
  try {
    const { courseId, title, description, dueDate, type, priority } = req.body;

    const assignment = await prisma.assignment.create({
      data: {
        courseId,
        title,
        description,
        dueDate: new Date(dueDate),
        type: type || 'HOMEWORK',
        priority: priority || 'MEDIUM',
      },
      include: {
        course: { select: { name: true, code: true } }
      }
    });

    res.status(201).json(assignment);
  } catch (error) {
    console.error('Error adding assignment:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.deleteAssignment = async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.assignment.delete({
      where: { id }
    });

    res.json({ message: 'Assignment deleted successfully' });
  } catch (error) {
    console.error('Error deleting assignment:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
