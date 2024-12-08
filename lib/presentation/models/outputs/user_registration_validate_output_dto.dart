import 'package:json_annotation/json_annotation.dart';

import '../../../domain/use_cases/user/registration_validate/user_registration_validate_output.dart';

part 'generated/user_registration_validate_output_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserRegistrationValidateOutputDto
    extends UserRegistrationValidateOutput {
  UserRegistrationValidateOutputDto({
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
  Map<String, dynamic> toJson() =>
      _$UserRegistrationValidateOutputDtoToJson(this);
}
