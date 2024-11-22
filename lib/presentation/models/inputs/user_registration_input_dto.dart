import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_registration_input.dart';

final class UserRegistrationInputDto extends UserRegistrationInput {
  UserRegistrationInputDto({
    required super.fullName,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserRegistrationInputDto.fromJson(Map<String, dynamic> json) =>
      UserRegistrationInputDto(
        fullName: StringInputField('full_name', json['full_name']),
        email: EmailInputField('email', json['email']),
        password: PasswordInputField('password', json['password']),
        confirmPassword: ConfirmPasswordInputField(
          'password',
          json['password'],
          PasswordInputField('password', json['password']),
        ),
      );
}
