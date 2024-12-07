// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_token_refresh_output_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTokenRefreshOutputDto _$UserTokenRefreshOutputDtoFromJson(
        Map<String, dynamic> json) =>
    UserTokenRefreshOutputDto(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$UserTokenRefreshOutputDtoToJson(
        UserTokenRefreshOutputDto instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };
