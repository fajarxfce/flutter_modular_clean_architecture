import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/remote/login_api_client.dart';

@module
abstract class LoginDataModule {
  @injectable
  LoginApiClient loginApiClient(Dio dio) {
    return LoginApiClient(dio);
  }
}
