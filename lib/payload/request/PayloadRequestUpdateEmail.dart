import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestUpdateEmail.freezed.dart';
part 'PayloadRequestUpdateEmail.g.dart';

@freezed
class PayloadRequestUpdateEmail with _$PayloadRequestUpdateEmail {
  const factory PayloadRequestUpdateEmail({
    required String existingEmail,
    required String newEmail,
  }) = _PayloadRequestUpdateEmail;

  factory PayloadRequestUpdateEmail.fromJson(Object? json) =>
      _$PayloadRequestUpdateEmailFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadRequestUpdateEmail data) =>

}
