import '../../../../../core/interfaces/token_service.dart';
import '../../../../exceptions/app_exceptions.dart';
import 'user_token_refresh_input.dart';
import 'user_token_refresh_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserTokenRefresh {
  UserTokenRefresh(this._tokenService);

  final TokenService _tokenService;

  // ---------------------------------------------------------------------------
  Future<UserTokenRefreshOutput> call(UserTokenRefreshInput input) async {
    try {
      // validation input fields
      final validationResult = input.checkFields();
      if (validationResult.isNotEmpty) {
        throw InvalidRequestBodyValues(validationResult);
      }

      // validate refresh token and get user id
      final userId = _tokenService.validateRefreshToken(input.refresh.value);

      // return generated access and refresh tokens
      return UserTokenRefreshOutput(
        access: _tokenService.generateAccessToken(userId),
        refresh: _tokenService.generateRefreshToken(userId),
      );
    } on TokenExceptions {
      throw const InvalidToken();
    } on Object {
      throw const InternalServerError();
    }
  }
}
