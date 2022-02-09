// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseHomeSeeAllProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PayloadResponseHomeSeeAllProduct
    _$$_PayloadResponseHomeSeeAllProductFromJson(Map<String, dynamic> json) =>
        _$_PayloadResponseHomeSeeAllProduct(
          titleTab: json['titleTab'] as String,
          viewListStoreProductResponse:
              (json['viewListStoreProductResponse'] as List<dynamic>)
                  .map((e) => PayloadResponseStoreProduct.fromJson(e as Object))
                  .toList(),
        );

Map<String, dynamic> _$$_PayloadResponseHomeSeeAllProductToJson(
        _$_PayloadResponseHomeSeeAllProduct instance) =>
    <String, dynamic>{
      'titleTab': instance.titleTab,
      'viewListStoreProductResponse': instance.viewListStoreProductResponse,
    };
