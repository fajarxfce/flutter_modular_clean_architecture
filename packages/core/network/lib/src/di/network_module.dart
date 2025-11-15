import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/config/network_config.dart';
import 'package:network/src/interceptors/auth_interceptor.dart';
import 'package:network/src/interceptors/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  NetworkConfig get networkConfig => NetworkConfig.development();

  @lazySingleton
  Dio dio(NetworkConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (config.enableLogging) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }
}
