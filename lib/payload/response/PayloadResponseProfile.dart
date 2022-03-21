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
  Address? address;
  String? phoneNumber;
  Profile({
    this.phoneNumber,
    this.address,
  });
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@JsonSerializable()
class Address {
  String? address;
  int area_id;
  String? area_name;
  int city_id;
  String? city_name;
  int country_id;
  String? country_name;
  String? direction;
  String? postcode;
  int province_id;
  String? province_name;
  int suburb_id;
  String? suburb_name;
  String? lat;
  String? lng;
  Address({
    this.address,
    this.area_id = 0,
    this.area_name,
    this.city_id = 0,
    this.city_name,
    this.country_id = 0,
    this.country_name,
    this.direction,
    this.postcode,
    this.province_id = 0,
    this.province_name,
    this.suburb_id = 0,
    this.suburb_name,
    this.lat = "",
    this.lng = "",
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
