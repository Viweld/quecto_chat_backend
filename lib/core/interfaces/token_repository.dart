/// Interface for token repository
/// (accessToken - blacklist in memory, refreshToken - whitelist in database)
abstract interface class TokenRepository {
  /// Add access-token to blacklist
  void addAccessTokenToBlacklist(String token);

  /// Add refresh-token to whitelist
  Future<void> addRefreshTokenToWhitelist(String token);

  /// Remove refresh-token from whitelist
  Future<void> removeRefreshTokenFromWhitelist(String token);

  /// Checks if the access-token is in the blacklist
  bool isAccessTokenInBlacklist(String token);

  /// Checks if the refresh-token is in the whitelist
  Future<bool> isRefreshTokenInWhitelist(String token);
}
