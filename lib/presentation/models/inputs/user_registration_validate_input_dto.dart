import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_registration_validate_input.dart';

final class UserRegistrationValidateInputDto
    extends UserRegistrationValidateInput {
  UserRegistrationValidateInputDto({
    required super.fullName,
    required super.email,
    required super.password,
    required super.confirmPassword,
    required super.validationCode,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserRegistrationValidateInputDto.fromJson(
          Map<String, dynamic> json) =>
      UserRegistrationValidateInputDto(
        fullName: StringInputField('full_name', json['full_name']),
        email: EmailInputField('email', json['email']),
        password: PasswordInputField('password', json['password']),
        confirmPassword: ConfirmPasswordInputField(
          'password',
          json['password'],
          PasswordInputField('password', json['password']),
        ),
        validationCode: ValidationCodeInputField(
            'validation_code', json['validation_code']),
      );
}
