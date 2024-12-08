import '../../../../core/interfaces/base_input.dart';
import '../../../entities/input_field.dart';

base class UserRegistrationValidateInput implements BaseInput {
  const UserRegistrationValidateInput({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.validationCode,
  });

  /// User full name
  final StringInputField fullName;

  /// User e-mail
  final EmailInputField email;

  /// Account password
  final PasswordInputField password;

  /// Account confirm password
  final ConfirmPasswordInputField confirmPassword;

  /// User validation code
  final ValidationCodeInputField validationCode;

  // ---------------------------------------------------------------------------
  /// Get invalid inputs as Map<String, BaseInput>
  @override
  List<InputField<Object, Object>> checkFields() => [
        if (fullName.invalid) fullName,
        if (email.invalid) email,
        if (password.invalid) email,
        if (confirmPassword.invalid) confirmPassword,
        if (validationCode.invalid) validationCode,
      ];
}
