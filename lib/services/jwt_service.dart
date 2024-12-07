import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/exceptions/app_exceptions.dart';
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
      'sub': userId,
      'exp': expiry.millisecondsSinceEpoch ~/ 1000,
      'type': 'access',
    });

    return jwt.sign(SecretKey(_env.jwtSecretKey));
  }

  // Method for generating refresh token
  @override
  String generateRefreshToken(String userId) {
    final expiry = DateTime.now().add(_env.jwtRefreshTokenDuration);
    final jwt = JWT({
      'sub': userId,
      'exp': expiry.millisecondsSinceEpoch ~/ 1000,
      'type': 'refresh',
    });

    return jwt.sign(SecretKey(_env.jwtSecretKey));
  }

  // Method to validate refresh token and extract userId
  @override
  String validateRefreshToken(String token) {
    try {
      // Verifying a token using a secret key
      final jwt = JWT.verify(token, SecretKey(_env.jwtSecretKey));

      final payload = jwt.payload as Map<String, dynamic>;
      final expiry =
          DateTime.fromMillisecondsSinceEpoch((payload['exp'] as int) * 1000);

      // Check expiration time
      if (expiry.isBefore(DateTime.now())) throw const TokenExpired();

      if (payload['type'] != 'refresh') {
        throw const TokenIsNotRefreshToken();
      }

      return '${payload['sub']}';
    } on Object {
      throw const InvalidToken();
    }
  }
}
