// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartStore _$CartStoreFromJson(Map<String, dynamic> json) => CartStore(
      store_id: json['store_id'] as int,
      store_name: json['store_name'] as String,
      item: (json['item'] as List<dynamic>?)
              ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CartStoreToJson(CartStore instance) => <String, dynamic>{
      'store_id': instance.store_id,
      'store_name': instance.store_name,
      'item': instance.item,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      cart_id: json['cart_id'] as int,
      cart_qty: json['cart_qty'] as int,
      store_id: json['store_id'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      product_total: json['product_total'] as int,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cart_id': instance.cart_id,
      'cart_qty': instance.cart_qty,
      'store_id': instance.store_id,
      'product_total': instance.product_total,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      storeProdId: json['storeProdId'] as int,
      nameProduct: json['nameProduct'] as String,
      stockProduct: json['stockProduct'] as String?,
      priceProduct: json['priceProduct'] as String?,
      deskripsiProduct: json['deskripsiProduct'] as String?,
      uriThumbnail: json['uriThumbnail'] as String?,
      heightProduct: json['heightProduct'] as int? ?? 0,
      weightProduct: json['weightProduct'] as int? ?? 0,
      widthProduct: json['widthProduct'] as int? ?? 0,
      lengthProduct: json['lengthProduct'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'storeProdId': instance.storeProdId,
      'nameProduct': instance.nameProduct,
      'stockProduct': instance.stockProduct,
      'priceProduct': instance.priceProduct,
      'deskripsiProduct': instance.deskripsiProduct,
      'uriThumbnail': instance.uriThumbnail,
      'heightProduct': instance.heightProduct,
      'weightProduct': instance.weightProduct,
      'widthProduct': instance.widthProduct,
      'lengthProduct': instance.lengthProduct,
    };
