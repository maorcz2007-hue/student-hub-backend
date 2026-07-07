const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.getCourses = async (req, res) => {
  try {
    const userId = req.user.id;

    const enrollments = await prisma.enrollment.findMany({
      where: { studentId: userId },
      include: {
        course: {
          include: {
            schedules: true
          }
        }
      }
    });

    const courses = enrollments.map(e => ({
      ...e.course,
      status: e.status,
      semester: e.semester,
      enrolledAt: e.enrolledAt
    }));

    res.json(courses);
  } catch (error) {
    console.error('Error fetching courses:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.addCourse = async (req, res) => {
  try {
    const userId = req.user.id;
    const { name, code, credits, description, semester } = req.body;

    // See if course already exists globally
    let course = await prisma.course.findUnique({
      where: { code }
    });

    // If it doesn't exist, create it (student is acting as creator/teacher for now)
    if (!course) {
      course = await prisma.course.create({
        data: {
          name,
          code,
          credits: parseInt(credits) || 3,
          description,
          teacherId: userId,
        }
      });
    }

    // Enroll the student
    const enrollment = await prisma.enrollment.create({
      data: {
        studentId: userId,
        courseId: course.id,
        semester: semester || 'Current',
        status: 'ACTIVE'
      }
    });

    res.status(201).json({ ...course, status: enrollment.status, semester: enrollment.semester });
  } catch (error) {
    console.error('Error adding course:', error);
    if (error.code === 'P2002') {
      return res.status(400).json({ message: 'You are already enrolled in this course' });
    }
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.deleteCourse = async (req, res) => {
  try {
    const userId = req.user.id;
    const { id } = req.params;

    await prisma.enrollment.delete({
      where: {
        studentId_courseId: {
          studentId: userId,
          courseId: id
        }
      }
    });

    res.json({ message: 'Unenrolled successfully' });
  } catch (error) {
    console.error('Error deleting course:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
