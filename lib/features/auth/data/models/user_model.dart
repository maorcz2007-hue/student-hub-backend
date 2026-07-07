import 'package:student_hub/features/auth/domain/entities/user.dart';

/// User data model with JSON serialization for API communication.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    super.nickname,
    super.studentId,
    super.avatarUrl,
    super.role,
    super.isVerified,
    super.is2FAEnabled,
    super.university,
    super.faculty,
    super.department,
    super.year,
    super.semester,
    super.bio,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      nickname: json['nickname'] as String?,
      studentId: json['studentId'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String? ?? 'student',
      isVerified: json['isVerified'] as bool? ?? false,
      is2FAEnabled: json['is2FAEnabled'] as bool? ?? false,
      university: json['university'] as String?,
      faculty: json['faculty'] as String?,
      department: json['department'] as String?,
      year: json['year'] as int?,
      semester: json['semester'] as int?,
      bio: json['bio'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'nickname': nickname,
      'studentId': studentId,
      'avatarUrl': avatarUrl,
      'role': role,
      'isVerified': isVerified,
      'is2FAEnabled': is2FAEnabled,
      'university': university,
      'faculty': faculty,
      'department': department,
      'year': year,
      'semester': semester,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create a mock user for demo/development purposes.
  factory UserModel.mock() {
    return UserModel(
      id: 'mock-user-001',
      email: 'student@studenthub.com',
      fullName: 'Alex Johnson',
      nickname: 'Alex',
      studentId: 'STU-2025-001',
      role: 'student',
      isVerified: true,
      university: 'MIT',
      faculty: 'Engineering',
      department: 'Computer Science',
      year: 3,
      semester: 1,
      bio: 'Passionate about AI and software engineering.',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
    );
  }
}
