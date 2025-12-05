import 'package:database/database.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final CredentialRepository _credentialRepository;

  AuthInterceptor(this._credentialRepository);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _credentialRepository.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['X-API-KEY'] = token;
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await _credentialRepository.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {}

      await _credentialRepository.clearTokens();
    }

    handler.next(err);
  }
}
