import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/remote/login_remote_datasource.dart';
import 'package:login_domain/domain.dart';
import 'package:network/network.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource _remoteDatasource;
  final CredentialRepository _credentialRepository;

  LoginRepositoryImpl(this._remoteDatasource, this._credentialRepository);

  @override
  Future<Either<Failure, Login?>> login(LoginRequest request) async {
    return SafeApiCall.execute(() async {
      final loginDto = await _remoteDatasource.login(request);
      if (loginDto != null) {
        await _credentialRepository.saveAccessToken(loginDto.token);
        return loginDto.toDomain();
      }
      return null;
    });
  }
}
