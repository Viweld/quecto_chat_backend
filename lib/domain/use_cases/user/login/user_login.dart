import '../../../exceptions/app_exceptions.dart';
import '../../../../core/interfaces/token_service.dart';
import '../../../../core/interfaces/user_repository.dart';
import 'user_login_input.dart';
import 'user_login_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserLogin {
  UserLogin(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  // ---------------------------------------------------------------------------
  Future<UserLoginOutput> call(UserLoginInput input) async {
    // validation input fields
    final validationResult = input.checkFields();
    if (validationResult.isNotEmpty) {
      throw InvalidRequestBodyValues(validationResult);
    }

    // verifying credentials
    final user = await _userRepository.getUserByEmail(input.email.value);
    if (user == null || user.password != input.password.value) {
      throw const WrongEmailOrPassword();
    }

    // return generated access and refresh tokens
    return UserLoginOutput(
      access: _tokenService.generateAccessToken(user.id),
      refresh: _tokenService.generateRefreshToken(user.id),
    );
  }
}
