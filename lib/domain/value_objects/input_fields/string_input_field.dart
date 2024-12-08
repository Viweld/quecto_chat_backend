part of 'input_field.dart';

/// Invalid states
enum StringInputError {
  wrongType,
  emptyField,
}

// -----------------------------------------------------------------------------
base class StringInputField extends InputField<String, StringInputError> {
  const StringInputField(super.key, super._rawValue);

  @override
  String get value => (super._rawValue is String) ? '${super._rawValue}' : '';

  @override
  StringInputError? _validator(Object? rawValue) {
    if (rawValue is! String) {
      return StringInputError.wrongType;
    } else if (rawValue.isEmpty) {
      return StringInputError.emptyField;
    } else {
      return null;
    }
  }
}
