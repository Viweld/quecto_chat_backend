import '../../../domain/use_cases/user/auth/registration/user_registration_input.dart';
import '../../../domain/value_objects/input_fields/input_field.dart';

final class UserRegistrationInputDto extends UserRegistrationInput {
  UserRegistrationInputDto.fromJson(Map<String, dynamic> json)
      : super(
          fullName: StringInputField(_fullNameKey, json[_fullNameKey]),
          email: EmailInputField(_emailKey, json[_emailKey]),
          password: PasswordInputField(_passwordKey, json[_passwordKey]),
          confirmPassword: ConfirmPasswordInputField(
            _passwordKey,
            json[_passwordKey],
            PasswordInputField(_passwordKey, json[_passwordKey]),
          ),
        );

  // KEYS:
  // ---------------------------------------------------------------------------
  static const _fullNameKey = 'full_name';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
}
