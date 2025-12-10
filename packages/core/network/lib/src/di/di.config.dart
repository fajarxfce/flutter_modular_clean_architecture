// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:analytics/analytics.dart' as _i548;
import 'package:database/database.dart' as _i252;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../config/network_config.dart' as _i295;
import '../interceptors/auth_interceptor.dart' as _i48;
import '../interceptors/crashlytics_interceptor.dart' as _i645;
import 'network_module.dart' as _i567;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.lazySingleton<_i295.NetworkConfig>(() => networkModule.networkConfig);
  gh.factory<_i48.AuthInterceptor>(
    () => _i48.AuthInterceptor(gh<_i252.CredentialRepository>()),
  );
  gh.factory<_i645.CrashlyticsInterceptor>(
    () => _i645.CrashlyticsInterceptor(gh<_i548.FirebaseService>()),
  );
  gh.lazySingleton<_i361.Dio>(
    () => networkModule.dio(
      gh<_i295.NetworkConfig>(),
      gh<_i48.AuthInterceptor>(),
      gh<_i645.CrashlyticsInterceptor>(),
    ),
  );
  return getIt;
}

class _$NetworkModule extends _i567.NetworkModule {}
