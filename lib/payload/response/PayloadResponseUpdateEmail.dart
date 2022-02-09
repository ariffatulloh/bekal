import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseUpdateEmail.freezed.dart';
part 'PayloadResponseUpdateEmail.g.dart';

@freezed
class PayloadResponseUpdateEmail with _$PayloadResponseUpdateEmail {
  const factory PayloadResponseUpdateEmail({
    required String message,
  }) = _PayloadResponseUpdateEmail;

  factory PayloadResponseUpdateEmail.fromJson(Object? json) =>
      _$PayloadResponseUpdateEmailFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseUpdateEmail data) =>

}
