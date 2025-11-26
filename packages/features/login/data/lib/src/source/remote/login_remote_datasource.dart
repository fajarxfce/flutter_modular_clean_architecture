import 'package:login_data/src/source/remote/response/login_dto.dart';

abstract class LoginRemoteDatasource {
  Future<LoginDTO> login(String username, String password);
}
