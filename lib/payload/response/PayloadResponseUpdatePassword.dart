import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseUpdatePassword.freezed.dart';
part 'PayloadResponseUpdatePassword.g.dart';

@freezed
class PayloadResponseUpdatePassword with _$PayloadResponseUpdatePassword {
  const factory PayloadResponseUpdatePassword({
    required String message,
  }) = _PayloadResponseUpdatePassword;

  factory PayloadResponseUpdatePassword.fromJson(Object? json) =>
      _$PayloadResponseUpdatePasswordFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseUpdatePassword data) =>

}
