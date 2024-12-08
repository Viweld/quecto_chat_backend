import '../../../domain/value_objects/input_fields/input_field.dart';
import '../../../domain/use_cases/user/resend_validation_code/user_resend_validation_code_input.dart';

final class UserResendValidationCodeInputDto
    extends UserResendValidationCodeInput {
  UserResendValidationCodeInputDto.fromJson(Map<String, dynamic> json)
      : super(
          email: EmailInputField(_emailKey, json[_emailKey]),
        );

  // KEYS:
  // ---------------------------------------------------------------------------
  static const _emailKey = 'email';
}
