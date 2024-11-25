import '../../../interfaces/base_input.dart';
import '../common/input_fields/base_input_field.dart';

base class UserResendValidationCodeInput implements BaseInput {
  const UserResendValidationCodeInput({
    required this.email,
  });

  /// User e-mail
  final EmailInputField email;

  // ---------------------------------------------------------------------------
  /// Get invalid inputs as Map<String, BaseInput>
  @override
  List<BaseInputField<Object, Object>> checkFields() => [
        if (email.invalid) email,
      ];
}
