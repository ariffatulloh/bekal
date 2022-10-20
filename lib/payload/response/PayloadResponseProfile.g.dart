// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    )..image = json['image'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'image': instance.image,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address: json['address'] as String?,
      area_id: json['area_id'] as int? ?? 0,
      area_name: json['area_name'] as String?,
      city_id: json['city_id'] as int? ?? 0,
      city_name: json['city_name'] as String?,
      country_id: json['country_id'] as int? ?? 0,
      country_name: json['country_name'] as String?,
      direction: json['direction'] as String?,
      postcode: json['postcode'] as String?,
      province_id: json['province_id'] as int? ?? 0,
      province_name: json['province_name'] as String?,
      suburb_id: json['suburb_id'] as int? ?? 0,
      suburb_name: json['suburb_name'] as String?,
      lat: json['lat'] as String? ?? "",
      lng: json['lng'] as String? ?? "",
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'area_id': instance.area_id,
      'area_name': instance.area_name,
      'city_id': instance.city_id,
      'city_name': instance.city_name,
      'country_id': instance.country_id,
      'country_name': instance.country_name,
      'direction': instance.direction,
      'postcode': instance.postcode,
      'province_id': instance.province_id,
      'province_name': instance.province_name,
      'suburb_id': instance.suburb_id,
      'suburb_name': instance.suburb_name,
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$_PayloadResponseProfile _$$_PayloadResponseProfileFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadResponseProfile(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      isVerify: json['isVerify'] as bool,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PayloadResponseProfileToJson(
        _$_PayloadResponseProfile instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'isVerify': instance.isVerify,
      'profile': instance.profile,
    };
