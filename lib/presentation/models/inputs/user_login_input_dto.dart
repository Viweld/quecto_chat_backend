import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_login_input.dart';

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
