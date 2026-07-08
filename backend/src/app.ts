import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import path from 'path';
import { env } from './config/environment.js';
import { apiLimiter } from './middleware/rate-limit.middleware.js';
import { errorMiddleware } from './middleware/error.middleware.js';
import authRoutes from './modules/auth/auth.routes.js';
import dashboardRoutes from './modules/dashboard/dashboard.routes.js';
import usersRoutes from './modules/users/users.routes.js';
import assignmentsRoutes from './modules/assignments/assignments.routes.js';
import gradesRoutes from './modules/grades/grades.routes.js';
import calendarRoutes from './modules/calendar/calendar.routes.js';
import coursesRoutes from './modules/courses/courses.routes.js';
import aiRoutes from './modules/ai/ai.routes.js';
import messagesRoutes from './modules/messages/messages.routes.js';
import adminRoutes from './modules/admin/admin.routes.js';
import notificationsRoutes from './modules/notifications/notifications.routes.js';
import searchRoutes from './modules/search/search.routes.js';
import filesRoutes from './modules/files/files.routes.js';
import feedbackRoutes from './modules/feedback/feedback.routes.js';
const app = express();

// Security Middlewares
app.use(helmet());
app.use(
  cors({
    origin: env.ALLOWED_ORIGINS,
    credentials: true,
  })
);

// Body parsers
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Global Rate Limiter
app.use('/api/', apiLimiter);

// Static assets (For uploads/avatars)
app.use('/uploads', express.static(env.UPLOAD_DIR));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/assignments', assignmentsRoutes);
app.use('/api/grades', gradesRoutes);
app.use('/api/calendar', calendarRoutes);
app.use('/api/courses', coursesRoutes);
app.use('/api/ai', aiRoutes);
app.use('/api/messages', messagesRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/notifications', notificationsRoutes);
app.use('/api/search', searchRoutes);
app.use('/api/files', filesRoutes);
app.use('/api/feedback', feedbackRoutes);

// Health check
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Resource not found' });
});

// Global Error Handler
app.use(errorMiddleware);

export default app;
