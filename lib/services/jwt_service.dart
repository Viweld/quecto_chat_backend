import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/interfaces/env_parameters.dart';
import '../domain/interfaces/token_service.dart';

/// Implementation of TokenService
class JwtService implements TokenService {
  JwtService(EnvParameters env) : _env = env;

  final EnvParameters _env;

  // Method for generating access token
  @override
  String generateAccessToken(String userId) {
    final expiry = DateTime.now().add(_env.jwtAccessTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time
    });

    return jwt.sign(SecretKey(_env.jwtSecretKey));
  }

  // Method for generating refresh token
  @override
  String generateRefreshToken(String userId) {
    final expiry = DateTime.now().add(_env.jwtRefreshTokenDuration);
    final jwt = JWT({
      'sub': userId, // subject (user ID)
      'exp': expiry.millisecondsSinceEpoch ~/ 1000, // expiry time
    });

    return jwt.sign(SecretKey(_env.jwtSecretKey));
  }

  // Method to validate token and extract userId
  @override
  String validateToken(String token) {
    try {
      // Verifying a token using a secret key
      final jwt = JWT.verify(token, SecretKey(_env.jwtSecretKey));
      final jwtPayload = jwt.payload as Map<String, Object>;
      return '${jwtPayload['sub']}'; // Return userId from token
    } catch (e) {
      throw Exception('Invalid token: $e');
    }
  }
}
