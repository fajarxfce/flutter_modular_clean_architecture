import 'package:injectable/injectable.dart';
import 'package:login_data/src/source/login_api_client.dart';
import 'package:login_data/src/source/remote/login_remote_datasource.dart';
import 'package:login_data/src/source/remote/request/login_request_dto.dart';
import 'package:login_data/src/source/remote/response/login_dto.dart';
import 'package:login_domain/domain.dart';
import 'package:network/network.dart';

@Injectable(as: LoginRemoteDatasource)
class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final LoginApiClient _apiClient;

  LoginRemoteDatasourceImpl(this._apiClient);

  @override
  Future<LoginDTO> login(LoginRequest request) async {
    return SafeApiCall.execute(
      () async => (await _apiClient.login(
        LoginRequestDTO.fromDomain(request),
      )).getModel()!,
    );
  }
}
