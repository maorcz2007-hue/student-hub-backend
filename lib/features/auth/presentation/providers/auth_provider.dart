import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_hub/features/auth/data/models/user_model.dart';
import 'package:student_hub/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:student_hub/features/auth/domain/entities/user.dart';
import 'package:student_hub/core/errors/exceptions.dart';

part 'auth_provider.g.dart';

/// Auth state that tracks authentication status and current user.
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Extracts a user-friendly error message from any exception type.
String _extractErrorMessage(Object e, String fallback) {
  // DioException wrapping our app exception (from handler.reject)
  if (e is DioException) {
    final innerError = e.error;
    if (innerError is ApiException) return innerError.message;
    if (innerError is NetworkException) return innerError.message;
    if (innerError is ServerException) return innerError.message;
    if (innerError is TimeoutException) return innerError.message;
    if (innerError is UnauthorizedException) return innerError.message;
    if (innerError is ForbiddenException) return innerError.message;
    if (innerError is NotFoundException) return innerError.message;
    // If message is available on DioException itself
    if (e.message != null && e.message!.isNotEmpty) return e.message!;
    return fallback;
  }
  // Direct app exceptions (shouldn't happen normally, but just in case)
  if (e is ApiException) return e.message;
  if (e is NetworkException) return e.message;
  if (e is ServerException) return e.message;
  if (e is TimeoutException) return e.message;
  if (e is UnauthorizedException) return e.message;
  return fallback;
}

/// Global auth state provider.
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthState();
  }

  AuthRepositoryImpl get _repo => ref.read(authRepositoryProvider);

  /// Check if user is already logged in on app start.
  Future<void> _checkAuthStatus() async {
    // Schedule state update after build
    Future.microtask(() async {
      state = state.copyWith(isLoading: true, clearError: true);
      try {
        final user = await _repo.getCurrentUser();
        if (user != null) {
          state = state.copyWith(user: user, isLoading: false);
        } else {
          state = state.copyWith(isLoading: false, clearUser: true);
        }
      } catch (e) {
        state = state.copyWith(isLoading: false, clearUser: true);
      }
    });
  }

  /// Login with email and password.
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repo.login(email: email, password: password);
      state = state.copyWith(user: result.user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(e, 'Login failed. Please try again.'),
      );
      return false;
    }
  }

  /// Register a new user.
  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    String? studentId,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repo.register(
        fullName: fullName,
        email: email,
        password: password,
        studentId: studentId,
      );
      state = state.copyWith(
        isLoading: false,
        user: result.user,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(e, 'Failed to register. Please try again.'),
      );
      return false;
    }
  }

  /// Login with Social Provider (Google/Apple)
  Future<bool> socialLogin({
    required String provider,
    required String token,
    String? email,
    String? fullName,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repo.socialLogin(
        provider: provider,
        token: token,
        email: email,
        fullName: fullName,
      );
      state = state.copyWith(
        isLoading: false,
        user: result.user,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(e, 'Social login failed. Please try again.'),
      );
      return false;
    }
  }

  /// Forgot password.
  Future<bool> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.forgotPassword(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(e, 'Failed to send reset email.'),
      );
      return false;
    }
  }

  /// Logout.
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await _repo.logout();
    state = const AuthState();
  }

  /// Clear error message.
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Update user profile.
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final updatedUser = await _repo.updateProfile(data);
      state = state.copyWith(isLoading: false, user: updatedUser);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(e, 'Failed to update profile.'),
      );
      return false;
    }
  }
}

// Keep a legacy alias to avoid breaking all other imports right now if possible,
// but we'll migrate them.
final authStateProvider = authNotifierProvider;