// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadRequestUpdatePassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadRequestUpdatePassword _$$_PayloadRequestUpdatePasswordFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadRequestUpdatePassword(
      existingPassword: json['existingPassword'] as String,
      newPassword: json['newPassword'] as String,
      rePassword: json['rePassword'] as String,
    );

Map<String, dynamic> _$$_PayloadRequestUpdatePasswordToJson(
        _$_PayloadRequestUpdatePassword instance) =>
    <String, dynamic>{
      'existingPassword': instance.existingPassword,
      'newPassword': instance.newPassword,
      'rePassword': instance.rePassword,
    };
