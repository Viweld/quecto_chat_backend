import '../../interfaces/token_service.dart';
import '../../interfaces/user_repository.dart';

class AuthenticateUser {
  AuthenticateUser(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  Future<Map<String, String>> call(String email, String password) async {
    // Verifying credentials
    final user = await _userRepository.findUserByEmail(email);
    if (user == null || user.password != password) {
      throw Exception('Invalid email or password');
    }

    // Генерация access и refresh токенов
    final accessToken = _tokenService.generateAccessToken(user.id);
    final refreshToken = _tokenService.generateRefreshToken(user.id);

    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
