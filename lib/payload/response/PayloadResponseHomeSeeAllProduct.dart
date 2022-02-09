import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseHomeSeeAllProduct.freezed.dart';
part 'PayloadResponseHomeSeeAllProduct.g.dart';

@freezed
class PayloadResponseHomeSeeAllProduct with _$PayloadResponseHomeSeeAllProduct {
  const factory PayloadResponseHomeSeeAllProduct({
    required String titleTab,
    required List<PayloadResponseStoreProduct> viewListStoreProductResponse,
  }) = _PayloadResponseHomeSeeAllProduct;

  factory PayloadResponseHomeSeeAllProduct.fromJson(Object? json) =>
      _$PayloadResponseHomeSeeAllProductFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseHomeSeeAllProduct data) =>

}
