// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_registration_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationInputDto _$UserRegistrationInputDtoFromJson(
        Map<String, dynamic> json) =>
    UserRegistrationInputDto(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$UserRegistrationInputDtoToJson(
        UserRegistrationInputDto instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
