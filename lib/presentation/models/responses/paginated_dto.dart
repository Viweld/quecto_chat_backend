import 'package:json_annotation/json_annotation.dart';

part 'generated/paginated_dto.g.dart';

// ignore_for_file: sort_constructors_first
@JsonSerializable(genericArgumentFactories: true)
final class PaginatedDto<T> {
  const PaginatedDto({
    required this.result,
    required this.limit,
    required this.offset,
  });

  /// "result": []
  @JsonKey(name: 'result')
  final Iterable<T> result;

  /// "limit": 0
  @JsonKey(name: 'limit')
  final int? limit;

  /// "offset": 0
  @JsonKey(name: 'offset')
  final int? offset;

  // ---------------------------------------------------------------------------
  /// Deserialization
  factory PaginatedDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedDtoFromJson(json, fromJsonT);

  // ---------------------------------------------------------------------------
  /// Serialization
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedDtoToJson(this, toJsonT);
}
