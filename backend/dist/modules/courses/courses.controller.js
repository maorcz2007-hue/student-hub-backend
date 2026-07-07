import { prisma } from '../../config/database.js';
export async function getCourses(req, res, next) {
    try {
        const studentId = req.user?.id;
        // Fetch active enrollments
        const enrollments = await prisma.enrollment.findMany({
            where: { studentId, status: 'ACTIVE' },
            include: {
                course: {
                    include: {
                        schedules: true,
                    },
                },
            },
        });
        if (enrollments.length === 0) {
            // Mock courses data if database is empty for easy dev onboarding
            const mockCourses = [
                { id: '1', name: 'Data Structures', code: 'CS201', teacher: 'Dr. Smith', credits: 4, colorValue: 0xFF007AFF, progress: 0.75 },
                { id: '2', name: 'Linear Algebra', code: 'MATH301', teacher: 'Prof. Johnson', credits: 3, colorValue: 0xFF5856D6, progress: 0.60 },
                { id: '3', name: 'Physics II', code: 'PHY202', teacher: 'Dr. Williams', credits: 4, colorValue: 0xFF34C759, progress: 0.55 },
                { id: '4', name: 'AI Fundamentals', code: 'CS401', teacher: 'Prof. Chen', credits: 3, colorValue: 0xFFFF9500, progress: 0.80 },
                { id: '5', name: 'Web Development', code: 'CS301', teacher: 'Dr. Brown', credits: 3, colorValue: 0xFF5AC8FA, progress: 0.45 },
                { id: '6', name: 'Calculus II', code: 'MATH202', teacher: 'Prof. Davis', credits: 4, colorValue: 0xFFFF2D55, progress: 0.65 },
            ];
            return res.status(200).json({ success: true, courses: mockCourses });
        }
        const formatted = enrollments.map((e) => {
            // Pick color scheme based on course credits or code prefix
            const colors = [0xFF007AFF, 0xFF5856D6, 0xFF34C759, 0xFFFF9500, 0xFF5AC8FA, 0xFFFF2D55];
            const colorValue = colors[Math.abs(e.course.name.charCodeAt(0)) % colors.length];
            return {
                id: e.course.id,
                name: e.course.name,
                code: e.course.code,
                teacher: 'Professor', // Replace with real teacher mapping if needed
                credits: e.course.credits,
                colorValue,
                progress: 0.60, // UI default progress
                schedules: e.course.schedules,
            };
        });
        return res.status(200).json({ success: true, courses: formatted });
    }
    catch (error) {
        next(error);
    }
}
export async function getCourseById(req, res, next) {
    try {
        const { id } = req.params;
        const course = await prisma.course.findUnique({
            where: { id },
            include: {
                schedules: true,
                assignments: {
                    orderBy: { dueDate: 'asc' },
                },
            },
        });
        if (!course) {
            return res.status(404).json({ success: false, message: 'Course not found' });
        }
        return res.status(200).json({ success: true, course });
    }
    catch (error) {
        next(error);
    }
}
export async function getCourseResources(req, res, next) {
    try {
        const { id } = req.params;
        // Query course-specific files in files table where folder is course ID
        const resources = await prisma.file.findMany({
            where: { folder: id },
        });
        return res.status(200).json({ success: true, resources });
    }
    catch (error) {
        next(error);
    }
}
