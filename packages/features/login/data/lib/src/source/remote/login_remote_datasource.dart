import 'package:login_data/src/source/remote/response/login_dto.dart';
import 'package:login_domain/domain.dart';
import 'package:network/network.dart';

abstract class LoginRemoteDatasource {
  Future<LoginDTO> login(LoginRequest request);
}
