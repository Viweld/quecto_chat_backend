import 'dart:math';

import '../../entities/user.dart';
import '../../exceptions/app_exceptions.dart';
import '../../interfaces/token_service.dart';
import '../../interfaces/user_repository.dart';
import '../../models/inputs/user/user_token_refresh.dart';
import '../../models/outputs/user/user_token_refresh_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserTokenRefresh {
  UserTokenRefresh(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  // ---------------------------------------------------------------------------
  Future<UserTokenRefreshOutput> call(UserTokenRefreshInput input) async {
    // validation input fields
    final validationResult = input.checkFields();
    if (validationResult.isNotEmpty) {
      throw InvalidRequestBodyValues(validationResult);
    }

    final userId = _tokenService.validateToken(input.refresh.value);
    final newAccessToken = jwtService.generateAccessToken(userId);
  }
}
