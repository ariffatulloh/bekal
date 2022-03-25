// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseMyProfileDashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'message': instance.message,
    };

MyDashboardProfileOutlets _$MyDashboardProfileOutletsFromJson(
        Map<String, dynamic> json) =>
    MyDashboardProfileOutlets(
      image: json['image'] as String?,
      nameOutlet: json['nameOutlet'] as String?,
      addressOutlet: json['addressOutlet'] as String?,
      detailAddressStore: json['detailAddressStore'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      status: json['status'] as String?,
      storeId: json['storeId'] as int?,
    );

Map<String, dynamic> _$MyDashboardProfileOutletsToJson(
        MyDashboardProfileOutlets instance) =>
    <String, dynamic>{
      'image': instance.image,
      'nameOutlet': instance.nameOutlet,
      'addressOutlet': instance.addressOutlet,
      'detailAddressStore': instance.detailAddressStore,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'storeId': instance.storeId,
    };

_$_PayloadResponseMyProfileDashboard
    _$$_PayloadResponseMyProfileDashboardFromJson(Map<String, dynamic> json) =>
        _$_PayloadResponseMyProfileDashboard(
          image: json['image'] as String?,
          idUser: json['idUser'] as int?,
          nameUser: json['nameUser'] as String?,
          isAdmin: json['isAdmin'] as bool,
          emailUser: json['emailUser'] as String?,
          myOutlets: (json['myOutlets'] as List<dynamic>?)
              ?.map((e) =>
                  MyDashboardProfileOutlets.fromJson(e as Map<String, dynamic>))
              .toList(),
          alertUbahDataPribadi: json['alertUbahDataPribadi'] == null
              ? null
              : Alert.fromJson(
                  json['alertUbahDataPribadi'] as Map<String, dynamic>),
          alertHystoryTransaksi: json['alertHystoryTransaksi'] == null
              ? null
              : Alert.fromJson(
                  json['alertHystoryTransaksi'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_PayloadResponseMyProfileDashboardToJson(
        _$_PayloadResponseMyProfileDashboard instance) =>
    <String, dynamic>{
      'image': instance.image,
      'idUser': instance.idUser,
      'nameUser': instance.nameUser,
      'isAdmin': instance.isAdmin,
      'emailUser': instance.emailUser,
      'myOutlets': instance.myOutlets,
      'alertUbahDataPribadi': instance.alertUbahDataPribadi,
      'alertHystoryTransaksi': instance.alertHystoryTransaksi,
    };
