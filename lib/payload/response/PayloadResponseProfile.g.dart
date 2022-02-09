// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
    )..image = json['image'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'image': instance.image,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
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
