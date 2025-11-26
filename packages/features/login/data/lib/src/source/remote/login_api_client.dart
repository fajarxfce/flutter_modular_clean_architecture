import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:login_data/src/source/remote/response/login_dto.dart';

part 'login_api_client.g.dart';

@RestApi()
abstract class LoginApiClient {
  factory LoginApiClient(Dio dio, {String? baseUrl}) = _LoginApiClient;

  @POST('/auth/login')
  Future<LoginDTO> login(@Body() Map<String, dynamic> body);
}
