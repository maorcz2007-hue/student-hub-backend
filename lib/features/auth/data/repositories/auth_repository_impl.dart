import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/network/api_client.dart';
import 'package:student_hub/core/network/api_endpoints.dart';
import 'package:student_hub/core/storage/secure_storage.dart';
import 'package:student_hub/core/storage/local_storage.dart';
import 'package:student_hub/features/auth/data/models/user_model.dart';
import 'package:student_hub/features/auth/domain/entities/auth_tokens.dart';
import 'package:student_hub/features/auth/domain/repositories/auth_repository.dart';

/// Provides the auth repository instance.
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(ref.watch(apiClientProvider));
});

/// Implementation of the auth repository.
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);

  @override
  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    final data = response.data as Map<String, dynamic>;
    
    // שליפה נכונה של האובייקט הפנימי 'user' כפי שהשרת באמת שולח אותו
    final userData = data['user'] as Map<String, dynamic>? ?? data; 
    final token = data['token']?.toString() ?? '';

    final user = UserModel(
      id: userData['id']?.toString() ?? '0',
      email: userData['email']?.toString() ?? email,
      fullName: userData['name']?.toString() ?? 'Student',
      role: userData['role']?.toString() ?? 'student',
      university: 'Default University',
      department: 'Default Department',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Persist token and user
    await SecureStorage.setAccessToken(token);
    await SecureStorage.setUserId(user.id);
    await LocalStorage.setString('current_user', jsonEncode(user.toJson()));

    return (user: user, token: token);
  }

  @override
  Future<({UserModel user, String token})> register({
    required String fullName,
    required String email,
    required String password,
    String? studentId,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'name': fullName,
          'email': email,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;

      // שליפה נכונה של האובייקט הפנימי 'user'
      final userData = data['user'] as Map<String, dynamic>? ?? data; 
      final token = data['token']?.toString() ?? '';

      final user = UserModel(
        id: userData['id']?.toString() ?? '0',
        email: userData['email']?.toString() ?? email,
        fullName: userData['name']?.toString() ?? fullName,
        role: userData['role']?.toString() ?? 'student',
        university: 'Default University',
        department: 'Default Department',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save user to local storage via LocalStorage (using the same pattern as login)
      await LocalStorage.setString('current_user', jsonEncode(user.toJson()));
      await SecureStorage.setAccessToken(token);

      return (user: user, token: token);
    } on DioException catch (e) {
      if (e.error is Exception) throw e.error as Exception;
      rethrow;
    }
  }

  @override
  Future<({UserModel user, String token})> socialLogin({
    required String provider,
    required String token,
    String? email,
    String? fullName,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/social-login',
        data: {
          'provider': provider,
          'token': token,
          'email': email,
          'fullName': fullName,
        },
      );

      final data = response.data as Map<String, dynamic>;

      final userData = data['user'] as Map<String, dynamic>? ?? data; 
      final jwtToken = data['token']?.toString() ?? '';

      final user = UserModel(
        id: userData['id']?.toString() ?? '0',
        email: userData['email']?.toString() ?? email ?? '',
        fullName: userData['name']?.toString() ?? fullName ?? 'Student',
        role: userData['role']?.toString() ?? 'student',
        university: 'Default University',
        department: 'Default Department',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await LocalStorage.setString('current_user', jsonEncode(user.toJson()));
      await SecureStorage.setAccessToken(jwtToken);

      return (user: user, token: jwtToken);
    } on DioException catch (e) {
      if (e.error is Exception) throw e.error as Exception;
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Backend uses stateless JWT — just clear local storage
    } finally {
      await SecureStorage.clearAll();
      await LocalStorage.delete('current_user');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Try from local cache first
    final cached = LocalStorage.getString('current_user');
    if (cached != null) {
      try {
        return UserModel.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      } catch (_) {}
    }

    // Fetch from API
    final token = await SecureStorage.getAccessToken();
    if (token == null) return null;

    try {
      final response = await _apiClient.get('/auth/me');
      final data = response.data as Map<String, dynamic>;
      
      final userData = data['user'] as Map<String, dynamic>? ?? data;

      final user = UserModel(
        id: userData['id']?.toString() ?? '0',
        email: userData['email']?.toString() ?? '',
        fullName: userData['name']?.toString() ?? 'Student',
        role: userData['role']?.toString() ?? 'student',
        university: 'Default University',
        department: 'Default Department',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await LocalStorage.setString('current_user', jsonEncode(user.toJson()));
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await SecureStorage.getAccessToken();
    return token != null;
  }

  // --- Stub implementations for interface methods not yet supported by backend ---

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _apiClient.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      if (e.error is Exception) throw e.error as Exception;
      rethrow;
    }
  }

  @override
  Future<AuthTokens> refreshToken(String refreshToken) async {
    // Not implemented — backend uses a single 30-day JWT without refresh tokens.
    throw UnimplementedError('Refresh tokens are not supported by the current backend.');
  }

  @override
  Future<void> resendVerification(String email) async {}

  @override
  Future<void> resetPassword({required String token, required String newPassword}) async {}

  @override
  Future<void> verifyEmail(String token) async {
    try {
      await _apiClient.post(
        '/auth/verify-email',
        data: {'token': token},
      );
    } on DioException catch (e) {
      if (e.error is Exception) throw e.error as Exception;
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.put(
        '/users/profile',
        data: data,
      );
      
      final responseData = response.data as Map<String, dynamic>;
      
      // Merge with nested studentProfile if exists
      final studentProfile = responseData['studentProfile'] as Map<String, dynamic>? ?? {};
      final mergedData = {
        ...responseData,
        if (studentProfile.containsKey('bio')) 'bio': studentProfile['bio'],
        if (studentProfile.containsKey('university')) 'university': studentProfile['university'],
        if (studentProfile.containsKey('department')) 'department': studentProfile['department'],
      };

      final user = UserModel.fromJson(mergedData);
      
      // התיקון שלנו לשמירה המקומית
      await LocalStorage.setString('current_user', jsonEncode(user.toJson()));
      
      return user;
    } on DioException catch (e) {
      if (e.error is Exception) throw e.error as Exception;
      rethrow;
    }
  }
}