part of 'postgres_data_base.dart';

class _Keys {
  static const _fCommonPrimaryKey = 'id';

  // User keys:
  static const _tUsers = 'users';
  static const _fUser$fullName = 'fullName';
  static const _fUser$createdAt = 'createdAt';
  static const _fUser$email = 'email';
  static const _fUser$password = 'password';
  static const _fUser$verificationCode = 'verificationCode';
  static const _fUser$verificationCodeSentAt = 'verificationCodeSentAt';
  static const _fUser$isVerified = 'isVerified';

  // Sessions keys:
  static const _tUserSessions = 'sessions';
  static const _fUserSession$userId = 'userId';
  static const _fUserSession$refreshToken = 'refreshToken';
  static const _fUserSession$expirationTime = 'expirationTime';
  static const _fUserSession$sessionName = 'sessionName';
}
