import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load environment variables from .env file
dotenv.config({ path: path.join(__dirname, '../../../.env') });

export const env = {
  NODE_ENV: process.env.NODE_ENV || 'development',
  PORT: parseInt(process.env.PORT || '3000', 10),
  DATABASE_URL: process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/studenthub?schema=public',
  REDIS_URL: process.env.REDIS_URL || 'redis://localhost:6379',
  JWT_SECRET: process.env.JWT_SECRET || 'super_secret_access_key_123_456',
  JWT_REFRESH_SECRET: process.env.JWT_REFRESH_SECRET || 'super_secret_refresh_key_789_101',
  JWT_EXPIRES_IN: process.env.JWT_EXPIRES_IN || '15m',
  JWT_REFRESH_EXPIRES_IN: process.env.JWT_REFRESH_EXPIRES_IN || '7d',
  OPENAI_API_KEY: process.env.OPENAI_API_KEY || '',
  GEMINI_API_KEY: process.env.GEMINI_API_KEY || '',
  CLAUDE_API_KEY: process.env.CLAUDE_API_KEY || '',
  ALLOWED_ORIGINS: (process.env.ALLOWED_ORIGINS || 'http://localhost:3000,http://localhost:8080').split(','),
  UPLOAD_DIR: process.env.UPLOAD_DIR || path.join(__dirname, '../../../uploads'),
};
