import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseProfile.freezed.dart';
part 'PayloadResponseProfile.g.dart';

@freezed
class PayloadResponseProfile with _$PayloadResponseProfile {
  const factory PayloadResponseProfile(
      {required String fullName,
      required String email,
      required bool isVerify,
      required Profile profile}) = _PayloadResponseProfile;

  factory PayloadResponseProfile.fromJson(Object? json) =>
      _$PayloadResponseProfileFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
// Map<String, dynamic> toJson() => <String, dynamic>{'token': this.token};
}

@JsonSerializable()
class Profile {
  String? image;
  String? address;
  String? phoneNumber;
  Profile({
    this.phoneNumber,
    this.address,
  });
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
