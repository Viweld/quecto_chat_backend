import '../../domain/value_objects/token/token.dart';

/// Interface for token service
abstract interface class TokenService {
  /// Generates an access token based on the user ID. Return [Token] object
  Token generateAccessToken(String userId);

  /// Generates a refresh token based on the user ID. Return [Token] object
  Token generateRefreshToken(String userId);

  /// Validates the refresh token and and returns [Token] object
  Token validateRefreshToken(String tokenValue);

  /// Validates the access token and returns [Token] object
  Token validateAccessToken(String tokenValue);

  /// Decode token by his value and returns [Token] object
  Token decodeTokenByValue(String tokenValue);
}
