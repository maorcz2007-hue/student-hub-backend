import 'package:equatable/equatable.dart';

/// User entity representing the core user data in the domain layer.
class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? nickname;
  final String? studentId;
  final String? avatarUrl;
  final String role; // 'student', 'teacher', 'admin'
  final bool isVerified;
  final bool is2FAEnabled;
  final String? university;
  final String? faculty;
  final String? department;
  final int? year;
  final int? semester;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.nickname,
    this.studentId,
    this.avatarUrl,
    this.role = 'student',
    this.isVerified = false,
    this.is2FAEnabled = false,
    this.university,
    this.faculty,
    this.department,
    this.year,
    this.semester,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? nickname,
    String? studentId,
    String? avatarUrl,
    String? role,
    bool? isVerified,
    bool? is2FAEnabled,
    String? university,
    String? faculty,
    String? department,
    int? year,
    int? semester,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      nickname: nickname ?? this.nickname,
      studentId: studentId ?? this.studentId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      is2FAEnabled: is2FAEnabled ?? this.is2FAEnabled,
      university: university ?? this.university,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isStudent => role == 'student';
  bool get isTeacher => role == 'teacher';
  bool get isAdmin => role == 'admin';

  @override
  List<Object?> get props => [id, email, fullName, role, isVerified];
}
