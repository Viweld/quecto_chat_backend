import 'package:json_annotation/json_annotation.dart';
import '../../../domain/exceptions/app_exceptions.dart';
import '../../../domain/use_cases/user/user_login.dart';

part 'generated/user_login_input_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserLoginInputDto extends UserLoginInput {
  UserLoginInputDto({
    required super.email,
    required super.password,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserLoginInputDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserLoginInputDtoFromJson(json);
    } on Object {
      throw UnableToDecodeRequestBody('$json');
    }
  }
}
