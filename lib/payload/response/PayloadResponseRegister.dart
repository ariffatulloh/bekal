import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseRegister.freezed.dart';
part 'PayloadResponseRegister.g.dart';

@freezed
class PayloadResponseRegister with _$PayloadResponseRegister {
  const factory PayloadResponseRegister({required bool registrationSukses}) =
      _PayloadResponseRegister;

  factory PayloadResponseRegister.fromJson(Object? json) =>
      _$PayloadResponseRegisterFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
// Map<String, dynamic> toJson() => <String, dynamic>{'token': this.token};
}
