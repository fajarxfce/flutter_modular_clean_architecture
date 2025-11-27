import 'package:dartz/dartz.dart';
import 'package:login_domain/domain.dart';
import 'package:network/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final LoginRepository _repository;
  LoginUsecase(this._repository);

  Future<Either<Failure, Login>> call(LoginRequest request) {
    if (request.email.isEmpty || request.password.isEmpty) {
      return Future.value(
        Left(ValidationFailure('Username and password must not be empty')),
      );
    }
    return _repository.login(request);
  }
}
