part of 'postgres_data_base.dart';

class _Keys {
  static const _fCommonPrimaryKey = 'id';

  // Ключи таблицы и полей данных пользователей:
  static const _tUsers = 'users';
  static const _fUser$fullName = 'fullName';
  static const _fUser$createdAt = 'createdAt';
  static const _fUser$email = 'email';
  static const _fUser$password = 'password';
  //static const _fUser$photoUrl = 'photoUrl';
  //static const _fUser$chattingWith = 'chattingWith';

  // Ключи таблицы и полей данных сообщений:
  // static const _tMessages = 'messages';
  // static const _fMessage$fromId = 'fromId';
  // static const _fMessage$toId = 'toId';
  // static const _fMessage$timestamp = 'timestamp';
  // static const _fMessage$content = 'content';
  // static const _fMessage$type = 'type';
}
