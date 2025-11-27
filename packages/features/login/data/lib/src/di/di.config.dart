// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:login_domain/domain.dart' as _i812;

import '../repository/login_repository_impl.dart' as _i1026;
import '../source/login_api_client.dart' as _i879;
import '../source/remote/login_remote_datasource.dart' as _i535;
import '../source/remote/login_remote_datasource_impl.dart' as _i828;
import 'di.dart' as _i913;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final loginDataModule = _$LoginDataModule();
  gh.factory<_i879.LoginApiClient>(
    () => loginDataModule.loginApiClient(gh<_i361.Dio>()),
  );
  gh.factory<_i535.LoginRemoteDatasource>(
    () => _i828.LoginRemoteDatasourceImpl(gh<_i879.LoginApiClient>()),
  );
  gh.factory<_i812.LoginRepository>(
    () => _i1026.LoginRepositoryImpl(gh<_i535.LoginRemoteDatasource>()),
  );
  return getIt;
}

class _$LoginDataModule extends _i913.LoginDataModule {}
