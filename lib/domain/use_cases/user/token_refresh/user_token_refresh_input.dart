import '../../../../core/interfaces/base_input.dart';
import '../../../entities/input_field.dart';

base class UserTokenRefreshInput implements BaseInput {
  const UserTokenRefreshInput({
    required this.refresh,
  });

  /// Refresh token
  final StringInputField refresh;

  // ---------------------------------------------------------------------------
  /// Get invalid inputs as Map<String, BaseInput>
  @override
  List<InputField<Object, Object>> checkFields() => [
        if (refresh.invalid) refresh,
      ];
}
