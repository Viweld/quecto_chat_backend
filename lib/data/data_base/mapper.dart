part of 'postgres_data_base.dart';

final class _Mapper {
  const _Mapper._();

  // USER:
  // ---------------------------------------------------------------------------
  /// Parsing user data from the DB to the User model
  static User _parseUser(Map<String, Object?> src) {
    return User(
      id: src[_Keys._fCommonPrimaryKey] as String,
      fullName: src[_Keys._fUser$fullName] as String,
      createdAt: DateTime.parse('${src[_Keys._fUser$createdAt]}'),
      email: src[_Keys._fUser$email] as String,
      password: src[_Keys._fUser$password] as String,
      verificationCode: src[_Keys._fUser$verificationCode] as String?,
      verificationCodeSentAt: src[_Keys._fUser$verificationCodeSentAt] as int?,
      isVerified: (src[_Keys._fUser$isVerified] as int) == 1,
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
        _Keys._fUser$isVerified: src.isVerified ? 1 : 0,
      };
}
