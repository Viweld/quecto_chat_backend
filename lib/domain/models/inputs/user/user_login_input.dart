import '../../../interfaces/base_input.dart';
import '../common/input_fields/base_input_field.dart';

base class UserLoginInput implements BaseInput {
  const UserLoginInput({
    required this.email,
    required this.password,
  });

  /// User e-mail
  final EmailInputField email;

  /// Account password
  final PasswordInputField password;

  // ---------------------------------------------------------------------------
  /// Get invalid inputs as Map<String, BaseInput>
  @override
  List<BaseInputField<Object, Object>> checkFields() => [
        if (email.invalid) email,
        if (password.invalid) email,
      ];
}
