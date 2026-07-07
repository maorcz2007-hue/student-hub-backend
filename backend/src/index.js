require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors({
  origin: ['http://localhost:3000', 'http://127.0.0.1:3000'],
  credentials: true,
}));
app.use(express.json());

// Routes
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const courseRoutes = require('./routes/courseRoutes');
const assignmentRoutes = require('./routes/assignmentRoutes');
const dashboardRoutes = require('./routes/dashboardRoutes');
const gradeRoutes = require('./routes/gradeRoutes');
const calendarRoutes = require('./routes/calendarRoutes');

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/courses', courseRoutes);
app.use('/api/assignments', assignmentRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/grades', gradeRoutes);
app.use('/api/calendar', calendarRoutes);

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ status: 'API is running' });
});

// 404 Handler
app.use((req, res, next) => {
  res.status(404).json({ message: 'Endpoint not found' });
});

// Global Error Handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Internal Server Error' });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
