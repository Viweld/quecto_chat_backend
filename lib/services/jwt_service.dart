import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../domain/exceptions/app_exceptions.dart';
import '../core/interfaces/env_parameters.dart';
import '../core/interfaces/token_service.dart';

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
    final payload = _verifyAndGetPayload(token);
    _checkTokenType(payload, 'refresh');
    _checkExpiry(payload);
    return '${payload['sub']}';
  }

  // Method to validate access token and extract userId
  @override
  String validateAccessToken(String token) {
    final payload = _verifyAndGetPayload(token);
    _checkTokenType(payload, 'access');
    _checkExpiry(payload);
    return '${payload['sub']}';
  }

  /// HANDLE METHODS:
  // ---------------------------------------------------------------------------
  /// Helper method for token verification and data extraction
  Map<String, dynamic> _verifyAndGetPayload(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_env.jwtSecretKey));
      return jwt.payload as Map<String, dynamic>;
    } on Object {
      throw const InvalidToken();
    }
  }

  /// Helper method for checking token expiration
  void _checkExpiry(Map<String, dynamic> payload) {
    final milliseconds = payload['exp'] as int;
    final expiry = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
    if (expiry.isBefore(DateTime.now())) {
      throw const TokenExpired();
    }
  }

  /// Helper method for checking token type
  void _checkTokenType(Map<String, dynamic> payload, String expectedType) {
    if (payload['type'] != expectedType) {
      throw expectedType == 'refresh'
          ? const TokenIsNotRefreshToken()
          : const TokenIsNotAccessToken();
    }
  }
}
