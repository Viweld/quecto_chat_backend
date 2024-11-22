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
  static Map<String, Object?> _mapUser({
    required String fullName,
    required DateTime createdAt,
    required String email,
    required String password,
    required String verificationCode,
    required int verificationCodeSentAt,
    required bool isVerified,
  }) =>
      {
        _Keys._fUser$fullName: fullName,
        _Keys._fUser$createdAt: '$createdAt',
        _Keys._fUser$email: email,
        _Keys._fUser$password: password,
        _Keys._fUser$verificationCode: verificationCode,
        _Keys._fUser$verificationCodeSentAt: verificationCodeSentAt,
        _Keys._fUser$isVerified: isVerified ? 1 : 0,
      };
}
