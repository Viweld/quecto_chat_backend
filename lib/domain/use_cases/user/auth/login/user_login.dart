import '../../../../../core/interfaces/token_manager_facade.dart';
import '../../../../../core/interfaces/user_repository.dart';
import '../../../../exceptions/app_exceptions.dart';
import 'user_login_input.dart';
import 'user_login_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserLogin {
  UserLogin(this._userRepository, this._tokenManagerFacade);

  final UserRepository _userRepository;
  final TokenManagerFacade _tokenManagerFacade;

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

    // generate tokens
    final access = _tokenManagerFacade.generateAccessToken(user.id);
    final refresh = await _tokenManagerFacade.generateRefreshToken(user.id);

    // return tokens
    return UserLoginOutput(access: access, refresh: refresh);
  }
}
