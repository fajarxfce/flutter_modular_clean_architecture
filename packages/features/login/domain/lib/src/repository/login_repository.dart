import 'package:dartz/dartz.dart';
import 'package:login_domain/src/model/login.dart';
import 'package:login_domain/src/usecase/login_request.dart';
import 'package:network/network.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login?>> login(LoginRequest request);
}
