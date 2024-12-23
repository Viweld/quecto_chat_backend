import 'package:meta/meta.dart';

part 'email_input_field.dart';

part 'password_input_field.dart';

part 'string_input_field.dart';

part 'confirm_password_input_field.dart';

part 'validation_code_input_field.dart';

@immutable
sealed class InputField<T, E> {
  const InputField(this.key, this._rawValue);

  final String key;

  final Object? _rawValue;

  T get value;

  E? get error => _validator(_rawValue);

  bool get valid => _validator(_rawValue) == null;

  bool get invalid => _validator(_rawValue) != null;

  E? _validator(Object? rawValue);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is InputField &&
            runtimeType == other.runtimeType &&
            _rawValue == other._rawValue;
  }

  @override
  int get hashCode => _rawValue.hashCode;
}
