import 'package:meta/meta.dart';

@immutable
final class Token {
  const Token({
    required this.value,
    required this.userId,
    required this.expirationTime,
    required this.type,
  });

  /// Token
  final String value;

  /// User ID
  final String userId;

  /// Expiration time in seconds
  final int expirationTime;

  /// Token type: 'access', 'refresh'
  final String type;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Token &&
            runtimeType == other.runtimeType &&
            value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
