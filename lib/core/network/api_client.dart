import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/core/constants/app_constants.dart';
import 'package:student_hub/core/errors/exceptions.dart';
import 'package:student_hub/core/storage/secure_storage.dart';

/// Provides a configured Dio HTTP client with interceptors.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Dio-based HTTP client with authentication, logging, and error handling.
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _ErrorInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          // Use debug print in development
          assert(() {
            // ignore: avoid_print
            print('🌐 $object');
            return true;
          }());
        },
      ),
    ]);
  }

  Dio get dio => _dio;

  // ── GET ──
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // ── POST ──
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // ── PUT ──
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // ── PATCH ──
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // ── DELETE ──
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // ── Upload ──
  Future<Response<T>> upload<T>(
    String path, {
    required FormData formData,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: formData,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );
  }
}

/// Interceptor that attaches JWT access token to requests and handles token refresh.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth header for login/register endpoints
    final noAuthPaths = ['/auth/login', '/auth/register', '/auth/forgot-password'];
    if (noAuthPaths.any((path) => options.path.contains(path))) {
      return handler.next(options);
    }

    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token is invalid or expired. Force logout.
      await SecureStorage.clearAll();
    }
    handler.next(err);
  }
}

/// Interceptor that converts Dio errors into app-specific exceptions.
///
/// CRITICAL: Uses handler.reject() instead of throw to avoid Dio wrapping
/// our exceptions in another DioException(type: unknown), which causes
/// the "DioException [unknown]: null" error.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const TimeoutException(),
            type: err.type,
            message: 'Request timed out. Please try again.',
          ),
        );
        return;

      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(),
            type: err.type,
            message: 'No internet connection. Please check your network.',
          ),
        );
        return;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;
        final message = data is Map
            ? (data['message'] as String? ?? 'Unknown error')
            : 'Unknown error';

        Exception appException;
        if (statusCode == 400) {
          appException = ApiException(message: message, statusCode: 400, data: data);
        } else if (statusCode == 401) {
          appException = UnauthorizedException(message: message);
        } else if (statusCode == 403) {
          appException = ForbiddenException(message: message);
        } else if (statusCode == 404) {
          appException = NotFoundException(message: message);
        } else if (statusCode != null && statusCode >= 500) {
          appException = ServerException(message: message);
        } else {
          appException = ApiException(message: message, statusCode: statusCode, data: data);
        }

        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: appException,
            type: err.type,
            message: message,
          ),
        );
        return;

      default:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: ApiException(
              message: err.message ?? 'An unexpected error occurred',
              statusCode: err.response?.statusCode,
            ),
            type: err.type,
            message: err.message ?? 'An unexpected error occurred',
          ),
        );
        return;
    }
  }
}
