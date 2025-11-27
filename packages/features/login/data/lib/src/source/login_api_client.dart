import 'package:dio/dio.dart';
import 'package:network/network.dart';
import 'package:retrofit/retrofit.dart';
import 'package:login_data/src/source/remote/request/login_request_dto.dart';
import 'package:login_data/src/source/remote/response/login_dto.dart';

part 'login_api_client.g.dart';

@RestApi()
abstract class LoginApiClient {
  factory LoginApiClient(Dio dio, {String? baseUrl}) = _LoginApiClient;

  @POST('/v1/login')
  Future<ApiResponse<LoginDTO>> login(@Body() LoginRequestDTO request);
}
