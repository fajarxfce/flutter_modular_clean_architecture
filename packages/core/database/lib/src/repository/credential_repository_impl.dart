import 'package:database/src/datasource/secure_storage_datasource.dart';
import 'package:database/src/repository/credential_repository.dart';
import 'package:injectable/injectable.dart';

/// Implementation of credential repository using secure storage
@Injectable(as: CredentialRepository)
class CredentialRepositoryImpl implements CredentialRepository {
  final SecureStorageDatasource _datasource;

  // Storage keys
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  CredentialRepositoryImpl(this._datasource);

  @override
  Future<void> saveAccessToken(String token) async {
    await _datasource.write(_accessTokenKey, token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _datasource.write(_refreshTokenKey, token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _datasource.read(_accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _datasource.read(_refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _datasource.delete(_accessTokenKey),
      _datasource.delete(_refreshTokenKey),
    ]);
  }

  @override
  Future<void> clearAll() async {
    await _datasource.deleteAll();
  }
}
