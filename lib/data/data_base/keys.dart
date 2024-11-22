part of 'postgres_data_base.dart';

class _Keys {
  static const _fCommonPrimaryKey = 'id';

  // Table keys and user data fields:
  static const _tUsers = 'users';
  static const _fUser$fullName = 'fullName';
  static const _fUser$createdAt = 'createdAt';
  static const _fUser$email = 'email';
  static const _fUser$password = 'password';
  static const _fUser$verificationCode = 'verificationCode';
  static const _fUser$verificationCodeSentAt = 'verificationCodeSentAt';
  static const _fUser$isVerified = 'isVerified';

  // Table keys and message data fields:
  // static const _tMessages = 'messages';
  // static const _fMessage$fromId = 'fromId';
  // static const _fMessage$toId = 'toId';
  // static const _fMessage$timestamp = 'timestamp';
  // static const _fMessage$content = 'content';
  // static const _fMessage$type = 'type';
}
