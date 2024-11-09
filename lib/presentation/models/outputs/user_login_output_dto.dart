import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/outputs/user/user_login_output.dart';

part 'generated/user_login_output_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserLoginOutputDto extends UserLoginOutput {
  UserLoginOutputDto({
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
  Map<String, dynamic> toJson() => _$UserLoginOutputDtoToJson(this);
}
