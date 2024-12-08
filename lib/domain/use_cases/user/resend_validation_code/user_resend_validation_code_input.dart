import '../../../../core/interfaces/base_input.dart';
import '../../../entities/input_field.dart';

base class UserResendValidationCodeInput implements BaseInput {
  const UserResendValidationCodeInput({
    required this.email,
  });

  /// User e-mail
  final EmailInputField email;

  // ---------------------------------------------------------------------------
  /// Get invalid inputs as Map<String, BaseInput>
  @override
  List<InputField<Object, Object>> checkFields() => [
        if (email.invalid) email,
      ];
}
