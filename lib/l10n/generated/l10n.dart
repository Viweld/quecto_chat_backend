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
  String get loginErrorWongEmailOrPassword {
    return Intl.message(
      'Wrong login or password',
      name: 'loginErrorWongEmailOrPassword',
      desc: '',
      args: [],
    );
  }
}
