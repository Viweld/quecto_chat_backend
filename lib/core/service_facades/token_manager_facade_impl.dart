import '../../domain/exceptions/app_exceptions.dart';
import '../interfaces/token_manager_facade.dart';
import '../interfaces/token_repository.dart';
import '../interfaces/token_service.dart';

class TokenManagerFacadeImpl implements TokenManagerFacade {
  const TokenManagerFacadeImpl({
    required TokenService tokenService,
    required TokenRepository tokenRepository,
  })  : _tokenService = tokenService,
        _tokenRepository = tokenRepository;

  final TokenService _tokenService;
  final TokenRepository _tokenRepository;

  @override
  String generateAccessToken(String userId) =>
      _tokenService.generateAccessToken(userId).userId;

  @override
  Future<String> generateRefreshToken(String userId) async {
    // Generate refresh-token using the service
    final token = _tokenService.generateRefreshToken(userId);
    // Add the generated refresh token to the whitelist
    await _tokenRepository.addRefreshTokenToWhitelist(token);
    // Return user ID
    return token.userId;
  }

  @override
  String validateAccessToken(String tokenValue) {
    // Validate the token using the service
    final token = _tokenService.validateAccessToken(tokenValue);
    // Return user ID
    return token.userId;
  }

  @override
  Future<String> validateRefreshToken(String tokenValue) async {
    // Validate the token using the service
    final token = _tokenService.validateRefreshToken(tokenValue);
    // Check if the token is in the whitelist
    final isWhitelisted =
        await _tokenRepository.isRefreshTokenInWhitelist(token);
    if (!isWhitelisted) {
      throw const RefreshTokenIsNotWhitelisted();
    }
    // Return user ID
    return token.userId;
  }

  @override
  Future<void> clearUserWhitelist(String userId) =>
      _tokenRepository.clearUserWhitelist(userId);
}
