import { Redis } from 'ioredis';
import { env } from './environment.js';
import { logger } from '../utils/logger.js';

export let redis: Redis;

export function connectRedis() {
  try {
    redis = new Redis(env.REDIS_URL, {
      maxRetriesPerRequest: 3,
      retryStrategy(times: number) {
        const delay = Math.min(times * 50, 2000);
        return delay;
      },
    });

    redis.on('connect', () => {
      logger.info('Connected to Redis successfully.');
    });

    redis.on('error', (err: any) => {
      logger.error('Redis Client Error:', err);
    });
  } catch (error) {
    logger.error('Could not initialize Redis client:', error);
  }
}
