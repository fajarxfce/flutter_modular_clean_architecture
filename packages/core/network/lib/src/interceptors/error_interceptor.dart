import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorInterceptor extends Interceptor {
  final _logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;

      case DioExceptionType.badResponse:
        message = _handleStatusCode(err.response?.statusCode);
        break;

      case DioExceptionType.cancel:
        message = 'Request was cancelled';
        break;

      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;

      case DioExceptionType.unknown:
        message = 'An unexpected error occurred. Please try again.';
        break;

      default:
        message = 'Something went wrong';
    }

    _logger.e('API Error: $message', error: err);

    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
      message: message,
    );

    handler.next(customError);
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred (Code: $statusCode)';
    }
  }
}
