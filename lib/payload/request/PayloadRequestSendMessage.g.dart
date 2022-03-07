// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadRequestSendMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadRequestSendMessage _$$_PayloadRequestSendMessageFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadRequestSendMessage(
      message: json['message'] as String?,
      toUser: json['toUser'] as int?,
      toStore: json['toStore'] as int?,
    );

Map<String, dynamic> _$$_PayloadRequestSendMessageToJson(
        _$_PayloadRequestSendMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'toUser': instance.toUser,
      'toStore': instance.toStore,
    };
