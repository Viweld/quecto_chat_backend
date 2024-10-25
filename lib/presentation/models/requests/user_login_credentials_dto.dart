import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/user/user_login_credentials.dart';
import '../../../domain/exceptions/app_exceptions.dart';

part 'generated/user_login_credentials_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserLoginCredentialsDto extends UserLoginCredentials {
  UserLoginCredentialsDto({
    required super.email,
    required super.password,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserLoginCredentialsDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserLoginCredentialsDtoFromJson(json);
    } on Object {
      throw UnableToDecodeRequestBody('$json');
    }
  }
}
