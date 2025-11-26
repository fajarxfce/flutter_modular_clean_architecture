import 'package:dartz/dartz.dart';
import 'package:login_domain/src/model/login.dart';
import 'package:login_domain/src/repository/login_repository.dart';
import 'package:network/network.dart';

class LoginUsecase {
  final LoginRepository _repository;
  LoginUsecase(this._repository);

  Future<Either<Failure, Login>> call(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      return Future.value(
        Left(ClientFailure(message: 'Username and password must not be empty')),
      );
    }
    return _repository.login(username, password);
  }
}
