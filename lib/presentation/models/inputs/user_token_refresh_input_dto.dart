import '../../../domain/use_cases/user/token_refresh/user_token_refresh_input.dart';
import '../../../domain/value_objects/input_fields/input_field.dart';

final class UserTokenRefreshInputDto extends UserTokenRefreshInput {
  UserTokenRefreshInputDto.fromJson(Map<String, dynamic> json)
      : super(
          refresh: StringInputField(_refreshKey, json[_refreshKey]),
        );

  // KEYS:
  // ---------------------------------------------------------------------------
  static const _refreshKey = 'refresh';
}
