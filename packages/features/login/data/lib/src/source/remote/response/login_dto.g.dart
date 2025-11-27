// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) => LoginDTO(
  token: json['token'] as String,
  tokenType: json['tokenType'] as String?,
);

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
  'token': instance.token,
  'tokenType': instance.tokenType,
};
