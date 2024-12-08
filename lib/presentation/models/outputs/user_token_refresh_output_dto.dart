import 'package:json_annotation/json_annotation.dart';
import '../../../domain/use_cases/user/token_refresh/user_token_refresh_output.dart';

part 'generated/user_token_refresh_output_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserTokenRefreshOutputDto extends UserTokenRefreshOutput {
  UserTokenRefreshOutputDto({
    required super.access,
    required super.refresh,
  });

  /// get access-token for Serialization
  @override
  @JsonKey(name: 'access')
  String get access => super.access;

  /// get refresh-token for Serialization
  @override
  @JsonKey(name: 'refresh')
  String get refresh => super.refresh;

  // ---------------------------------------------------------------------------
  /// Serialization
  Map<String, dynamic> toJson() => _$UserTokenRefreshOutputDtoToJson(this);
}
