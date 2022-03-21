// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadRequestUpdatePersonalInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadRequestUpdatePersonalInformation
    _$$_PayloadRequestUpdatePersonalInformationFromJson(
            Map<String, dynamic> json) =>
        _$_PayloadRequestUpdatePersonalInformation(
          fullName: json['fullName'] as String,
          phoneNumber: json['phoneNumber'] as String,
          address: json['address'] == null
              ? null
              : Address.fromJson(json['address'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_PayloadRequestUpdatePersonalInformationToJson(
        _$_PayloadRequestUpdatePersonalInformation instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };
