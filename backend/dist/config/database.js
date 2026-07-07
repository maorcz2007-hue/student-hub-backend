import { PrismaClient } from '@prisma/client';
import { logger } from '../utils/logger.js';
export const prisma = new PrismaClient({
    log: [
        { level: 'query', emit: 'event' },
        { level: 'info', emit: 'stdout' },
        { level: 'warn', emit: 'stdout' },
        { level: 'error', emit: 'stdout' },
    ],
});
// Log prisma queries in development
if (process.env.NODE_ENV === 'development') {
    // @ts-ignore
    prisma.$on('query', (e) => {
        logger.debug(`Query: ${e.query} - Params: ${e.params} - Duration: ${e.duration}ms`);
    });
}
export async function connectDB() {
    try {
        await prisma.$connect();
        logger.info('Connected to PostgreSQL successfully.');
    }
    catch (error) {
        logger.error('Failed to connect to PostgreSQL database:', error);
        process.exit(1);
    }
}
