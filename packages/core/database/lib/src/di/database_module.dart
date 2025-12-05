import 'package:database/src/datasource/secure_storage_datasource.dart';
import 'package:database/src/repository/credential_repository.dart';
import 'package:database/src/repository/credential_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @Injectable(as: SecureStorageDatasource)
  SecureStorageDatasourceImpl secureStorageDatasource(
    FlutterSecureStorage storage,
  ) => SecureStorageDatasourceImpl(storage);

  @Injectable(as: CredentialRepository)
  CredentialRepositoryImpl credentialRepository(
    SecureStorageDatasource datasource,
  ) => CredentialRepositoryImpl(datasource);
}
