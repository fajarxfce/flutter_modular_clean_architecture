// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:login_domain/domain.dart' as _i812;
import 'package:navigation/app_navigator.dart' as _i631;

import '../bloc/login_bloc.dart' as _i221;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i221.LoginBloc>(
    () => _i221.LoginBloc(gh<_i631.AppNavigator>(), gh<_i812.LoginUsecase>()),
  );
  return getIt;
}
