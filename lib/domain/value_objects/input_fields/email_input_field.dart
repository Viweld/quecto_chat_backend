part of '../../entities/input_field.dart';

/// Invalid states
enum EmailInputError {
  wrongType,
  emptyField,
  wrongFormat,
}

base class EmailInputField extends InputField<String, EmailInputError> {
  const EmailInputField(super.key, super._rawValue);

  @override
  String get value => (super._rawValue is String) ? '${super._rawValue}' : '';

  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailInputError? _validator(Object? rawValue) {
    if (rawValue is! String) {
      return EmailInputError.wrongType;
    } else if (rawValue.isEmpty) {
      return EmailInputError.emptyField;
    } else if (!_emailRegExp.hasMatch(value)) {
      return EmailInputError.wrongFormat;
    } else {
      return null;
    }
  }
}
