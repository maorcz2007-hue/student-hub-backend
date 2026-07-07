# Student Management Backend API

This is a production-ready Node.js REST API built with Express, PostgreSQL (via Prisma), and JWT authentication.

## Prerequisites
- Node.js (v18 or higher recommended)
- PostgreSQL running locally or in the cloud.

## Getting Started

1. **Install Dependencies**
   Navigate to the backend directory and install the packages:
   ```bash
   cd "d:\Students APK\backend"
   npm install
   ```

2. **Configure Database Connection**
   Open the `.env` file and update the `DATABASE_URL` with your actual PostgreSQL credentials.
   For example, if your password is `secret` and database is `student_management`:
   ```env
   DATABASE_URL="postgresql://postgres:secret@localhost:5432/student_management?schema=public"
   ```

3. **Initialize the Database Schema**
   Run Prisma's db push command to automatically create the `User` table in your PostgreSQL database based on the schema:
   ```bash
   npx prisma db push
   ```

4. **Start the Server**
   To start the server in development mode (with auto-reload):
   ```bash
   npm run dev
   ```

## Endpoints

- **POST `/api/auth/register`**
  - Body: `{ "name": "John Doe", "email": "john@example.com", "password": "password123", "role": "STUDENT" }`
  - Returns: JWT Token and user data.

- **POST `/api/auth/login`**
  - Body: `{ "email": "john@example.com", "password": "password123" }`
  - Returns: JWT Token and user data.

- **GET `/api/auth/me`**
  - Headers: `Authorization: Bearer <token>`
  - Returns: Authenticated user data.
