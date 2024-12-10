import '../../domain/value_objects/token/token.dart';

/// Interface for token repository
/// (accessToken - blacklist in memory, refreshToken - whitelist in database)
abstract interface class TokenRepository {
  /// Add access-token to blacklist
  void addAccessTokenToBlacklist(Token token);

  /// Add refresh-token to whitelist
  Future<void> addRefreshTokenToWhitelist(Token token);

  /// Remove refresh-token from whitelist
  Future<void> removeRefreshTokenFromWhitelist(Token token);

  /// Checks if the access-token is in the blacklist
  bool isAccessTokenInBlacklist(Token token);

  /// Checks if the refresh-token is in the whitelist
  Future<bool> isRefreshTokenInWhitelist(Token token);
}
