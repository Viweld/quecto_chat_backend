import '../../exceptions/app_exceptions.dart';
import '../../interfaces/token_service.dart';
import '../../interfaces/user_repository.dart';

// Input data-structure
// -----------------------------------------------------------------------------
base class UserLoginInput {
  const UserLoginInput({
    required this.email,
    required this.password,
  });

  /// User e-mail
  final String email;

  /// Account password
  final String password;
}

// Output data-structure
// -----------------------------------------------------------------------------
base class UserLoginOutput {
  const UserLoginOutput({
    required this.access,
    required this.refresh,
  });

  /// access-token
  final String access;

  /// refresh-token
  final String refresh;
}

// Use-case
// -----------------------------------------------------------------------------
class UserLogin {
  UserLogin(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  // ---------------------------------------------------------------------------
  Future<UserLoginOutput> call(UserLoginInput credentials) async {
    // verifying credentials
    final user = await _userRepository.getUserByEmail(credentials.email);
    if (user == null || user.password != credentials.password) {
      throw const WrongEmailOrPassword();
    }

    // return generated access and refresh tokens
    return UserLoginOutput(
      access: _tokenService.generateAccessToken(user.id),
      refresh: _tokenService.generateRefreshToken(user.id),
    );
  }
}
