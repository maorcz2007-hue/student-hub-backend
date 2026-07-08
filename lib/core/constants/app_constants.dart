/// Global constants for the StudentHub application.
class AppConstants {
  AppConstants._();

  // ── App Info ──
  static const String appName = 'StudentHub';
  static const String appVersion = '1.0.0';

  // ── API ──
  static const String baseUrl = 'https://student-hub-backend-t2id.onrender.com/api';
  static const String wsUrl = 'wss://student-hub-backend-t2id.onrender.com';

  // ── Storage Keys ──
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'current_user';
  static const String themeKey = 'theme_mode';
  static const String colorKey = 'theme_color';
  static const String languageKey = 'language';
  static const String rememberMeKey = 'remember_me';
  static const String biometricKey = 'biometric_enabled';

  // ── Timeouts ──
  static const Duration connectionTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 60);

  // ── Pagination ──
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ── Validation ──
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxNameLength = 100;
  static const int maxBioLength = 500;
  static const int maxTitleLength = 200;
  static const int maxDescriptionLength = 5000;

  // ── File Upload ──
  static const int maxFileSize = 50 * 1024 * 1024; // 50 MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedDocExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'];

  // ── Animation ──
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // ── Layout ──
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1200;
  static const double maxContentWidth = 1400;
}
