import 'package:json_annotation/json_annotation.dart';
import 'package:login_domain/src/model/login.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final String token;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  LoginDTO({required this.token, this.userId, this.refreshToken});

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);

  Login toDomain() {
    return Login(token: token, userId: userId, refreshToken: refreshToken);
  }
}
