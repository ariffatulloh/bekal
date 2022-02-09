import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestCreateStore.freezed.dart';
part 'PayloadRequestCreateStore.g.dart';

@freezed
class PayloadRequestCreateStore with _$PayloadRequestCreateStore {
  const factory PayloadRequestCreateStore({
    required String nameStore,
    required String addressStore,
    required String phoneNumber,
    required String detailAddressStore,
    required String status,
    int? idStore,
  }) = _PayloadRequestCreateStore;

  factory PayloadRequestCreateStore.fromJson(Object? json) =>
      _$PayloadRequestCreateStoreFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadRequestCreateStore data) =>

}
