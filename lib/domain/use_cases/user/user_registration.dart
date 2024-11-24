import 'dart:math';

import '../../entities/user.dart';
import '../../exceptions/app_exceptions.dart';
import '../../interfaces/mail_sender_service.dart';
import '../../interfaces/user_repository.dart';
import '../../models/inputs/user/user_registration_input.dart';

// Use-case
// -----------------------------------------------------------------------------
class UserRegistration {
  UserRegistration(this._userRepository, this._mailSenderService);

  final UserRepository _userRepository;
  final MailSenderService _mailSenderService;

  // ---------------------------------------------------------------------------
  Future<void> call(UserRegistrationInput input) async {
    // validate fields credentials
    final validationResult = input.checkFields();
    if (validationResult.isNotEmpty) {
      throw InvalidRequestBodyValues(validationResult);
    }

    // send an email with verification code
    final verificationCode = _generateRandomCode();
    await _mailSenderService.sendEmail(
      input.email.value,
      'Dear ${input.fullName.value}',
      'Use this code to complete your registration in Quecto:$verificationCode',
    );

    // save user data with sent email-code
    await _userRepository.addUser(User(
      fullName: input.fullName.value,
      createdAt: DateTime.now(),
      email: input.email.value,
      password: input.password.value,
      verificationCode: verificationCode,
      verificationCodeSentAt: DateTime.now().millisecondsSinceEpoch,
      isVerified: false,
    ));
  }

  // HELPER METHODS:
  // ---------------------------------------------------------------------------
  /// generate random code 100000 to 999999
  String _generateRandomCode() {
    final random = Random();
    return '${100000 + random.nextInt(900000)}';
  }
}
