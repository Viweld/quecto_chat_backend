import '../../../domain/models/inputs/common/input_fields/base_input_field.dart';
import '../../../domain/models/inputs/user/user_token_refresh.dart';

final class UserTokenRefreshInputDto extends UserTokenRefreshInput {
  UserTokenRefreshInputDto.fromJson(Map<String, dynamic> json)
      : super(
          refresh: StringInputField(_refreshKey, json[_refreshKey]),
        );

  // KEYS:
  // ---------------------------------------------------------------------------
  static const _refreshKey = 'refresh';
}
