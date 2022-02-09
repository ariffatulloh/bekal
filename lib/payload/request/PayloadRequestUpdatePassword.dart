import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestUpdatePassword.freezed.dart';
part 'PayloadRequestUpdatePassword.g.dart';

@freezed
class PayloadRequestUpdatePassword with _$PayloadRequestUpdatePassword {
  const factory PayloadRequestUpdatePassword({
    required String existingPassword,
    required String newPassword,
    required String rePassword,
  }) = _PayloadRequestUpdatePassword;

  factory PayloadRequestUpdatePassword.fromJson(Object? json) =>
      _$PayloadRequestUpdatePasswordFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadRequestUpdatePassword data) =>

}
