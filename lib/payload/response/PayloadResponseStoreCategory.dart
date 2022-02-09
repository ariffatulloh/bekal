import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseStoreCategory.freezed.dart';
part 'PayloadResponseStoreCategory.g.dart';

@freezed
class PayloadResponseStoreCategory with _$PayloadResponseStoreCategory {
  const factory PayloadResponseStoreCategory({
    required String storeName,
    required String categoryName,
    required int categoryId,
  }) = _PayloadResponseStoreCategory;

  factory PayloadResponseStoreCategory.fromJson(Object? json) =>
      _$PayloadResponseStoreCategoryFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseStoreCategory data) =>

}
