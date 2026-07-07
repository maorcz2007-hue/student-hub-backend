import { Redis } from 'ioredis';
import { env } from './environment.js';
import { logger } from '../utils/logger.js';
export let redis;
export function connectRedis() {
    try {
        redis = new Redis(env.REDIS_URL, {
            maxRetriesPerRequest: 3,
            retryStrategy(times) {
                const delay = Math.min(times * 50, 2000);
                return delay;
            },
        });
        redis.on('connect', () => {
            logger.info('Connected to Redis successfully.');
        });
        redis.on('error', (err) => {
            logger.error('Redis Client Error:', err);
        });
    }
    catch (error) {
        logger.error('Could not initialize Redis client:', error);
    }
}
