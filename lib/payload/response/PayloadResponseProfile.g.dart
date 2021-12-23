// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadResponseProfile _$$_PayloadResponseProfileFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadResponseProfile(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      isVerify: json['isVerify'] as bool,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$_PayloadResponseProfileToJson(
        _$_PayloadResponseProfile instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'isVerify': instance.isVerify,
      'password': instance.password,
    };
