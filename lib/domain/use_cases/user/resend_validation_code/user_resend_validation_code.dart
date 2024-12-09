import 'dart:math';

import '../../../../core/interfaces/mail_sender_service.dart';
import '../../../../core/interfaces/user_repository.dart';
import '../../../exceptions/app_exceptions.dart';
import 'user_resend_validation_code_input.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserResendValidationCode {
  UserResendValidationCode(this._userRepository, this._mailSenderService);

  final UserRepository _userRepository;
  final MailSenderService _mailSenderService;

  // ---------------------------------------------------------------------------
  Future<void> call(UserResendValidationCodeInput input) async {
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
    } else if (_isSixtySecondsNotPassed(
        preRegisteredUser.verificationCodeSentAt!)) {
      throw const TooManyAttempts();
    }

    // send an email with verification code
    final verificationCode = _generateRandomCode();
    await _mailSenderService.sendEmail(
      input.email.value,
      'Dear ${preRegisteredUser.fullName}',
      'Use this code to complete your registration in Quecto:$verificationCode',
    );

    // update user data in database
    await _userRepository.updateUser(preRegisteredUser.copyWith(
      verificationCode: verificationCode,
      verificationCodeSentAt: DateTime.now().millisecondsSinceEpoch,
      isVerified: false,
    ));
  }

  // HELPER METHODS:
  // ---------------------------------------------------------------------------
  /// timestamp check to prevent attempts too early
  bool _isSixtySecondsNotPassed(int previousTime) {
    final nowTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTime = nowTime - previousTime;
    return elapsedTime >= 60000;
  }

  /// generate random code 100000 to 999999
  String _generateRandomCode() {
    final random = Random();
    return '${100000 + random.nextInt(900000)}';
  }
}
