import 'package:json_annotation/json_annotation.dart';
import 'package:login_domain/src/model/login.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final String token;
  @JsonKey(name: 'tokenType')
  final String? tokenType;

  LoginDTO({required this.token, this.tokenType});

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);

  Login toDomain() {
    return Login(token: token, tokenType: tokenType);
  }
}
