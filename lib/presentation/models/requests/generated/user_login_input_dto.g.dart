// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_login_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginInputDto _$UserLoginInputDtoFromJson(Map<String, dynamic> json) =>
    UserLoginInputDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginInputDtoToJson(UserLoginInputDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
