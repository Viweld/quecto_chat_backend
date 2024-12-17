import '../../../domain/use_cases/user/auth/login/user_login_output.dart';

abstract final class UserLoginOutputDto {
  static const String _accessKey = 'access';
  static const String _refreshKey = 'refresh';

  // ---------------------------------------------------------------------------
  /// Serialization
  static Map<String, dynamic> toJson(UserLoginOutput src) => {
        _accessKey: src.access,
        _refreshKey: src.refresh,
      };
}
