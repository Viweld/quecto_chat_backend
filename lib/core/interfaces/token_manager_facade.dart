/// Interface for token manager
abstract interface class TokenManagerFacade {
  /// Generates an access token based on the user ID
  String generateAccessToken(String userId);

  /// Generates a refresh token based on the user ID
  Future<String> generateRefreshToken(String userId);

  /// Validates the refresh token and returns the user ID
  Future<String> validateRefreshToken(String token);

  /// Validates the access token and returns the user ID
  String validateAccessToken(String token);

  /// Remove refresh token from the whitelist
  Future<void> removeRefreshTokenFromWhitelist(String token);

  /// Add access token to blacklist
  void blacklistedAccessToken(String token);
}
