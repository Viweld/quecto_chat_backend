import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_session.freezed.dart';

@freezed
class UserSession with _$UserSession {
  const factory UserSession({
    /// Unique session identifier. Empty by default.
    @Default('') String id,

    /// User ID (session owner)
    required String userId,

    /// Refresh-token
    required String refreshToken,

    /// expiration time in seconds since epoch
    required int expirationTime,

    /// Session name (optional)
    String? sessionName,
  }) = _UserSession;
}
