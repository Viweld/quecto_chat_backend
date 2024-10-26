// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_login_output_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginOutputDto _$UserLoginOutputDtoFromJson(Map<String, dynamic> json) =>
    UserLoginOutputDto(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$UserLoginOutputDtoToJson(UserLoginOutputDto instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };
