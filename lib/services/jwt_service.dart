import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/interfaces/token_service.dart';

/// Реализация TokenService
class JwtService implements TokenService {
  static const _secretKey = 'your_secret_key'; // секретный ключ
  static const _accessTokenDuration = Duration(minutes: 15);
  static const _refreshTokenDuration = Duration(days: 7);

  // Метод для генерации access-токена
  @override
  String generateAccessToken(String userId) {
    final expiry = DateTime.now().add(_accessTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time в секундах
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  // Метод для генерации refresh-токена
  @override
  String generateRefreshToken(String userId) {
    final expiry = DateTime.now().add(_refreshTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time в секундах
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  // Метод для валидации токена и извлечения userId
  @override
  String validateToken(String token) {
    try {
      // Верификация токена с использованием секретного ключа
      final jwt = JWT.verify(token, SecretKey(_secretKey));
      return jwt.payload['sub'] as String; // Возвращаем userId из токена
    } catch (e) {
      throw Exception('Invalid token: $e');
    }
  }
}