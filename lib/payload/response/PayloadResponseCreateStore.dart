import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseCreateStore.freezed.dart';
part 'PayloadResponseCreateStore.g.dart';

@freezed
class PayloadResponseCreateStore with _$PayloadResponseCreateStore {
  const factory PayloadResponseCreateStore({
    required String message,
  }) = _PayloadResponseCreateStore;

  factory PayloadResponseCreateStore.fromJson(Object? json) =>
      _$PayloadResponseCreateStoreFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseCreateStore data) =>

}
