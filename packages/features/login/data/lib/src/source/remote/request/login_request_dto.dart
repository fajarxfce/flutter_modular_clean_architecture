import 'package:json_annotation/json_annotation.dart';
import 'package:login_domain/src/usecase/login_request.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDTO {
  final String email;
  final String password;

  LoginRequestDTO({required this.email, required this.password});

  factory LoginRequestDTO.fromDomain(LoginRequest request) {
    return LoginRequestDTO(email: request.email, password: request.password);
  }

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDTOToJson(this);
}
