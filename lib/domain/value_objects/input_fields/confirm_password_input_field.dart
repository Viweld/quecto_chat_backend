part of 'input_field.dart';

/// Invalid states
enum ConfirmPasswordInputError {
  wrongType,
  emptyField,
  notEqual,
}

// -----------------------------------------------------------------------------
base class ConfirmPasswordInputField
    extends InputField<String, ConfirmPasswordInputError> {
  const ConfirmPasswordInputField(
      super.key, super._rawValue, this.basePassword);

  final PasswordInputField basePassword;

  @override
  String get value => (super._rawValue is String) ? '${super._rawValue}' : '';

  @override
  ConfirmPasswordInputError? _validator(Object? rawValue) {
    if (rawValue is! String) {
      return ConfirmPasswordInputError.wrongType;
    } else if (rawValue.isEmpty) {
      return ConfirmPasswordInputError.emptyField;
    } else if (rawValue != basePassword.value) {
      return ConfirmPasswordInputError.notEqual;
    } else {
      return null;
    }
  }
}
