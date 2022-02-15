import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestCreateProduct.freezed.dart';
part 'PayloadRequestCreateProduct.g.dart';

@freezed
class PayloadRequestCreateProduct with _$PayloadRequestCreateProduct {
  const factory PayloadRequestCreateProduct({
    required String deskripsiProduct,
    required String priceProduct,
    required String stockProduct,
    required String nameProduct,
    required List<String> storeCatProd,
    int? idStore,
  }) = _PayloadRequestCreateProduct;

  factory PayloadRequestCreateProduct.fromJson(Object? json) =>
      _$PayloadRequestCreateProductFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadRequestCreateProduct data) =>

}
