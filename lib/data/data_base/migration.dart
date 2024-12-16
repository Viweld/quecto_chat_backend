part of 'postgres_data_base.dart';

class _Migration {
  // ---------------------------------------------------------------------------
  // when creating a database
  static Future<void> _onConnectionCreate(Connection connection) async {
    try {
      // Users table
      await connection
          .execute('CREATE TABLE IF NOT EXISTS public.${_Keys._tUsers} ('
              '${_Keys._fCommonPrimaryKey} SERIAL PRIMARY KEY, '
              '${_Keys._fUser$fullName} TEXT NOT NULL, '
              '${_Keys._fUser$createdAt} TEXT NOT NULL, '
              '${_Keys._fUser$email} TEXT NOT NULL, '
              '${_Keys._fUser$password} TEXT NOT NULL, '
              '${_Keys._fUser$verificationCode} TEXT, '
              '${_Keys._fUser$verificationCodeSentAt} BIGINT, '
              '${_Keys._fUser$isVerified} BOOLEAN NOT NULL'
              ');');

      // User sessions table
      await connection
          .execute('CREATE TABLE IF NOT EXISTS public.${_Keys._tUserSessions} ('
              '${_Keys._fCommonPrimaryKey} SERIAL PRIMARY KEY, '
              '${_Keys._fUserSession$userId} TEXT NOT NULL, '
              '${_Keys._fUserSession$refreshToken} TEXT NOT NULL, '
              '${_Keys._fUserSession$expirationTime} BIGINT NOT NULL, '
              '${_Keys._fUserSession$sessionName} TEXT'
              ');');
    } on Object {
      rethrow;
    }
  }
}
