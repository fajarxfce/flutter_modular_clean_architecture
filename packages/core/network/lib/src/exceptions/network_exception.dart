abstract class Failure implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  Failure({required this.message, this.statusCode, this.originalError});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure({String? message, int? statusCode, dynamic originalError})
    : super(
        message: message ?? 'Server error occurred',
        statusCode: statusCode,
        originalError: originalError,
      );
}

class ClientFailure extends Failure {
  ClientFailure({String? message, int? statusCode, dynamic originalError})
    : super(
        message: message ?? 'Client error occurred',
        statusCode: statusCode,
        originalError: originalError,
      );
}

class UnauthorizedFailure extends ClientFailure {
  UnauthorizedFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'Unauthorized. Please login again.',
        statusCode: 401,
        originalError: originalError,
      );
}

class NotFoundFailure extends ClientFailure {
  NotFoundFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'Resource not found',
        statusCode: 404,
        originalError: originalError,
      );
}

class ConnectionFailure extends Failure {
  ConnectionFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'No internet connection',
        originalError: originalError,
      );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'Connection timeout',
        originalError: originalError,
      );
}

class CancelledFailure extends Failure {
  CancelledFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'Request was cancelled',
        originalError: originalError,
      );
}

class UnknownFailure extends Failure {
  UnknownFailure({String? message, dynamic originalError})
    : super(
        message: message ?? 'An unexpected error occurred',
        originalError: originalError,
      );
}
