import '../../exceptions/app_exceptions.dart';
import '../../interfaces/token_service.dart';
import '../../interfaces/user_repository.dart';
import '../../models/inputs/user/user_registration_validate_input.dart';
import '../../models/outputs/user/user_registration_validate_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserRegistrationValidate {
  UserRegistrationValidate(this._userRepository, this._tokenService);

  final UserRepository _userRepository;
  final TokenService _tokenService;

  // ---------------------------------------------------------------------------
  Future<UserRegistrationValidateOutput> call(
    UserRegistrationValidateInput input,
  ) async {
    // validation input fields
    final validationResult = input.checkFields();
    if (validationResult.isNotEmpty) {
      throw InvalidRequestBodyValues(validationResult);
    }

    // get user pre-registration data
    final preRegisteredUser =
        await _userRepository.getUserByEmail(input.email.value);

    // check user data
    if (preRegisteredUser == null) {
      throw const UnknownUserEmail();
    } else if (preRegisteredUser.isVerified) {
      throw const AlreadyVerified();
    } else if (preRegisteredUser.verificationCode !=
        input.validationCode.value) {
      throw const WrongVerificationCode();
    }

    // update user data in database
    await _userRepository.updateUser(preRegisteredUser.copyWith(
      verificationCode: null,
      verificationCodeSentAt: null,
      isVerified: true,
    ));

    // return generated access and refresh tokens
    return UserRegistrationValidateOutput(
      access: _tokenService.generateAccessToken(preRegisteredUser.id),
      refresh: _tokenService.generateRefreshToken(preRegisteredUser.id),
    );
  }
}
