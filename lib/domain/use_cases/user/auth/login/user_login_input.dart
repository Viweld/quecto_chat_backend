import '../../../../../core/interfaces/base_input.dart';
import '../../../../value_objects/input_fields/input_field.dart';

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
  List<InputField<Object, Object>> checkFields() => [
        if (email.invalid) email,
        if (password.invalid) email,
      ];
}
