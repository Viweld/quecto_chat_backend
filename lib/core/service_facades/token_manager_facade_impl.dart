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
      _tokenService.generateAccessToken(userId).value;

  @override
  Future<String> generateRefreshToken(String userId) async {
    final token = _tokenService.generateRefreshToken(userId);
    await _tokenRepository.addRefreshTokenToWhitelist(token);
    return token.value;
  }

  @override
  String validateAccessToken(String tokenValue) {
    final token = _tokenService.validateAccessToken(tokenValue);
    return token.userId;
  }

  @override
  Future<String> validateRefreshToken(String tokenValue) async {
    final token = _tokenService.validateRefreshToken(tokenValue);
    final isWhitelisted =
        await _tokenRepository.isRefreshTokenInWhitelist(token);
    if (!isWhitelisted) {
      throw const RefreshTokenIsNotWhitelisted();
    }
    return token.userId;
  }

  @override
  Future<void> clearUserWhitelist(String userId) =>
      _tokenRepository.clearUserWhitelist(userId);
}
