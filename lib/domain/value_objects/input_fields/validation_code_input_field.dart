part of 'input_field.dart';

/// Invalid states
enum ValidationCodeInputError {
  wrongType,
  emptyField,
  wrongFormat,
}

// -----------------------------------------------------------------------------
base class ValidationCodeInputField
    extends InputField<String, ValidationCodeInputError> {
  const ValidationCodeInputField(super.key, super._rawValue);

  @override
  String get value => (super._rawValue is String) ? '${super._rawValue}' : '';

  static final _validationCodeRegExp = RegExp(r'^\d{6}$');

  @override
  ValidationCodeInputError? _validator(Object? rawValue) {
    if (rawValue is! String) {
      return ValidationCodeInputError.wrongType;
    } else if (rawValue.isEmpty) {
      return ValidationCodeInputError.emptyField;
    } else if (!_validationCodeRegExp.hasMatch(value)) {
      return ValidationCodeInputError.wrongFormat;
    } else {
      return null;
    }
  }
}
