/// Input validation helpers.
class Validators {
  Validators._();

  /// Validates email format.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validates password strength.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }
    return null;
  }

  /// Validates password confirmation.
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates required field.
  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates name.
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Name is too long';
    }
    return null;
  }

  /// Validates student ID.
  static String? studentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Student ID is required';
    }
    if (value.trim().length < 3) {
      return 'Invalid student ID';
    }
    return null;
  }

  /// Validates phone number.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates URL.
  static String? url(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    final urlRegex = RegExp(r'^https?:\/\/.+');
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }
}
