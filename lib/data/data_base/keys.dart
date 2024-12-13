part of 'postgres_data_base.dart';

/// All keys must be in camel_case
class _Keys {
  static const _fCommonPrimaryKey = 'id';

  // User keys:
  static const _tUsers = 'users';
  static const _fUser$fullName = 'full_name';
  static const _fUser$createdAt = 'created_at';
  static const _fUser$email = 'email';
  static const _fUser$password = 'password';
  static const _fUser$verificationCode = 'verification_code';
  static const _fUser$verificationCodeSentAt = 'verification_code_sent_at';
  static const _fUser$isVerified = 'is_verified';

  // Sessions keys:
  static const _tUserSessions = 'sessions';
  static const _fUserSession$userId = 'user_id';
  static const _fUserSession$refreshToken = 'refresh_token';
  static const _fUserSession$expirationTime = 'expiration_time';
  static const _fUserSession$sessionName = 'session_name';
}
