import 'package:dartz/dartz.dart';
import 'package:login_domain/src/model/login.dart';
import 'package:network/network.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> login(String username, String password);
}
