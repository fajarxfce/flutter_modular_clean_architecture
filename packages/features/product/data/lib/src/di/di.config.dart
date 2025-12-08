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
import 'package:product_domain/product_domain.dart' as _i148;

import '../repository/product_repository_impl.dart' as _i972;
import '../source/product_api_client.dart' as _i788;
import '../source/remote/product_remote_datasource.dart' as _i27;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i27.ProductRemoteDatasource>(
    () => _i27.ProductRemoteDatasourceImpl(gh<_i788.ProductApiClient>()),
  );
  gh.factory<_i148.ProductRepository>(
    () => _i972.ProductRepositoryImpl(gh<_i27.ProductRemoteDatasource>()),
  );
  return getIt;
}
