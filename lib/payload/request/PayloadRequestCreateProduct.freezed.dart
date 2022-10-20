// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestCreateProduct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestCreateProduct _$PayloadRequestCreateProductFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestCreateProduct.fromJson(json);
}

/// @nodoc
mixin _$PayloadRequestCreateProduct {
  String get deskripsiProduct => throw _privateConstructorUsedError;
  String get priceProduct => throw _privateConstructorUsedError;
  String get stockProduct => throw _privateConstructorUsedError;
  String get nameProduct => throw _privateConstructorUsedError;
  List<String> get storeCatProd => throw _privateConstructorUsedError;
  int? get idStore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestCreateProductCopyWith<PayloadRequestCreateProduct>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestCreateProductCopyWith<$Res> {
  factory $PayloadRequestCreateProductCopyWith(
          PayloadRequestCreateProduct value,
          $Res Function(PayloadRequestCreateProduct) then) =
      _$PayloadRequestCreateProductCopyWithImpl<$Res>;
  $Res call(
      {String deskripsiProduct,
      String priceProduct,
      String stockProduct,
      String nameProduct,
      List<String> storeCatProd,
      int? idStore});
}

/// @nodoc
class _$PayloadRequestCreateProductCopyWithImpl<$Res>
    implements $PayloadRequestCreateProductCopyWith<$Res> {
  _$PayloadRequestCreateProductCopyWithImpl(this._value, this._then);

  final PayloadRequestCreateProduct _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestCreateProduct) _then;

  @override
  $Res call({
    Object? deskripsiProduct = freezed,
    Object? priceProduct = freezed,
    Object? stockProduct = freezed,
    Object? nameProduct = freezed,
    Object? storeCatProd = freezed,
    Object? idStore = freezed,
  }) {
    return _then(_value.copyWith(
      deskripsiProduct: deskripsiProduct == freezed
          ? _value.deskripsiProduct
          : deskripsiProduct // ignore: cast_nullable_to_non_nullable
              as String,
      priceProduct: priceProduct == freezed
          ? _value.priceProduct
          : priceProduct // ignore: cast_nullable_to_non_nullable
              as String,
      stockProduct: stockProduct == freezed
          ? _value.stockProduct
          : stockProduct // ignore: cast_nullable_to_non_nullable
              as String,
      nameProduct: nameProduct == freezed
          ? _value.nameProduct
          : nameProduct // ignore: cast_nullable_to_non_nullable
              as String,
      storeCatProd: storeCatProd == freezed
          ? _value.storeCatProd
          : storeCatProd // ignore: cast_nullable_to_non_nullable
              as List<String>,
      idStore: idStore == freezed
          ? _value.idStore
          : idStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadRequestCreateProductCopyWith<$Res>
    implements $PayloadRequestCreateProductCopyWith<$Res> {
  factory _$$_PayloadRequestCreateProductCopyWith(
          _$_PayloadRequestCreateProduct value,
          $Res Function(_$_PayloadRequestCreateProduct) then) =
      __$$_PayloadRequestCreateProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String deskripsiProduct,
      String priceProduct,
      String stockProduct,
      String nameProduct,
      List<String> storeCatProd,
      int? idStore});
}

/// @nodoc
class __$$_PayloadRequestCreateProductCopyWithImpl<$Res>
    extends _$PayloadRequestCreateProductCopyWithImpl<$Res>
    implements _$$_PayloadRequestCreateProductCopyWith<$Res> {
  __$$_PayloadRequestCreateProductCopyWithImpl(
      _$_PayloadRequestCreateProduct _value,
      $Res Function(_$_PayloadRequestCreateProduct) _then)
      : super(_value, (v) => _then(v as _$_PayloadRequestCreateProduct));

  @override
  _$_PayloadRequestCreateProduct get _value =>
      super._value as _$_PayloadRequestCreateProduct;

  @override
  $Res call({
    Object? deskripsiProduct = freezed,
    Object? priceProduct = freezed,
    Object? stockProduct = freezed,
    Object? nameProduct = freezed,
    Object? storeCatProd = freezed,
    Object? idStore = freezed,
  }) {
    return _then(_$_PayloadRequestCreateProduct(
      deskripsiProduct: deskripsiProduct == freezed
          ? _value.deskripsiProduct
          : deskripsiProduct // ignore: cast_nullable_to_non_nullable
              as String,
      priceProduct: priceProduct == freezed
          ? _value.priceProduct
          : priceProduct // ignore: cast_nullable_to_non_nullable
              as String,
      stockProduct: stockProduct == freezed
          ? _value.stockProduct
          : stockProduct // ignore: cast_nullable_to_non_nullable
              as String,
      nameProduct: nameProduct == freezed
          ? _value.nameProduct
          : nameProduct // ignore: cast_nullable_to_non_nullable
              as String,
      storeCatProd: storeCatProd == freezed
          ? _value._storeCatProd
          : storeCatProd // ignore: cast_nullable_to_non_nullable
              as List<String>,
      idStore: idStore == freezed
          ? _value.idStore
          : idStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestCreateProduct implements _PayloadRequestCreateProduct {
  const _$_PayloadRequestCreateProduct(
      {required this.deskripsiProduct,
      required this.priceProduct,
      required this.stockProduct,
      required this.nameProduct,
      required final List<String> storeCatProd,
      this.idStore})
      : _storeCatProd = storeCatProd;

  factory _$_PayloadRequestCreateProduct.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadRequestCreateProductFromJson(json);

  @override
  final String deskripsiProduct;
  @override
  final String priceProduct;
  @override
  final String stockProduct;
  @override
  final String nameProduct;
  final List<String> _storeCatProd;
  @override
  List<String> get storeCatProd {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeCatProd);
  }

  @override
  final int? idStore;

  @override
  String toString() {
    return 'PayloadRequestCreateProduct(deskripsiProduct: $deskripsiProduct, priceProduct: $priceProduct, stockProduct: $stockProduct, nameProduct: $nameProduct, storeCatProd: $storeCatProd, idStore: $idStore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadRequestCreateProduct &&
            const DeepCollectionEquality()
                .equals(other.deskripsiProduct, deskripsiProduct) &&
            const DeepCollectionEquality()
                .equals(other.priceProduct, priceProduct) &&
            const DeepCollectionEquality()
                .equals(other.stockProduct, stockProduct) &&
            const DeepCollectionEquality()
                .equals(other.nameProduct, nameProduct) &&
            const DeepCollectionEquality()
                .equals(other._storeCatProd, _storeCatProd) &&
            const DeepCollectionEquality().equals(other.idStore, idStore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(deskripsiProduct),
      const DeepCollectionEquality().hash(priceProduct),
      const DeepCollectionEquality().hash(stockProduct),
      const DeepCollectionEquality().hash(nameProduct),
      const DeepCollectionEquality().hash(_storeCatProd),
      const DeepCollectionEquality().hash(idStore));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadRequestCreateProductCopyWith<_$_PayloadRequestCreateProduct>
      get copyWith => __$$_PayloadRequestCreateProductCopyWithImpl<
          _$_PayloadRequestCreateProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestCreateProductToJson(this);
  }
}

abstract class _PayloadRequestCreateProduct
    implements PayloadRequestCreateProduct {
  const factory _PayloadRequestCreateProduct(
      {required final String deskripsiProduct,
      required final String priceProduct,
      required final String stockProduct,
      required final String nameProduct,
      required final List<String> storeCatProd,
      final int? idStore}) = _$_PayloadRequestCreateProduct;

  factory _PayloadRequestCreateProduct.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestCreateProduct.fromJson;

  @override
  String get deskripsiProduct => throw _privateConstructorUsedError;
  @override
  String get priceProduct => throw _privateConstructorUsedError;
  @override
  String get stockProduct => throw _privateConstructorUsedError;
  @override
  String get nameProduct => throw _privateConstructorUsedError;
  @override
  List<String> get storeCatProd => throw _privateConstructorUsedError;
  @override
  int? get idStore => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadRequestCreateProductCopyWith<_$_PayloadRequestCreateProduct>
      get copyWith => throw _privateConstructorUsedError;
}
