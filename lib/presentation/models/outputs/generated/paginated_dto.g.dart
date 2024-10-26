// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../paginated_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedDto<T> _$PaginatedDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedDto<T>(
      result: (json['result'] as List<dynamic>).map(fromJsonT),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatedDtoToJson<T>(
  PaginatedDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': instance.result.map(toJsonT).toList(),
      'limit': instance.limit,
      'offset': instance.offset,
    };
