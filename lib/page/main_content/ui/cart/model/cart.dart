import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartStore {
  int store_id;
  String store_name;

  List<Cart> item;
  CartStore(
      {required this.store_id, required this.store_name, this.item = const []});

  factory CartStore.fromJson(Map<String, dynamic> json) =>
      _$CartStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CartStoreToJson(this);
}

@JsonSerializable()
class Cart {
  int cart_id;
  int cart_qty;
  int store_id;
  int product_total;
  Product product;
  Cart(
      {required this.cart_id,
      required this.cart_qty,
      required this.store_id,
      required this.product,
      required this.product_total});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class Product {
  int storeProdId;
  String nameProduct;
  String? stockProduct;
  String? priceProduct;
  String? deskripsiProduct;
  String? uriThumbnail;
  int heightProduct;
  int weightProduct;
  int widthProduct;
  int lengthProduct;
  Product({
    required this.storeProdId,
    required this.nameProduct,
    this.stockProduct,
    this.priceProduct,
    this.deskripsiProduct,
    this.uriThumbnail,
    this.heightProduct = 0,
    this.weightProduct = 0,
    this.widthProduct = 0,
    this.lengthProduct = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
