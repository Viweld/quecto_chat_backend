import '../../domain/entities/input_field.dart';

abstract interface class BaseInput {
  /// Check all fields and return list of invalid fields
  List<InputField<Object, Object>> checkFields();
}
