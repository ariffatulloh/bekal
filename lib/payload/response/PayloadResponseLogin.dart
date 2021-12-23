import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseLogin.freezed.dart';
part 'PayloadResponseLogin.g.dart';

@freezed
class PayloadResponseLogin with _$PayloadResponseLogin {
  const factory PayloadResponseLogin({required String token}) =
      _PayloadResponseLogin;

  factory PayloadResponseLogin.fromJson(Object? json) =>
      _$PayloadResponseLoginFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
// Map<String, dynamic> toJson() => <String, dynamic>{'token': this.token};
}
