import '../../../../../core/interfaces/token_manager_facade.dart';
import '../../../../../core/interfaces/token_service.dart';
import '../../../../../core/interfaces/user_repository.dart';
import '../../../../exceptions/app_exceptions.dart';
import 'user_registration_validate_input.dart';
import 'user_registration_validate_output.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserRegistrationValidate {
  UserRegistrationValidate(this._userRepository, this._tokenManagerFacade);

  final UserRepository _userRepository;
  final TokenManagerFacade _tokenManagerFacade;

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

    // generate tokens
    final access =
        _tokenManagerFacade.generateAccessToken(preRegisteredUser.id);
    final refresh =
        await _tokenManagerFacade.generateRefreshToken(preRegisteredUser.id);

    // return tokens
    return UserRegistrationValidateOutput(access: access, refresh: refresh);
  }
}
