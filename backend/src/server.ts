import http from 'http';
import { Server } from 'socket.io';
import app from './app.js';
import { env } from './config/environment.js';
import { connectDB } from './config/database.js';
import { connectRedis } from './config/redis.js';
import { logger } from './utils/logger.js';

const server = http.createServer(app);

// Initialize Socket.IO with CORS settings
const io = new Server(server, {
  cors: {
    origin: env.ALLOWED_ORIGINS,
    methods: ['GET', 'POST'],
    credentials: true,
  },
});

// Simple real-time socket handler
io.on('connection', (socket) => {
  logger.info(`Socket connected: ${socket.id}`);

  socket.on('join_room', (room) => {
    socket.join(room);
    logger.debug(`Socket ${socket.id} joined room: ${room}`);
  });

  socket.on('send_message', (data) => {
    // data: { conversationId, content, senderId }
    io.to(data.conversationId).emit('new_message', data);
    logger.debug(`Broadcasted message in room: ${data.conversationId}`);
  });

  socket.on('disconnect', () => {
    logger.info(`Socket disconnected: ${socket.id}`);
  });
});

async function startServer() {
  await connectDB();
  connectRedis();

  server.listen(env.PORT, () => {
    logger.info(`Server is running in ${env.NODE_ENV} mode on port ${env.PORT}`);
  });
}

// Handle unhandled rejections/exceptions
process.on('unhandledRejection', (err: any) => {
  logger.error('UNHANDLED REJECTION! Shutting down...');
  logger.error(err);
  server.close(() => {
    process.exit(1);
  });
});

process.on('uncaughtException', (err: any) => {
  logger.error('UNCAUGHT EXCEPTION! Shutting down...');
  logger.error(err);
  process.exit(1);
});

startServer();
