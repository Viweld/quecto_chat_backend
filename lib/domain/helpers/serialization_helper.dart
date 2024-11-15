import 'package:dart_frog/dart_frog.dart';

import '../models/inputs/common/input_fields/base_input_field.dart';

extension SerializationInvalidFieldsList
    on List<BaseInputField<Object, Object>> {
  Map<String, Object?> serialize(RequestContext context) {
    final Map<String, Object?> result = {'details': 'Invalid values in fields'};

    for (final field in this) {
      result.putIfAbsent(
        field.key,
        () => switch (field) {
          final PasswordInputField f => switch (f.error!) {
              PasswordInputError.wrongType => '',
              PasswordInputError.emptyField => '',
            },
          final ConfirmPasswordInputField f => switch (f.error!) {
              ConfirmPasswordInputError.wrongType => '',
              ConfirmPasswordInputError.emptyField => '',
              ConfirmPasswordInputError.notEqual => '',
            },
          final StringInputField f => switch (f.error!) {
              StringInputError.wrongType => '',
              StringInputError.emptyField => '',
            },
          final EmailInputField f => switch (f.error!) {
              EmailInputError.wrongType => '',
              EmailInputError.emptyField => '',
              EmailInputError.wrongFormat => '',
            },
        },
      );
    }

    return result;
  }
}
