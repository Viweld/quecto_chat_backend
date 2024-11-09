import 'dart:math';

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
  Future<void> call(UserRegistrationInput regData) async {
    // validate fields credentials
    // TODO(Vadim): #unimplemented - make validations

    // send an email with verification code
    final verificationCode = _generateRandomCode();
    await _mailSenderService.sendEmail(
      regData.email.value,
      'Dear ${regData.fullName.value}',
      'Use this code to complete your registration in Quecto:$verificationCode',
    );

    // save user credentials with sent email-code
    // TODO(Vadim): #unimplemented - make query to record to database user regData with verification code
    // final user = await _userRepository.addUser(
    //   fullName: regData.fullName,
    //   createdAt: DateTime.now(),
    //   email: regData.email,
    //   password: regData.password,
    // );
  }

  // HELPER METHODS:
  // ---------------------------------------------------------------------------
  /// generate random code 100000 to 999999
  int _generateRandomCode() {
    final random = Random();
    return 100000 + random.nextInt(900000);
  }
}
