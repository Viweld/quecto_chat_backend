part of 'postgres_data_base.dart';

class _Migration {
  // ---------------------------------------------------------------------------
  // при создании БД
  static Future<void> _onConnectionCreate(Connection connection) async {
    try {
      await connection
          // таблица о пользователе
          .execute('CREATE TABLE IF NOT EXISTS ${_Keys._tUsers} ('
              '${_Keys._fCommonPrimaryKey} SERIAL PRIMARY KEY, '
              '${_Keys._fUser$fullName} TEXT NOT NULL, '
              '${_Keys._fUser$createdAt} TEXT NOT NULL, '
              '${_Keys._fUser$email} TEXT NOT NULL, '
              '${_Keys._fUser$password} TEXT NOT NULL'
              ');');
    } on Object {
      rethrow;
    }
  }
}
