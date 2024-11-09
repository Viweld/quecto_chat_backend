import '../models/inputs/common/input_fields/base_input_field.dart';

abstract interface class BaseInput {
  /// Check all fields and return list of invalid fields
  List<BaseInputField<Object, Object>> checkFields();
}
