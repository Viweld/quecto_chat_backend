import '../../../../../core/interfaces/token_manager_facade.dart';
import '../../../../exceptions/app_exceptions.dart';
import 'user_token_refresh_input.dart';
import 'user_token_refresh_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserTokenRefresh {
  UserTokenRefresh(this._tokenManagerFacade);

  final TokenManagerFacade _tokenManagerFacade;

  // ---------------------------------------------------------------------------
  Future<UserTokenRefreshOutput> call(UserTokenRefreshInput input) async {
    try {
      // validation input fields
      final validationResult = input.checkFields();
      if (validationResult.isNotEmpty) {
        throw InvalidRequestBodyValues(validationResult);
      }

      // validate refresh token and get user id
      final userId =
          await _tokenManagerFacade.validateRefreshToken(input.refresh.value);

      // generate tokens
      final access = _tokenManagerFacade.generateAccessToken(userId);
      final refresh = await _tokenManagerFacade.generateRefreshToken(userId);

      // return tokens
      return UserTokenRefreshOutput(access: access, refresh: refresh);
    } on TokenExceptions {
      throw const InvalidToken();
    } on Object {
      throw const InternalServerError();
    }
  }
}
