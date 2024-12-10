import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../core/interfaces/env_parameters.dart';
import '../../core/interfaces/token_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../domain/value_objects/token/token.dart';

/// Implementation of TokenService
final class JwtService implements TokenService {
  JwtService(this._env);

  final EnvParameters _env;

  static const _subKey = 'sub';
  static const _expKey = 'exp';
  static const _typeKey = 'type';

  // Method for generating access token
  @override
  Token generateAccessToken(String userId) {
    const type = 'access';
    final expiry = DateTime.now().add(_env.jwtAccessTokenDuration);
    final expirySeconds = expiry.millisecondsSinceEpoch ~/ 1000;

    final jwt = JWT({
      _subKey: userId,
      _expKey: expirySeconds,
      _typeKey: type,
    });

    return Token(
      value: jwt.sign(SecretKey(_env.jwtSecretKey)),
      userId: userId,
      expirationTime: expirySeconds,
      type: type,
    );
  }

  // Method for generating refresh token
  @override
  Token generateRefreshToken(String userId) {
    const type = 'refresh';
    final expiry = DateTime.now().add(_env.jwtRefreshTokenDuration);
    final expirySeconds = expiry.millisecondsSinceEpoch ~/ 1000;

    final jwt = JWT({
      _subKey: userId,
      _expKey: expirySeconds,
      _typeKey: type,
    });

    return Token(
      value: jwt.sign(SecretKey(_env.jwtSecretKey)),
      userId: userId,
      expirationTime: expirySeconds,
      type: type,
    );
  }

  // Method to validate refresh token and extract userId
  @override
  Token validateRefreshToken(String tokenValue) {
    final token = decodeTokenByValue(tokenValue);
    _checkTokenType(token, 'refresh');
    _checkExpiry(token);
    return token;
  }

  // Method to validate access token and extract userId
  @override
  Token validateAccessToken(String tokenValue) {
    final token = decodeTokenByValue(tokenValue);
    _checkTokenType(token, 'access');
    _checkExpiry(token);
    return token;
  }

  @override
  Token decodeTokenByValue(String tokenValue) {
    try {
      final jwt = JWT.verify(tokenValue, SecretKey(_env.jwtSecretKey));
      final payload = jwt.payload as Map<String, dynamic>;
      return Token(
        value: tokenValue,
        userId: payload[_subKey],
        expirationTime: payload[_expKey],
        type: payload[_typeKey],
      );
    } on Object {
      throw const InvalidToken();
    }
  }

  // HELPER METHODS:
  // ---------------------------------------------------------------------------
  /// Helper method for checking token expiration
  void _checkExpiry(Token token) {
    final seconds = token.expirationTime;
    final expiry = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    if (expiry.isBefore(DateTime.now())) {
      throw const TokenExpired();
    }
  }

  /// Helper method for checking token type
  void _checkTokenType(Token token, String expectedType) {
    if (token.type != expectedType) {
      throw expectedType == 'refresh'
          ? const TokenIsNotRefreshToken()
          : const TokenIsNotAccessToken();
    }
  }
}
