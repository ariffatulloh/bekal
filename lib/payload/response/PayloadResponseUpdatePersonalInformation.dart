import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseUpdatePersonalInformation.freezed.dart';
part 'PayloadResponseUpdatePersonalInformation.g.dart';

@freezed
class PayloadResponseUpdatePersonalInformation
    with _$PayloadResponseUpdatePersonalInformation {
  const factory PayloadResponseUpdatePersonalInformation({
    required String fullName,
    required String phoneNumber,
    Address? address,
  }) = _PayloadResponseUpdatePersonalInformation;

  factory PayloadResponseUpdatePersonalInformation.fromJson(Object? json) =>
      _$PayloadResponseUpdatePersonalInformationFromJson(
          json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseUpdatePersonalInformation data) =>

}
