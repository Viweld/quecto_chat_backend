import 'package:json_annotation/json_annotation.dart';
import '../../../domain/exceptions/app_exceptions.dart';
import '../../../domain/use_cases/user/user_registration.dart';

part 'generated/user_registration_input_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserRegistrationInputDto extends UserRegistrationInput {
  UserRegistrationInputDto({
    required super.fullName,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserRegistrationInputDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserRegistrationInputDtoFromJson(json);
    } on Object {
      throw UnableToDecodeRequestBody('$json');
    }
  }
}
