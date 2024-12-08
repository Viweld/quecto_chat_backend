import 'package:dart_frog/dart_frog.dart';

import '../extensions/context_extensions.dart';
import '../../domain/entities/input_field.dart';

extension SerializationInvalidFieldsList on List<InputField<Object, Object>> {
  Map<String, Object?> serialize(RequestContext context) {
    final Map<String, Object?> result = {'details': 'Invalid values in fields'};

    for (final field in this) {
      result.putIfAbsent(
        field.key,
        () => switch (field) {
          final PasswordInputField f => switch (f.error!) {
              PasswordInputError.wrongType =>
                context.texts.validationErrorStringExpected,
              PasswordInputError.emptyField =>
                context.texts.validationErrorCanNotBeEmpty,
            },
          final ConfirmPasswordInputField f => switch (f.error!) {
              ConfirmPasswordInputError.wrongType =>
                context.texts.validationErrorStringExpected,
              ConfirmPasswordInputError.emptyField =>
                context.texts.validationErrorCanNotBeEmpty,
              ConfirmPasswordInputError.notEqual =>
                context.texts.validationErrorPasswordsNotEqual,
            },
          final StringInputField f => switch (f.error!) {
              StringInputError.wrongType =>
                context.texts.validationErrorStringExpected,
              StringInputError.emptyField =>
                context.texts.validationErrorCanNotBeEmpty,
            },
          final EmailInputField f => switch (f.error!) {
              EmailInputError.wrongType =>
                context.texts.validationErrorStringExpected,
              EmailInputError.emptyField =>
                context.texts.validationErrorCanNotBeEmpty,
              EmailInputError.wrongFormat =>
                context.texts.validationErrorEmailWrongType,
            },
          final ValidationCodeInputField f => switch (f.error!) {
              ValidationCodeInputError.wrongType =>
                context.texts.validationErrorStringExpected,
              ValidationCodeInputError.emptyField =>
                context.texts.validationErrorCanNotBeEmpty,
              ValidationCodeInputError.wrongFormat =>
                context.texts.validationErrorValidationCodeWrongType,
            },
        },
      );
    }

    return result;
  }
}
