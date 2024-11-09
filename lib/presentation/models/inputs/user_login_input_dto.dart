import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_login_input.dart';

final class UserLoginInputDto extends UserLoginInput {
  const UserLoginInputDto({
    required super.email,
    required super.password,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserLoginInputDto.fromJson(Map<String, dynamic> json) =>
      UserLoginInputDto(
        email: EmailInputField('email', json['email']),
        password: PasswordInputField('password', json['password']),
      );
}
