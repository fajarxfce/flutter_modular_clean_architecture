import 'package:analytics/analytics.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';

@injectable
class CrashlyticsInterceptor extends Interceptor {
  final FirebaseService _firebaseService;

  CrashlyticsInterceptor(this._firebaseService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    debugPrint('CrashlyticsInterceptor - Error Status Code: $statusCode');

    if (statusCode != null &&
        (statusCode >= 500 ||
            statusCode == 422 ||
            statusCode == 400 ||
            statusCode == 405)) {
      // Build detailed error context
      final requestOptions = err.requestOptions;
      final response = err.response;

      // Log comprehensive error details
      _firebaseService.log('=== HTTP Error Report ===');
      _firebaseService.log(
        'Status: $statusCode ${response?.statusMessage ?? ''}',
      );
      _firebaseService.log('URL: ${requestOptions.uri}');
      _firebaseService.log('Method: ${requestOptions.method}');
      _firebaseService.log('Headers: ${requestOptions.headers}');
      _firebaseService.log(
        'Query Parameters: ${requestOptions.queryParameters}',
      );
      _firebaseService.log('Request Body: ${requestOptions.data}');
      _firebaseService.log('Response Body: ${response?.data}');

      // Record error with context
      _firebaseService.recordError(
        exception: err,
        stackTrace: err.stackTrace,
        reason: 'HTTP $statusCode: ${requestOptions.path}',
        fatal: false,
      );

      // Set custom keys for Crashlytics dashboard
      _firebaseService.setCustomKey(key: 'http_status', value: statusCode);
      _firebaseService.setCustomKey(
        key: 'http_method',
        value: requestOptions.method,
      );
      _firebaseService.setCustomKey(
        key: 'endpoint',
        value: requestOptions.path,
      );
      _firebaseService.setCustomKey(
        key: 'base_url',
        value: requestOptions.baseUrl,
      );

      // Request details
      _firebaseService.setCustomKey(
        key: 'request_headers',
        value: requestOptions.headers.toString(),
      );
      _firebaseService.setCustomKey(
        key: 'query_params',
        value: requestOptions.queryParameters.toString(),
      );
      _firebaseService.setCustomKey(
        key: 'request_body',
        value: requestOptions.data?.toString() ?? 'null',
      );

      // Response details
      _firebaseService.setCustomKey(
        key: 'response_headers',
        value: response?.headers.toString() ?? 'null',
      );
      _firebaseService.setCustomKey(
        key: 'response_body',
        value: response?.data?.toString() ?? 'null',
      );
    }

    handler.next(err);
  }
}
