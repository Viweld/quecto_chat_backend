/// Interface for token manager
abstract interface class TokenManagerFacade {
  // GENERATION TOKENS:
  // ---------------------------------------------------------------------------
  /// Generates an access token based on the user ID
  String generateAccessToken(String userId);

  /// Generates a refresh token based on the user ID
  Future<String> generateRefreshToken(String userId);

  // VALIDATION TOKENS:
  // ---------------------------------------------------------------------------
  /// Validates the refresh token and returns the user ID
  Future<String> validateRefreshToken(String tokenValue);

  /// Validates the access token and returns the user ID
  String validateAccessToken(String tokenValue);

  // TERMINATE USER SESSIONS:
  // ---------------------------------------------------------------------------
  /// Clear user refresh-tokens whitelist
  Future<void> clearUserWhitelist(String userId);
}
