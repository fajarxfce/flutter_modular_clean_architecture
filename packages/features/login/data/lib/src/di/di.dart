import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/src/di/di.config.dart';
import 'package:login_data/src/source/login_api_client.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureLoginDataDependencies(GetIt getIt) => init(getIt);

@module
abstract class LoginDataModule {
  @injectable
  LoginApiClient loginApiClient(Dio dio) {
    return LoginApiClient(dio);
  }
}
