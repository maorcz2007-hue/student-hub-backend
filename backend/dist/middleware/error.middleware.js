import { logger } from '../utils/logger.js';
export function errorMiddleware(err, req, res, next) {
    const statusCode = err.statusCode || 500;
    const message = err.message || 'Internal Server Error';
    // Log error
    logger.error({
        msg: message,
        stack: err.stack,
        path: req.path,
        method: req.method,
        statusCode,
        details: err.details,
    });
    res.status(statusCode).json({
        success: false,
        message,
        ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
        ...(err.details && { details: err.details }),
    });
}
