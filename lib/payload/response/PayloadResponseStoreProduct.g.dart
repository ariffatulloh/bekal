// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseStoreProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoStore _$InfoStoreFromJson(Map<String, dynamic> json) => InfoStore(
      storeID: json['storeID'] as int,
      storeName: json['storeName'] as String,
      uriStoreImage: json['uriStoreImage'] as String,
    );

Map<String, dynamic> _$InfoStoreToJson(InfoStore instance) => <String, dynamic>{
      'storeID': instance.storeID,
      'storeName': instance.storeName,
      'uriStoreImage': instance.uriStoreImage,
    };

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) =>
    CategoryProduct(
      storeCategoryId: json['storeCategoryId'] as int,
      nameCategory: json['nameCategory'] as String,
    );

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'storeCategoryId': instance.storeCategoryId,
      'nameCategory': instance.nameCategory,
    };

GalleryImage _$GalleryImageFromJson(Map<String, dynamic> json) => GalleryImage(
      uriImage: json['uriImage'] as String,
    );

Map<String, dynamic> _$GalleryImageToJson(GalleryImage instance) =>
    <String, dynamic>{
      'uriImage': instance.uriImage,
    };

_$_PayloadResponseStoreProduct _$$_PayloadResponseStoreProductFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadResponseStoreProduct(
      storeProdId: json['storeProdId'] as int,
      nameProduct: json['nameProduct'] as String,
      stockProduct: json['stockProduct'] as String,
      priceProduct: json['priceProduct'] as String,
      deskripsiProduct: json['deskripsiProduct'] as String,
      uriThumbnail: json['uriThumbnail'] as String,
      store: InfoStore.fromJson(json['store'] as Map<String, dynamic>),
      galleryImage: (json['galleryImage'] as List<dynamic>)
          .map((e) => GalleryImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryProduct: (json['categoryProduct'] as List<dynamic>)
          .map((e) => CategoryProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PayloadResponseStoreProductToJson(
        _$_PayloadResponseStoreProduct instance) =>
    <String, dynamic>{
      'storeProdId': instance.storeProdId,
      'nameProduct': instance.nameProduct,
      'stockProduct': instance.stockProduct,
      'priceProduct': instance.priceProduct,
      'deskripsiProduct': instance.deskripsiProduct,
      'uriThumbnail': instance.uriThumbnail,
      'store': instance.store,
      'galleryImage': instance.galleryImage,
      'categoryProduct': instance.categoryProduct,
    };
