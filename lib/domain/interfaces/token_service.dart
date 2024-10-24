/// Interface for token service
abstract interface class TokenService {
  /// Generates an access token based on the user ID
  String generateAccessToken(String userId);

  /// Generates a refresh token based on the user ID
  String generateRefreshToken(String userId);

  /// Validates the token. If validation is successful, returns the user ID
  String validateToken(String token);
}
