// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadRequestCreateProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadRequestCreateProduct _$$_PayloadRequestCreateProductFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadRequestCreateProduct(
      deskripsiProduct: json['deskripsiProduct'] as String,
      priceProduct: json['priceProduct'] as String,
      stockProduct: json['stockProduct'] as String,
      nameProduct: json['nameProduct'] as String,
      storeCatProd: (json['storeCatProd'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      idStore: json['idStore'] as int?,
    );

Map<String, dynamic> _$$_PayloadRequestCreateProductToJson(
        _$_PayloadRequestCreateProduct instance) =>
    <String, dynamic>{
      'deskripsiProduct': instance.deskripsiProduct,
      'priceProduct': instance.priceProduct,
      'stockProduct': instance.stockProduct,
      'nameProduct': instance.nameProduct,
      'storeCatProd': instance.storeCatProd,
      'idStore': instance.idStore,
    };
