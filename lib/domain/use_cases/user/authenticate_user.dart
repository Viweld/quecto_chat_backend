import '../../entities/user/user_login_credentials.dart';
import '../../exceptions/app_exceptions.dart';
import '../../interfaces/token_service.dart';
import '../../interfaces/user_repository.dart';

class AuthenticateUser {
  AuthenticateUser(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  Future<Map<String, String>> call(UserLoginCredentials credentials) async {
    // verifying credentials
    final user = await _userRepository.getUserByEmail(credentials.email);
    if (user == null || user.password != credentials.password) {
      throw const WrongEmailOrPassword();
    }

    // generate access and refresh tokens
    final accessToken = _tokenService.generateAccessToken(user.id);
    final refreshToken = _tokenService.generateRefreshToken(user.id);

    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
