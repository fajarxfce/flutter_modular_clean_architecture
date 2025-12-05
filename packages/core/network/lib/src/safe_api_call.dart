import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:network/network.dart';

class SafeApiCall {
  static Future<Either<Failure, T>> execute<T>(
    Future<T> Function() apiCall, {
    String? errorMessage,
    String? logName,
  }) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on DioException catch (e) {
      final logContext = logName ?? 'SafeApiCall';
      log('DioException in $logContext: ${e.toString()}');
      final failure = _handleDioException(e);
      return Left(failure);
    } catch (e) {
      final logContext = logName ?? 'SafeApiCall';
      log('Unexpected error in $logContext: ${e.toString()}');
      final message = errorMessage ?? "An unexpected error occurred: $e";
      return Left(ServerFailure(message));
    }
  }

  static Failure _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final errorData = error.response?.data;

        if (statusCode == 401) {
          return const UnauthorizedFailure('Unauthorized access');
        } else if (statusCode == 404) {
          return const NotFoundFailure('Data not found');
        } else if (statusCode == 422) {
          // Handle validation errors
          String validationMessage = 'Validation error';
          if (errorData is Map<String, dynamic>) {
            final message = errorData['message'] ?? errorData['error'];
            if (message != null) {
              validationMessage = message.toString();
            }
          }
          return ValidationFailure(validationMessage);
        } else if (statusCode == 409) {
          return const ConflictFailure('Conflict error');
        } else if (statusCode != null && statusCode >= 500) {
          final errorMsg = errorData is Map<String, dynamic>
              ? errorData['message'] ?? 'Server error'
              : 'Server error';
          return ServerFailure(errorMsg);
        } else {
          // Try to extract error message from response
          String errorMessage = 'Bad response: ${statusCode ?? 'Unknown'}';
          if (errorData is Map<String, dynamic>) {
            final message = errorData['message'] ?? errorData['error'];
            if (message != null) {
              errorMessage = message.toString();
            }
          }
          return ServerFailure(errorMessage);
        }

      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure('Connection error');

      default:
        return const NetworkFailure('Something went wrong');
    }
  }
}
