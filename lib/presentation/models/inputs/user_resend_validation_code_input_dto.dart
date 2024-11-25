import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_resend_validation_code_input.dart';

final class UserResendValidationCodeInputDto
    extends UserResendValidationCodeInput {
  UserResendValidationCodeInputDto({
    required super.email,
  });

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserResendValidationCodeInputDto.fromJson(
          Map<String, dynamic> json) =>
      UserResendValidationCodeInputDto(
        email: EmailInputField('email', json['email']),
      );
}
