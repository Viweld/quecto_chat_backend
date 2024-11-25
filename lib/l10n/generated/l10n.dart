import 'package:intl/intl.dart';

class Localization {
  Localization();

  /// `Expected request body`
  String get requestErrorMissingBody {
    return Intl.message(
      'Expected request body',
      name: 'requestErrorMissingBody',
      desc: '',
      args: [],
    );
  }

  /// `Unable to decode request body`
  String get requestErrorUnableToDecode {
    return Intl.message(
      'Unable to decode request body',
      name: 'requestErrorUnableToDecode',
      desc: '',
      args: [],
    );
  }

  /// `Expected string value`
  String get validationErrorStringExpected {
    return Intl.message(
      'Expected string value',
      name: 'validationErrorStringExpected',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be empty`
  String get validationErrorCanNotBeEmpty {
    return Intl.message(
      'Cannot be empty',
      name: 'validationErrorCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Entered passwords will not be equal`
  String get validationErrorPasswordsNotEqual {
    return Intl.message(
      'Entered passwords will not be equal',
      name: 'validationErrorPasswordsNotEqual',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email format`
  String get validationErrorEmailWrongType {
    return Intl.message(
      'Incorrect email format',
      name: 'validationErrorEmailWrongType',
      desc: '',
      args: [],
    );
  }

  /// `Code must be 6 digits long`
  String get validationErrorValidationCodeWrongType {
    return Intl.message(
      'Code must be 6 digits long',
      name: 'validationErrorValidationCodeWrongType',
      desc: '',
      args: [],
    );
  }

  /// `Wrong login or password`
  String get authErrorWrongEmailOrPassword {
    return Intl.message(
      'Wrong login or password',
      name: 'authErrorWrongEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `The entered email is not registered in the application`
  String get authErrorUnknownUserEmail {
    return Intl.message(
      'The entered email is not registered in the application',
      name: 'authErrorUnknownUserEmail',
      desc: '',
      args: [],
    );
  }

  /// `The user has already been verified`
  String get authErrorAlreadyVerified {
    return Intl.message(
      'The user has already been verified',
      name: 'authErrorAlreadyVerified',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect verification code`
  String get authErrorWrongVerificationCode {
    return Intl.message(
      'Incorrect verification code',
      name: 'authErrorWrongVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `You can get the code again in 60 seconds`
  String get authErrorTooManyAttempts {
    return Intl.message(
      'You can get the code again in 60 seconds',
      name: 'authErrorTooManyAttempts',
      desc: '',
      args: [],
    );
  }
}
