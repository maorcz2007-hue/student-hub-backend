import 'package:intl/intl.dart';

/// Date and time formatting utilities.
class DateFormatter {
  DateFormatter._();

  /// "Jan 15, 2025"
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }

  /// "January 15, 2025"
  static String formatFullDate(DateTime date) {
    return DateFormat('MMMM d, y').format(date);
  }

  /// "3:30 PM"
  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// "Jan 15, 3:30 PM"
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, h:mm a').format(date);
  }

  /// "Jan 15, 2025, 3:30 PM"
  static String formatFullDateTime(DateTime date) {
    return DateFormat('MMM d, y, h:mm a').format(date);
  }

  /// "Monday, January 15"
  static String formatDayDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  /// "Mon"
  static String formatShortDay(DateTime date) {
    return DateFormat('E').format(date);
  }

  /// Relative time: "just now", "2 min ago", "1 hour ago", etc.
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final min = difference.inMinutes;
      return '$min min${min > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      final hrs = difference.inHours;
      return '$hrs hour${hrs > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }

  /// Due date label: "Today", "Tomorrow", "Overdue", etc.
  static String dueLabel(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final diff = due.difference(today).inDays;

    if (diff < 0) return 'Overdue';
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff <= 7) return 'In $diff days';
    return formatDate(dueDate);
  }

  /// Semester label: "Fall 2025", "Spring 2026", etc.
  static String semesterLabel(int year, int semester) {
    final names = ['Spring', 'Summer', 'Fall'];
    final name = semester >= 1 && semester <= 3 ? names[semester - 1] : 'Unknown';
    return '$name $year';
  }

  /// Greeting based on time of day.
  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
