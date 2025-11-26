import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/remote/login_api_client.dart';
import 'package:login_data/src/source/remote/login_remote_datasource.dart';
import 'package:login_data/src/source/remote/response/login_dto.dart';

@Injectable(as: LoginRemoteDatasource)
class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final LoginApiClient _apiClient;

  LoginRemoteDatasourceImpl(this._apiClient);

  @override
  Future<LoginDTO> login(String username, String password) async {
    return await _apiClient.login({'username': username, 'password': password});
  }
}
