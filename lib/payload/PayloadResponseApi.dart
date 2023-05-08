import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PayloadResponseApi.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PayloadResponseApi<T> extends Equatable {
  final T? data;
  final String status;
  final String errorMessage;
  final int code;

  PayloadResponseApi({required this.code, this.data, required this.status, required this.errorMessage});

  factory PayloadResponseApi.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic? json) fromJsonT,
  ) {
    return _$PayloadResponseApiFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T value) toJsonT,
  ) {
    return _$PayloadResponseApiToJson<T>(this, toJsonT);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [code, status, data];
}
