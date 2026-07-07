const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

exports.getDashboardData = async (req, res) => {
  try {
    const userId = req.user.id;

    // 1. Get Enrollments & Courses
    const enrollments = await prisma.enrollment.findMany({
      where: { studentId: userId, status: 'ACTIVE' },
      include: {
        course: {
          include: { schedules: true }
        }
      }
    });

    const courseIds = enrollments.map(e => e.courseId);
    const totalCredits = enrollments.reduce((sum, e) => sum + e.course.credits, 0);

    // 2. Get Upcoming Deadlines
    const upcomingDeadlines = await prisma.assignment.findMany({
      where: {
        courseId: { in: courseIds },
        dueDate: { gte: new Date() }
      },
      orderBy: { dueDate: 'asc' },
      take: 5,
      include: {
        course: { select: { name: true } },
        submissions: { where: { studentId: userId } }
      }
    });

    // 3. Get Grades to calculate GPA
    const grades = await prisma.grade.findMany({
      where: { studentId: userId }
    });

    let gpa = 0;
    if (grades.length > 0) {
      const totalScore = grades.reduce((sum, g) => sum + (g.score / g.maxScore), 0);
      gpa = ((totalScore / grades.length) * 4.0).toFixed(2);
    } else {
      gpa = 4.0; // Default if no grades
    }

    // 4. Build Today's Schedule
    const today = new Date().getDay(); // 0 is Sunday, 1 is Monday...
    const todaySchedule = [];
    enrollments.forEach(e => {
      e.course.schedules.forEach(s => {
        // Assuming dayOfWeek is 1-7 (Mon-Sun)
        let scheduleDay = s.dayOfWeek;
        if (scheduleDay === 7) scheduleDay = 0; // Convert Sunday to 0 to match JS Date.getDay()
        
        if (scheduleDay === today) {
          todaySchedule.push({
            id: s.id,
            name: e.course.name,
            time: `${s.startTime} - ${s.endTime}`,
            location: s.room,
            // Mocking color based on string length just for UI variety
            colorValue: e.course.name.length % 2 === 0 ? 0xFF1E88E5 : 0xFF8E24AA,
            isNow: false // Real logic would compare current time
          });
        }
      });
    });

    // Sort schedule by start time
    todaySchedule.sort((a, b) => a.time.localeCompare(b.time));

    // Map deadlines to the expected format
    const deadlinesFormatted = upcomingDeadlines.map(d => {
      const isSubmitted = d.submissions && d.submissions.length > 0;
      const daysUntil = Math.ceil((new Date(d.dueDate) - new Date()) / (1000 * 60 * 60 * 24));
      
      return {
        id: d.id,
        title: d.title,
        due: daysUntil === 0 ? 'Due Today' : daysUntil === 1 ? 'Due Tomorrow' : `Due in ${daysUntil} days`,
        colorValue: daysUntil <= 1 ? 0xFFE53935 : (daysUntil <= 3 ? 0xFFFB8C00 : 0xFF1E88E5),
        progress: isSubmitted ? 1.0 : 0.0,
      };
    });

    // Send the aggregated data
    res.json({
      gpa: parseFloat(gpa),
      academicStanding: gpa >= 3.5 ? "Dean's List" : gpa >= 2.0 ? "Good Standing" : "Probation",
      completedCredits: 0, // Mocked for now
      totalCredits: 120, // Mocked for now
      semesterCreditsCompleted: 0,
      semesterCreditsTotal: totalCredits,
      pendingTasks: upcomingDeadlines.length,
      avgGrade: gpa * 25, // Mocked 100 scale conversion
      activeCourses: enrollments.length,
      studyTimeHours: 12, // Mocked for now
      todaySchedule,
      upcomingDeadlines: deadlinesFormatted,
      gradeTrend: [
        { monthIndex: 0, score: 85 },
        { monthIndex: 1, score: 88 },
        { monthIndex: 2, score: 90 },
      ],
      aiSuggestion: upcomingDeadlines.length > 0 
        ? `Focus on ${upcomingDeadlines[0].course.name} today — your ${upcomingDeadlines[0].title} is due soon.`
        : 'You have no upcoming deadlines. Great job!'
    });
  } catch (error) {
    console.error('Error fetching dashboard data:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
