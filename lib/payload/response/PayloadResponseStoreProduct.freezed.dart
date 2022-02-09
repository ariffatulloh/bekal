// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseStoreProduct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseStoreProduct _$PayloadResponseStoreProductFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseStoreProduct.fromJson(json);
}

/// @nodoc
class _$PayloadResponseStoreProductTearOff {
  const _$PayloadResponseStoreProductTearOff();

  _PayloadResponseStoreProduct call(
      {required int storeProdId,
      required String nameProduct,
      required String stockProduct,
      required String priceProduct,
      required String deskripsiProduct,
      required String uriThumbnail,
      required InfoStore store,
      required List<GalleryImage> galleryImage,
      required List<CategoryProduct> categoryProduct}) {
    return _PayloadResponseStoreProduct(
      storeProdId: storeProdId,
      nameProduct: nameProduct,
      stockProduct: stockProduct,
      priceProduct: priceProduct,
      deskripsiProduct: deskripsiProduct,
      uriThumbnail: uriThumbnail,
      store: store,
      galleryImage: galleryImage,
      categoryProduct: categoryProduct,
    );
  }

  PayloadResponseStoreProduct fromJson(Map<String, Object?> json) {
    return PayloadResponseStoreProduct.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseStoreProduct = _$PayloadResponseStoreProductTearOff();

/// @nodoc
mixin _$PayloadResponseStoreProduct {
  int get storeProdId => throw _privateConstructorUsedError;
  String get nameProduct => throw _privateConstructorUsedError;
  String get stockProduct => throw _privateConstructorUsedError;
  String get priceProduct => throw _privateConstructorUsedError;
  String get deskripsiProduct => throw _privateConstructorUsedError;
  String get uriThumbnail => throw _privateConstructorUsedError;
  InfoStore get store => throw _privateConstructorUsedError;
  List<GalleryImage> get galleryImage => throw _privateConstructorUsedError;
  List<CategoryProduct> get categoryProduct =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseStoreProductCopyWith<PayloadResponseStoreProduct>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseStoreProductCopyWith<$Res> {
  factory $PayloadResponseStoreProductCopyWith(
          PayloadResponseStoreProduct value,
          $Res Function(PayloadResponseStoreProduct) then) =
      _$PayloadResponseStoreProductCopyWithImpl<$Res>;
  $Res call(
      {int storeProdId,
      String nameProduct,
      String stockProduct,
      String priceProduct,
      String deskripsiProduct,
      String uriThumbnail,
      InfoStore store,
      List<GalleryImage> galleryImage,
      List<CategoryProduct> categoryProduct});
}

/// @nodoc
class _$PayloadResponseStoreProductCopyWithImpl<$Res>
    implements $PayloadResponseStoreProductCopyWith<$Res> {
  _$PayloadResponseStoreProductCopyWithImpl(this._value, this._then);

  final PayloadResponseStoreProduct _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseStoreProduct) _then;

  @override
  $Res call({
    Object? storeProdId = freezed,
    Object? nameProduct = freezed,
    Object? stockProduct = freezed,
    Object? priceProduct = freezed,
    Object? deskripsiProduct = freezed,
    Object? uriThumbnail = freezed,
    Object? store = freezed,
    Object? galleryImage = freezed,
    Object? categoryProduct = freezed,
  }) {
    return _then(_value.copyWith(
      storeProdId: storeProdId == freezed
          ? _value.storeProdId
          : storeProdId // ignore: cast_nullable_to_non_nullable
              as int,
      nameProduct: nameProduct == freezed
          ? _value.nameProduct
          : nameProduct // ignore: cast_nullable_to_non_nullable
              as String,
      stockProduct: stockProduct == freezed
          ? _value.stockProduct
          : stockProduct // ignore: cast_nullable_to_non_nullable
              as String,
      priceProduct: priceProduct == freezed
          ? _value.priceProduct
          : priceProduct // ignore: cast_nullable_to_non_nullable
              as String,
      deskripsiProduct: deskripsiProduct == freezed
          ? _value.deskripsiProduct
          : deskripsiProduct // ignore: cast_nullable_to_non_nullable
              as String,
      uriThumbnail: uriThumbnail == freezed
          ? _value.uriThumbnail
          : uriThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      store: store == freezed
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as InfoStore,
      galleryImage: galleryImage == freezed
          ? _value.galleryImage
          : galleryImage // ignore: cast_nullable_to_non_nullable
              as List<GalleryImage>,
      categoryProduct: categoryProduct == freezed
          ? _value.categoryProduct
          : categoryProduct // ignore: cast_nullable_to_non_nullable
              as List<CategoryProduct>,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseStoreProductCopyWith<$Res>
    implements $PayloadResponseStoreProductCopyWith<$Res> {
  factory _$PayloadResponseStoreProductCopyWith(
          _PayloadResponseStoreProduct value,
          $Res Function(_PayloadResponseStoreProduct) then) =
      __$PayloadResponseStoreProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {int storeProdId,
      String nameProduct,
      String stockProduct,
      String priceProduct,
      String deskripsiProduct,
      String uriThumbnail,
      InfoStore store,
      List<GalleryImage> galleryImage,
      List<CategoryProduct> categoryProduct});
}

/// @nodoc
class __$PayloadResponseStoreProductCopyWithImpl<$Res>
    extends _$PayloadResponseStoreProductCopyWithImpl<$Res>
    implements _$PayloadResponseStoreProductCopyWith<$Res> {
  __$PayloadResponseStoreProductCopyWithImpl(
      _PayloadResponseStoreProduct _value,
      $Res Function(_PayloadResponseStoreProduct) _then)
      : super(_value, (v) => _then(v as _PayloadResponseStoreProduct));

  @override
  _PayloadResponseStoreProduct get _value =>
      super._value as _PayloadResponseStoreProduct;

  @override
  $Res call({
    Object? storeProdId = freezed,
    Object? nameProduct = freezed,
    Object? stockProduct = freezed,
    Object? priceProduct = freezed,
    Object? deskripsiProduct = freezed,
    Object? uriThumbnail = freezed,
    Object? store = freezed,
    Object? galleryImage = freezed,
    Object? categoryProduct = freezed,
  }) {
    return _then(_PayloadResponseStoreProduct(
      storeProdId: storeProdId == freezed
          ? _value.storeProdId
          : storeProdId // ignore: cast_nullable_to_non_nullable
              as int,
      nameProduct: nameProduct == freezed
          ? _value.nameProduct
          : nameProduct // ignore: cast_nullable_to_non_nullable
              as String,
      stockProduct: stockProduct == freezed
          ? _value.stockProduct
          : stockProduct // ignore: cast_nullable_to_non_nullable
              as String,
      priceProduct: priceProduct == freezed
          ? _value.priceProduct
          : priceProduct // ignore: cast_nullable_to_non_nullable
              as String,
      deskripsiProduct: deskripsiProduct == freezed
          ? _value.deskripsiProduct
          : deskripsiProduct // ignore: cast_nullable_to_non_nullable
              as String,
      uriThumbnail: uriThumbnail == freezed
          ? _value.uriThumbnail
          : uriThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      store: store == freezed
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as InfoStore,
      galleryImage: galleryImage == freezed
          ? _value.galleryImage
          : galleryImage // ignore: cast_nullable_to_non_nullable
              as List<GalleryImage>,
      categoryProduct: categoryProduct == freezed
          ? _value.categoryProduct
          : categoryProduct // ignore: cast_nullable_to_non_nullable
              as List<CategoryProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseStoreProduct implements _PayloadResponseStoreProduct {
  const _$_PayloadResponseStoreProduct(
      {required this.storeProdId,
      required this.nameProduct,
      required this.stockProduct,
      required this.priceProduct,
      required this.deskripsiProduct,
      required this.uriThumbnail,
      required this.store,
      required this.galleryImage,
      required this.categoryProduct});

  factory _$_PayloadResponseStoreProduct.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseStoreProductFromJson(json);

  @override
  final int storeProdId;
  @override
  final String nameProduct;
  @override
  final String stockProduct;
  @override
  final String priceProduct;
  @override
  final String deskripsiProduct;
  @override
  final String uriThumbnail;
  @override
  final InfoStore store;
  @override
  final List<GalleryImage> galleryImage;
  @override
  final List<CategoryProduct> categoryProduct;

  @override
  String toString() {
    return 'PayloadResponseStoreProduct(storeProdId: $storeProdId, nameProduct: $nameProduct, stockProduct: $stockProduct, priceProduct: $priceProduct, deskripsiProduct: $deskripsiProduct, uriThumbnail: $uriThumbnail, store: $store, galleryImage: $galleryImage, categoryProduct: $categoryProduct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseStoreProduct &&
            const DeepCollectionEquality()
                .equals(other.storeProdId, storeProdId) &&
            const DeepCollectionEquality()
                .equals(other.nameProduct, nameProduct) &&
            const DeepCollectionEquality()
                .equals(other.stockProduct, stockProduct) &&
            const DeepCollectionEquality()
                .equals(other.priceProduct, priceProduct) &&
            const DeepCollectionEquality()
                .equals(other.deskripsiProduct, deskripsiProduct) &&
            const DeepCollectionEquality()
                .equals(other.uriThumbnail, uriThumbnail) &&
            const DeepCollectionEquality().equals(other.store, store) &&
            const DeepCollectionEquality()
                .equals(other.galleryImage, galleryImage) &&
            const DeepCollectionEquality()
                .equals(other.categoryProduct, categoryProduct));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(storeProdId),
      const DeepCollectionEquality().hash(nameProduct),
      const DeepCollectionEquality().hash(stockProduct),
      const DeepCollectionEquality().hash(priceProduct),
      const DeepCollectionEquality().hash(deskripsiProduct),
      const DeepCollectionEquality().hash(uriThumbnail),
      const DeepCollectionEquality().hash(store),
      const DeepCollectionEquality().hash(galleryImage),
      const DeepCollectionEquality().hash(categoryProduct));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseStoreProductCopyWith<_PayloadResponseStoreProduct>
      get copyWith => __$PayloadResponseStoreProductCopyWithImpl<
          _PayloadResponseStoreProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseStoreProductToJson(this);
  }
}

abstract class _PayloadResponseStoreProduct
    implements PayloadResponseStoreProduct {
  const factory _PayloadResponseStoreProduct(
          {required int storeProdId,
          required String nameProduct,
          required String stockProduct,
          required String priceProduct,
          required String deskripsiProduct,
          required String uriThumbnail,
          required InfoStore store,
          required List<GalleryImage> galleryImage,
          required List<CategoryProduct> categoryProduct}) =
      _$_PayloadResponseStoreProduct;

  factory _PayloadResponseStoreProduct.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseStoreProduct.fromJson;

  @override
  int get storeProdId;
  @override
  String get nameProduct;
  @override
  String get stockProduct;
  @override
  String get priceProduct;
  @override
  String get deskripsiProduct;
  @override
  String get uriThumbnail;
  @override
  InfoStore get store;
  @override
  List<GalleryImage> get galleryImage;
  @override
  List<CategoryProduct> get categoryProduct;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseStoreProductCopyWith<_PayloadResponseStoreProduct>
      get copyWith => throw _privateConstructorUsedError;
}
