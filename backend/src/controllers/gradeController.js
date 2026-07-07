const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.getGrades = async (req, res) => {
  try {
    const student = await prisma.student.findUnique({
      where: { userId: req.user.id },
    });

    if (!student) {
      return res.status(404).json({ message: 'Student profile not found' });
    }

    const grades = await prisma.grade.findMany({
      where: { studentId: student.userId },
      include: {
        course: true,
        assignment: true,
      },
      orderBy: { gradedAt: 'desc' },
    });

    res.json(grades);
  } catch (error) {
    console.error('Error fetching grades:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};
