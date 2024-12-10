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
      _tokenService.generateAccessToken(userId);

  @override
  Future<String> generateRefreshToken(String userId) async {
    final token = _tokenService.generateRefreshToken(userId);
    // Add the generated refresh token to the whitelist
    await _tokenRepository.addRefreshTokenToWhitelist(token);
    return token;
  }

  @override
  String validateAccessToken(String token) {
    // Check if the token is in the blacklist
    if (_tokenRepository.isAccessTokenInBlacklist(token)) {
      throw const AccessTokenIsBlacklisted();
    }
    // Validate the token using the service
    return _tokenService.validateAccessToken(token);
  }

  @override
  Future<String> validateRefreshToken(String token) async {
    // Check if the token is in the whitelist
    final isWhitelisted =
        await _tokenRepository.isRefreshTokenInWhitelist(token);
    if (!isWhitelisted) {
      throw const RefreshTokenIsNotWhitelisted();
    }
    // Validate the token using the service
    return _tokenService.validateRefreshToken(token);
  }

  @override
  Future<void> removeRefreshTokenFromWhitelist(String token) =>
      _tokenRepository.removeRefreshTokenFromWhitelist(token);

  @override
  void blacklistedAccessToken(String token) =>
      _tokenRepository.addAccessTokenToBlacklist(token);
}
