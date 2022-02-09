// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadRequestCreateStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadRequestCreateStore _$$_PayloadRequestCreateStoreFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadRequestCreateStore(
      nameStore: json['nameStore'] as String,
      addressStore: json['addressStore'] as String,
      phoneNumber: json['phoneNumber'] as String,
      detailAddressStore: json['detailAddressStore'] as String,
      status: json['status'] as String,
      idStore: json['idStore'] as int?,
    );

Map<String, dynamic> _$$_PayloadRequestCreateStoreToJson(
        _$_PayloadRequestCreateStore instance) =>
    <String, dynamic>{
      'nameStore': instance.nameStore,
      'addressStore': instance.addressStore,
      'phoneNumber': instance.phoneNumber,
      'detailAddressStore': instance.detailAddressStore,
      'status': instance.status,
      'idStore': instance.idStore,
    };
