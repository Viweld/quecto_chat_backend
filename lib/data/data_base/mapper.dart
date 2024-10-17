part of 'postgres_data_base.dart';

/// Маппер данных
class _Mapper {
  // ПОЛЬЗОВАТЕЛЬ:
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /// Парсинг данных пользователя из БД на модель User
  User _parseUser(Map<String, Object?> src) {
    return User(
      id: src[_Keys._fUser$id] as String,
      fullName: src[_Keys._fUser$fullName] as String,
      createdAt: DateTime.parse('${src[_Keys._fUser$createdAt]}'),
      email: src[_Keys._fUser$email] as String,
      password: src[_Keys._fUser$password] as String,
    );
  }

  /// Маппинг данных пользователя из User на структуру для БД
  Map<String, Object?> _mapUser(User src) => {
        _Keys._fUser$id: src.id,
        _Keys._fUser$fullName: src.fullName,
        _Keys._fUser$createdAt: '${src.createdAt}',
        _Keys._fUser$email: src.email,
        _Keys._fUser$password: src.password,
      };

// // СООБЩЕНИЕ:
// // ---------------------------------------------------------------------------
// // ---------------------------------------------------------------------------
// // ---------------------------------------------------------------------------
// /// Парсинг данных сообщения из БД на модель ChatMessage
// ChatMessage _parseChatMessage({
//   required Map<String, Object?> src,
//   String? currentUserId,
// }) {
//   final fromId = src[_Keys._fMessage$fromId] as String;
//   return ChatMessage(
//     fromId: fromId,
//     isOwn: fromId == currentUserId,
//     toId: src[_Keys._fMessage$toId] as String,
//     content: src[_Keys._fMessage$content] as String,
//     type: _parseChatMessageType(src[_Keys._fMessage$type] as String),
//     createdAt: DateTime.fromMicrosecondsSinceEpoch(
//       src[_Keys._fMessage$timestamp] as int,
//     ),
//   );
// }
//
// /// Маппинг данных сообщения из ChatMessage на структуру для БД
// Map<String, Object?> _mapChatMessage(ChatMessage src) => {
//       _Keys._fMessage$fromId: src.fromId,
//       _Keys._fMessage$toId: src.toId,
//       _Keys._fMessage$content: src.content,
//       _Keys._fMessage$type: _mapChatMessageType(src.type),
//       _Keys._fMessage$timestamp: src.createdAt.microsecondsSinceEpoch,
//     };
//
// /// Парсинг данных типа сообщения из БД на модель ChatMessage
// ChatMessageType _parseChatMessageType(String src) {
//   return switch (src) {
//     'text' => ChatMessageType.text,
//     _ => throw UnsupportedError('Unknown message type in mapper'),
//   };
// }
//
// /// Маппинг данных типа сообщения из ChatMessage на структуру для БД
// String _mapChatMessageType(ChatMessageType src) {
//   return switch (src) {
//     ChatMessageType.text => 'text',
//   };
// }
}
