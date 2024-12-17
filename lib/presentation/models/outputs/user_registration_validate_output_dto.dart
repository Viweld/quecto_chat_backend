import '../../../domain/use_cases/user/auth/registration_validate/user_registration_validate_output.dart';

abstract final class UserRegistrationValidateOutputDto {
  static const String _accessKey = 'access';
  static const String _refreshKey = 'refresh';

  // ---------------------------------------------------------------------------
  /// Serialization
  static Map<String, dynamic> toJson(UserRegistrationValidateOutput src) => {
        _accessKey: src.access,
        _refreshKey: src.refresh,
      };
}
