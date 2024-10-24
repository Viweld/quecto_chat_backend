part of 'postgres_data_base.dart';

/// Маппер данных
final class _Mapper {
  const _Mapper._();

  // USER:
  // ---------------------------------------------------------------------------
  /// Парсинг данных пользователя из БД на модель User
  static User _parseUser(Map<String, Object?> src) {
    return User(
      id: src[_Keys._fCommonPrimaryKey] as String,
      fullName: src[_Keys._fUser$fullName] as String,
      createdAt: DateTime.parse('${src[_Keys._fUser$createdAt]}'),
      email: src[_Keys._fUser$email] as String,
      password: src[_Keys._fUser$password] as String,
    );
  }

  /// Маппинг данных пользователя из User на структуру для БД
  static Map<String, Object?> _mapUser(User src) => {
        _Keys._fUser$fullName: src.fullName,
        _Keys._fUser$createdAt: '${src.createdAt}',
        _Keys._fUser$email: src.email,
        _Keys._fUser$password: src.password,
      };
}
