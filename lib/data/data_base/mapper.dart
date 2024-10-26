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
    );
  }

  /// Mapping user data from User to a structure for the DB
  static Map<String, Object?> _mapUser({
    required String fullName,
    required DateTime createdAt,
    required String email,
    required String password,
  }) =>
      {
        _Keys._fUser$fullName: fullName,
        _Keys._fUser$createdAt: '$createdAt',
        _Keys._fUser$email: email,
        _Keys._fUser$password: password,
      };
}
