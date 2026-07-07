import 'package:student_hub/features/auth/domain/entities/auth_tokens.dart';
import 'package:student_hub/features/auth/domain/entities/user.dart';

/// Auth repository interface — defines the contract for authentication operations.
abstract class AuthRepository {
  Future<({User user, String token})> login({
    required String email,
    required String password,
  });

  Future<({User user, String token})> register({
    required String fullName,
    required String email,
    required String password,
    String? studentId,
  });

  Future<({User user, String token})> socialLogin({
    required String provider,
    required String token,
    String? email,
    String? fullName,
  });

  Future<void> logout();

  Future<AuthTokens> refreshToken(String refreshToken);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<void> verifyEmail(String token);

  Future<void> resendVerification(String email);

  Future<User?> getCurrentUser();

  Future<User> updateProfile(Map<String, dynamic> data);

  Future<bool> isLoggedIn();
}
