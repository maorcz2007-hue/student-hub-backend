/// Base exception for API errors.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException($statusCode: $message)';
}

/// No internet connection.
class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}

/// Authentication failed (401).
class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({this.message = 'Unauthorized'});

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Forbidden (403).
class ForbiddenException implements Exception {
  final String message;

  const ForbiddenException({this.message = 'Forbidden'});

  @override
  String toString() => 'ForbiddenException: $message';
}

/// Resource not found (404).
class NotFoundException implements Exception {
  final String message;

  const NotFoundException({this.message = 'Not found'});

  @override
  String toString() => 'NotFoundException: $message';
}

/// Server error (5xx).
class ServerException implements Exception {
  final String message;

  const ServerException({this.message = 'Internal server error'});

  @override
  String toString() => 'ServerException: $message';
}

/// Cache/local storage exception.
class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache error'});

  @override
  String toString() => 'CacheException: $message';
}

/// Timeout exception.
class TimeoutException implements Exception {
  final String message;

  const TimeoutException({this.message = 'Request timed out'});

  @override
  String toString() => 'TimeoutException: $message';
}
