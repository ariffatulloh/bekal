import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseVerification.freezed.dart';
part 'PayloadResponseVerification.g.dart';

@freezed
class PayloadResponseVerification with _$PayloadResponseVerification {
  const factory PayloadResponseVerification({
    required String email,
    required String message,
  }) = _PayloadResponseVerification;

  factory PayloadResponseVerification.fromJson(Object? json) =>
      _$PayloadResponseVerificationFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
// Map<String, dynamic> toJson() => <String, dynamic>{'token': this.token};
}
