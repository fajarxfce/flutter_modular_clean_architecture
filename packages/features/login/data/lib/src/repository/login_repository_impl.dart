import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/remote/login_remote_datasource.dart';
import 'package:login_domain/domain.dart';
import 'package:login_data/src/source/remote/response/login_dto.dart';
import 'package:network/network.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDatasource _remoteDatasource;

  LoginRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, Login>> login(String username, String password) async {
    try {
      final loginDTO = await _remoteDatasource.login(username, password);
      return Right(loginDTO.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'Network error occurred'),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
