// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../datasource/secure_storage_datasource.dart' as _i598;
import '../repository/credential_repository.dart' as _i557;
import 'database_module.dart' as _i384;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initDatabase({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => databaseModule.secureStorage,
    );
    gh.factory<_i598.SecureStorageDatasource>(
      () => databaseModule.secureStorageDatasource(
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i557.CredentialRepository>(
      () => databaseModule.credentialRepository(
        gh<_i598.SecureStorageDatasource>(),
      ),
    );
    return this;
  }
}

class _$DatabaseModule extends _i384.DatabaseModule {}
