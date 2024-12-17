import '../../../domain/use_cases/user/auth/token_refresh/user_token_refresh_output.dart';

abstract final class UserTokenRefreshOutputDto {
  static const String _accessKey = 'access';
  static const String _refreshKey = 'refresh';

  // ---------------------------------------------------------------------------
  /// Serialization
  static Map<String, dynamic> toJson(UserTokenRefreshOutput src) => {
        _accessKey: src.access,
        _refreshKey: src.refresh,
      };
}
