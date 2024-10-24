import 'package:json_annotation/json_annotation.dart';

part 'generated/user_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable()
final class UserDto {
  const UserDto({
    required this.id,
    required this.fullName,
    required this.createdAt,
    required this.email,
  });

  /// "id": "123",
  @JsonKey(name: 'id')
  final String id;

  /// "full_name": "John Dow",
  @JsonKey(name: 'full_name')
  final String fullName;

  /// "created_at": "1969-07-20T20:18:04.000Z",
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// "email": "email@email.com"
  @JsonKey(name: 'email')
  final String email;

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  // ---------------------------------------------------------------------------
  /// Serialization
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
