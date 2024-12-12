import '../../domain/value_objects/token/token.dart';

/// Interface for token repository
/// (refreshToken - whitelist in database)
abstract interface class TokenRepository {
  /// Add refresh-token to whitelist
  Future<void> addRefreshTokenToWhitelist(Token token);

  /// Clear user refresh-tokens whitelist
  Future<void> clearUserWhitelist(String userId);

  /// Checks if the refresh-token is in the whitelist
  Future<bool> isRefreshTokenInWhitelist(Token token);
}
