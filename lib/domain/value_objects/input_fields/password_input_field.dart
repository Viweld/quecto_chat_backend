part of 'input_field.dart';

/// Invalid states
enum PasswordInputError {
  wrongType,
  emptyField,
}

// -----------------------------------------------------------------------------
base class PasswordInputField extends InputField<String, PasswordInputError> {
  const PasswordInputField(super.key, super._rawValue);

  @override
  String get value => (super._rawValue is String) ? '${super._rawValue}' : '';

  @override
  PasswordInputError? _validator(Object? rawValue) {
    if (rawValue is! String) {
      return PasswordInputError.wrongType;
    } else if (rawValue.isEmpty) {
      return PasswordInputError.emptyField;
    } else {
      return null;
    }
  }
}
