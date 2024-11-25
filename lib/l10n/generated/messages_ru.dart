// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'authErrorAlreadyVerified': MessageLookupByLibrary.simpleMessage(
            'Пользователь уже подтвержден'),
        'authErrorUnknownUserEmail': MessageLookupByLibrary.simpleMessage(
            'Веденная почта не зарегистрирована в приложении'),
        'authErrorWrongEmailOrPassword': MessageLookupByLibrary.simpleMessage(
            'Неправильные логин или пароль'),
        'authErrorWrongVerificationCode': MessageLookupByLibrary.simpleMessage(
            'Неправильный код подтврждения'),
        'requestErrorMissingBody':
            MessageLookupByLibrary.simpleMessage('Ожидается тело запроса'),
        'requestErrorUnableToDecode': MessageLookupByLibrary.simpleMessage(
            'Невозможно декодировать тело запроса'),
        'validationErrorCanNotBeEmpty':
            MessageLookupByLibrary.simpleMessage('Не может быть пустым'),
        'validationErrorEmailWrongType':
            MessageLookupByLibrary.simpleMessage('Некорректный формат e-mail'),
        'validationErrorPasswordsNotEqual':
            MessageLookupByLibrary.simpleMessage(
                'Введенные пароли не совпадают'),
        'validationErrorStringExpected': MessageLookupByLibrary.simpleMessage(
            'Ожидается строковое значение'),
        'validationErrorValidationCodeWrongType':
            MessageLookupByLibrary.simpleMessage(
                'Код должен состоять из 6 цифр')
      };
}
