import '../../exceptions/app_exceptions.dart';
import '../../interfaces/user_repository.dart';
import '../../models/inputs/user/user_registration_validate_input.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserRegistrationValidate {
  UserRegistrationValidate(this._userRepository);

  final UserRepository _userRepository;

  // ---------------------------------------------------------------------------
  Future<void> call(UserRegistrationValidateInput input) async {
    // validate fields credentials
    final validationResult = input.checkFields();
    if (validationResult.isNotEmpty) {
      throw InvalidRequestBodyValues(validationResult);
    }

    // get user pre-registration data
    final preRegisteredUser =
        await _userRepository.getUserByEmail(input.email.value);

    if (preRegisteredUser == null) {
      throw Exception('Введенная почта не зарегистрирована в приложении');
    } else if (preRegisteredUser.isVerified) {
      throw Exception('Пользователь уже подтвержден');
    } else if (preRegisteredUser.verificationCode !=
        input.validationCode.value) {
      throw Exception('Неправильный код подтврждения');
    }

    await _userRepository.updateUser(preRegisteredUser.copyWith(
      verificationCode: null,
      verificationCodeSentAt: null,
      isVerified: true,
    ));
  }
}
