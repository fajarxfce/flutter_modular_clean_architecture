abstract class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  NetworkException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => message;
}

class ServerException extends NetworkException {
  ServerException({String? message, int? statusCode, dynamic originalError})
    : super(
        message: message ?? 'Server error occurred',
        statusCode: statusCode,
        originalError: originalError,
      );
}

class ClientException extends NetworkException {
  ClientException({String? message, int? statusCode, dynamic originalError})
    : super(
        message: message ?? 'Client error occurred',
        statusCode: statusCode,
        originalError: originalError,
      );
}

class UnauthorizedException extends ClientException {
  UnauthorizedException({String? message, dynamic originalError})
    : super(
        message: message ?? 'Unauthorized. Please login again.',
        statusCode: 401,
        originalError: originalError,
      );
}

class NotFoundException extends ClientException {
  NotFoundException({String? message, dynamic originalError})
    : super(
        message: message ?? 'Resource not found',
        statusCode: 404,
        originalError: originalError,
      );
}

class ConnectionException extends NetworkException {
  ConnectionException({String? message, dynamic originalError})
    : super(
        message: message ?? 'No internet connection',
        originalError: originalError,
      );
}

class TimeoutException extends NetworkException {
  TimeoutException({String? message, dynamic originalError})
    : super(
        message: message ?? 'Connection timeout',
        originalError: originalError,
      );
}

class CancelledException extends NetworkException {
  CancelledException({String? message, dynamic originalError})
    : super(
        message: message ?? 'Request was cancelled',
        originalError: originalError,
      );
}

class UnknownException extends NetworkException {
  UnknownException({String? message, dynamic originalError})
    : super(
        message: message ?? 'An unexpected error occurred',
        originalError: originalError,
      );
}
