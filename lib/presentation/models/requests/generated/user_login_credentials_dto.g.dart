// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_login_credentials_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginCredentialsDto _$UserLoginCredentialsDtoFromJson(
        Map<String, dynamic> json) =>
    UserLoginCredentialsDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginCredentialsDtoToJson(
        UserLoginCredentialsDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
