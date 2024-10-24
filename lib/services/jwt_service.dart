import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/interfaces/token_service.dart';

/// Implementation of TokenService
class JwtService implements TokenService {
  static const _secretKey = 'your_secret_key';
  static const _accessTokenDuration = Duration(minutes: 15);
  static const _refreshTokenDuration = Duration(days: 7);

  // Method for generating access token
  @override
  String generateAccessToken(String userId) {
    final expiry = DateTime.now().add(_accessTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  // Method for generating refresh token
  @override
  String generateRefreshToken(String userId) {
    final expiry = DateTime.now().add(_refreshTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  // Method to validate token and extract userId
  @override
  String validateToken(String token) {
    try {
      // Verifying a token using a secret key
      final jwt = JWT.verify(token, SecretKey(_secretKey));
      return jwt.payload['sub'] as String; // Return userId from token
    } catch (e) {
      throw Exception('Invalid token: $e');
    }
  }
}
