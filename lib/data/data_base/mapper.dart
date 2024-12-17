part of 'postgres_data_base.dart';

final class _Mapper {
  const _Mapper._();

  // USER:
  // ---------------------------------------------------------------------------
  /// Parsing user data from the DB to the User model
  static User _parseUser(Map<String, Object?> src) {
    return User(
      id: '${src[_Keys._fCommonPrimaryKey]}',
      fullName: src[_Keys._fUser$fullName] as String,
      createdAt: DateTime.parse('${src[_Keys._fUser$createdAt]}'),
      email: src[_Keys._fUser$email] as String,
      password: src[_Keys._fUser$password] as String,
      verificationCode: src[_Keys._fUser$verificationCode] as String?,
      verificationCodeSentAt: src[_Keys._fUser$verificationCodeSentAt] as int?,
      isVerified: src[_Keys._fUser$isVerified] as bool,
    );
  }

  /// Mapping user data from User to a structure for the DB
  static Map<String, Object?> _mapUser({required User src}) => {
        _Keys._fUser$fullName: src.fullName,
        _Keys._fUser$createdAt: '${src.createdAt}',
        _Keys._fUser$email: src.email,
        _Keys._fUser$password: src.password,
        _Keys._fUser$verificationCode: src.verificationCode,
        _Keys._fUser$verificationCodeSentAt: src.verificationCodeSentAt,
        _Keys._fUser$isVerified: src.isVerified,
      };

  // USER SESSION:
  // ---------------------------------------------------------------------------
  /// Parsing user data from the DB to the User model
  static UserSession _parseUserSession(Map<String, Object?> src) {
    return UserSession(
      id: src[_Keys._fCommonPrimaryKey] as String,
      userId: src[_Keys._fUserSession$userId] as String,
      refreshToken: src[_Keys._fUserSession$refreshToken] as String,
      expirationTime: src[_Keys._fUserSession$expirationTime] as int,
      sessionName: src[_Keys._fUserSession$sessionName] as String?,
    );
  }

  /// Mapping user data from User to a structure for the DB
  static Map<String, Object?> _mapUserSession({required UserSession src}) => {
        _Keys._fUserSession$userId: src.userId,
        _Keys._fUserSession$refreshToken: src.refreshToken,
        _Keys._fUserSession$expirationTime: src.expirationTime,
        _Keys._fUserSession$sessionName: src.sessionName,
      };
}
