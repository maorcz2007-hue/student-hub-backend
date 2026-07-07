import { z } from 'zod';
export const registerSchema = z.object({
    body: z.object({
        email: z.string().email('Invalid email address'),
        password: z.string().min(8, 'Password must be at least 8 characters'),
        fullName: z.string().min(2, 'Name must be at least 2 characters'),
        studentId: z.string().optional(),
        role: z.enum(['STUDENT', 'TEACHER', 'ADMIN']).optional(),
    }),
});
export const loginSchema = z.object({
    body: z.object({
        email: z.string().email('Invalid email address'),
        password: z.string().min(1, 'Password is required'),
    }),
});
export const refreshTokenSchema = z.object({
    body: z.object({
        refreshToken: z.string().min(1, 'Refresh token is required'),
    }),
});
export const forgotPasswordSchema = z.object({
    body: z.object({
        email: z.string().email('Invalid email address'),
    }),
});
export const resetPasswordSchema = z.object({
    body: z.object({
        token: z.string().min(1, 'Token is required'),
        newPassword: z.string().min(8, 'Password must be at least 8 characters'),
    }),
});
