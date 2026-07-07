/// API endpoint constants.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Auth ──
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';
  static const String setup2FA = '/auth/2fa/setup';
  static const String verify2FA = '/auth/2fa/verify';

  // ── Users ──
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String uploadAvatar = '/users/avatar';
  static const String changePassword = '/users/change-password';
  static const String userSettings = '/users/settings';

  // ── Dashboard ──
  static const String dashboard = '/dashboard';
  static const String dashboardStats = '/dashboard/stats';

  // ── Courses ──
  static const String courses = '/courses';
  static String courseById(String id) => '/courses/$id';
  static String courseStudents(String id) => '/courses/$id/students';

  // ── Assignments ──
  static const String assignments = '/assignments';
  static String assignmentById(String id) => '/assignments/$id';
  static String submitAssignment(String id) => '/assignments/$id/submit';

  // ── Grades ──
  static const String grades = '/grades';
  static const String gpa = '/grades/gpa';
  static String gradesByCourse(String courseId) => '/grades/course/$courseId';
  static String gradesBySemester(String semester) => '/grades/semester/$semester';

  // ── Calendar ──
  static const String calendarEvents = '/calendar';
  static String calendarEventById(String id) => '/calendar/$id';

  // ── Messages ──
  static const String conversations = '/messages/conversations';
  static String conversationById(String id) => '/messages/conversations/$id';
  static String conversationMessages(String id) => '/messages/conversations/$id/messages';

  // ── Notifications ──
  static const String notifications = '/notifications';
  static const String markAllRead = '/notifications/read-all';
  static String markRead(String id) => '/notifications/$id/read';

  // ── AI ──
  static const String aiChat = '/ai/chat';
  static const String aiHistory = '/ai/history';
  static String aiConversation(String id) => '/ai/history/$id';

  // ── Files ──
  static const String files = '/files';
  static String fileById(String id) => '/files/$id';
  static String fileDownload(String id) => '/files/$id/download';

  // ── Search ──
  static const String search = '/search';

  // ── Feedback ──
  static const String feedback = '/feedback';
  static String feedbackById(String id) => '/feedback/$id';

  // ── Admin ──
  static const String adminUsers = '/admin/users';
  static String adminUserById(String id) => '/admin/users/$id';
  static const String adminCourses = '/admin/courses';
  static const String adminStats = '/admin/stats';
  static const String adminAnnouncements = '/admin/announcements';
  static const String adminLogs = '/admin/logs';
}
