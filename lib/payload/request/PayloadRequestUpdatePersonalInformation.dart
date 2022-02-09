import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestUpdatePersonalInformation.freezed.dart';
part 'PayloadRequestUpdatePersonalInformation.g.dart';

@freezed
class PayloadRequestUpdatePersonalInformation
    with _$PayloadRequestUpdatePersonalInformation {
  const factory PayloadRequestUpdatePersonalInformation({
    required String fullName,
    required String phoneNumber,
    required String address,
  }) = _PayloadRequestUpdatePersonalInformation;

  factory PayloadRequestUpdatePersonalInformation.fromJson(Object? json) =>
      _$PayloadRequestUpdatePersonalInformationFromJson(
          json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadRequestUpdatePersonalInformation data) =>

}
