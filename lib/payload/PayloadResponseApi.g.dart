// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseApi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadResponseApi<T> _$PayloadResponseApiFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PayloadResponseApi<T>(
      code: json['code'] as int,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$PayloadResponseApiToJson<T>(
  PayloadResponseApi<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'code': instance.code,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
