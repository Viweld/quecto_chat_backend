import '../../../domain/value_objects/input_fields/input_field.dart';
import '../../../domain/use_cases/user/login/user_login_input.dart';

final class UserLoginInputDto extends UserLoginInput {
  UserLoginInputDto.fromJson(Map<String, dynamic> json)
      : super(
          email: EmailInputField(_emailKey, json[_emailKey]),
          password: PasswordInputField(_passwordKey, json[_passwordKey]),
        );

  // KEYS:
  // ---------------------------------------------------------------------------
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
}
