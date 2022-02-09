import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseStoreProduct.freezed.dart';
part 'PayloadResponseStoreProduct.g.dart';

@freezed
class PayloadResponseStoreProduct with _$PayloadResponseStoreProduct {
  const factory PayloadResponseStoreProduct({
    required int storeProdId,
    required String nameProduct,
    required String stockProduct,
    required String priceProduct,
    required String deskripsiProduct,
    required String uriThumbnail,
    required InfoStore store,
    required List<GalleryImage> galleryImage,
    required List<CategoryProduct> categoryProduct,
  }) = _PayloadResponseStoreProduct;

  factory PayloadResponseStoreProduct.fromJson(Object? json) =>
      _$PayloadResponseStoreProductFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseStoreProduct data) =>

}

@JsonSerializable()
class InfoStore {
  int storeID = -1;
  String storeName = "";
  String uriStoreImage = "";
  InfoStore(
      {required this.storeID,
      required this.storeName,
      required this.uriStoreImage});
  factory InfoStore.fromJson(Map<String, dynamic> json) =>
      _$InfoStoreFromJson(json);
}

@JsonSerializable()
class CategoryProduct {
  int storeCategoryId = -1;
  String nameCategory = "";
  CategoryProduct({required this.storeCategoryId, required this.nameCategory});
  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductFromJson(json);
}

@JsonSerializable()
class GalleryImage {
  String uriImage = "";
  GalleryImage({required this.uriImage});
  factory GalleryImage.fromJson(Map<String, dynamic> json) =>
      _$GalleryImageFromJson(json);
}
