// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) => LoginDTO(
  token: json['token'] as String,
  userId: json['user_id'] as String?,
  refreshToken: json['refresh_token'] as String?,
);

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
  'token': instance.token,
  'user_id': instance.userId,
  'refresh_token': instance.refreshToken,
};
