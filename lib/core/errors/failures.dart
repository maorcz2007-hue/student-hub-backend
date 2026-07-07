/// Base failure class for domain-level error handling.
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  String toString() => 'Failure($message, statusCode: $statusCode)';
}

/// Server-side failure (API errors).
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Network failure (no internet, timeout, etc.).
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Cache/local storage failure.
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error'});
}

/// Authentication failure.
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode});
}

/// Validation failure.
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
  });
}

/// Permission/authorization failure.
class PermissionFailure extends Failure {
  const PermissionFailure({super.message = 'Permission denied'});
}

/// Not found failure.
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found', super.statusCode = 404});
}

/// Unknown failure.
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred'});
}
