// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'authErrorAlreadyVerified': MessageLookupByLibrary.simpleMessage(
            'The user has already been verified'),
        'authErrorEmailAlreadyTaken':
            MessageLookupByLibrary.simpleMessage('This email is already taken'),
        'authErrorInvalidRefreshToken':
            MessageLookupByLibrary.simpleMessage('Invalid refresh token'),
        'authErrorRefreshTokenNotInWhitelist':
            MessageLookupByLibrary.simpleMessage(
                'Refresh token is not in the whitelist'),
        'authErrorTooManyAttempts': MessageLookupByLibrary.simpleMessage(
            'You can get the code again in 60 seconds'),
        'authErrorUnknownUserEmail': MessageLookupByLibrary.simpleMessage(
            'The entered email is not registered in the application'),
        'authErrorWrongEmailOrPassword':
            MessageLookupByLibrary.simpleMessage('Wrong login or password'),
        'authErrorWrongVerificationCode':
            MessageLookupByLibrary.simpleMessage('Incorrect verification code'),
        'requestErrorMissingBody':
            MessageLookupByLibrary.simpleMessage('Expected request body'),
        'requestErrorUnableToDecode': MessageLookupByLibrary.simpleMessage(
            'Unable to decode request body'),
        'validationErrorCanNotBeEmpty':
            MessageLookupByLibrary.simpleMessage('Cannot be empty'),
        'validationErrorEmailWrongType':
            MessageLookupByLibrary.simpleMessage('Incorrect email format'),
        'validationErrorPasswordsNotEqual':
            MessageLookupByLibrary.simpleMessage(
                'Entered passwords will not be equal'),
        'validationErrorStringExpected':
            MessageLookupByLibrary.simpleMessage('Expected string value'),
        'validationErrorValidationCodeWrongType':
            MessageLookupByLibrary.simpleMessage('Code must be 6 digits long')
      };
}
