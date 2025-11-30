import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/remote/login_remote_datasource.dart';
import 'package:login_domain/domain.dart';
import 'package:network/network.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource _remoteDatasource;

  LoginRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, Login?>> login(LoginRequest request) async {
    try {
      final loginDTO = await _remoteDatasource.login(request);
      return Right(loginDTO?.toDomain());
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
