// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseHomeSeeAllProduct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseHomeSeeAllProduct _$PayloadResponseHomeSeeAllProductFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseHomeSeeAllProduct.fromJson(json);
}

/// @nodoc
class _$PayloadResponseHomeSeeAllProductTearOff {
  const _$PayloadResponseHomeSeeAllProductTearOff();

  _PayloadResponseHomeSeeAllProduct call(
      {required String titleTab,
      required List<PayloadResponseStoreProduct>
          viewListStoreProductResponse}) {
    return _PayloadResponseHomeSeeAllProduct(
      titleTab: titleTab,
      viewListStoreProductResponse: viewListStoreProductResponse,
    );
  }

  PayloadResponseHomeSeeAllProduct fromJson(Map<String, Object?> json) {
    return PayloadResponseHomeSeeAllProduct.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseHomeSeeAllProduct =
    _$PayloadResponseHomeSeeAllProductTearOff();

/// @nodoc
mixin _$PayloadResponseHomeSeeAllProduct {
  String get titleTab => throw _privateConstructorUsedError;
  List<PayloadResponseStoreProduct> get viewListStoreProductResponse =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseHomeSeeAllProductCopyWith<PayloadResponseHomeSeeAllProduct>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseHomeSeeAllProductCopyWith<$Res> {
  factory $PayloadResponseHomeSeeAllProductCopyWith(
          PayloadResponseHomeSeeAllProduct value,
          $Res Function(PayloadResponseHomeSeeAllProduct) then) =
      _$PayloadResponseHomeSeeAllProductCopyWithImpl<$Res>;
  $Res call(
      {String titleTab,
      List<PayloadResponseStoreProduct> viewListStoreProductResponse});
}

/// @nodoc
class _$PayloadResponseHomeSeeAllProductCopyWithImpl<$Res>
    implements $PayloadResponseHomeSeeAllProductCopyWith<$Res> {
  _$PayloadResponseHomeSeeAllProductCopyWithImpl(this._value, this._then);

  final PayloadResponseHomeSeeAllProduct _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseHomeSeeAllProduct) _then;

  @override
  $Res call({
    Object? titleTab = freezed,
    Object? viewListStoreProductResponse = freezed,
  }) {
    return _then(_value.copyWith(
      titleTab: titleTab == freezed
          ? _value.titleTab
          : titleTab // ignore: cast_nullable_to_non_nullable
              as String,
      viewListStoreProductResponse: viewListStoreProductResponse == freezed
          ? _value.viewListStoreProductResponse
          : viewListStoreProductResponse // ignore: cast_nullable_to_non_nullable
              as List<PayloadResponseStoreProduct>,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseHomeSeeAllProductCopyWith<$Res>
    implements $PayloadResponseHomeSeeAllProductCopyWith<$Res> {
  factory _$PayloadResponseHomeSeeAllProductCopyWith(
          _PayloadResponseHomeSeeAllProduct value,
          $Res Function(_PayloadResponseHomeSeeAllProduct) then) =
      __$PayloadResponseHomeSeeAllProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String titleTab,
      List<PayloadResponseStoreProduct> viewListStoreProductResponse});
}

/// @nodoc
class __$PayloadResponseHomeSeeAllProductCopyWithImpl<$Res>
    extends _$PayloadResponseHomeSeeAllProductCopyWithImpl<$Res>
    implements _$PayloadResponseHomeSeeAllProductCopyWith<$Res> {
  __$PayloadResponseHomeSeeAllProductCopyWithImpl(
      _PayloadResponseHomeSeeAllProduct _value,
      $Res Function(_PayloadResponseHomeSeeAllProduct) _then)
      : super(_value, (v) => _then(v as _PayloadResponseHomeSeeAllProduct));

  @override
  _PayloadResponseHomeSeeAllProduct get _value =>
      super._value as _PayloadResponseHomeSeeAllProduct;

  @override
  $Res call({
    Object? titleTab = freezed,
    Object? viewListStoreProductResponse = freezed,
  }) {
    return _then(_PayloadResponseHomeSeeAllProduct(
      titleTab: titleTab == freezed
          ? _value.titleTab
          : titleTab // ignore: cast_nullable_to_non_nullable
              as String,
      viewListStoreProductResponse: viewListStoreProductResponse == freezed
          ? _value.viewListStoreProductResponse
          : viewListStoreProductResponse // ignore: cast_nullable_to_non_nullable
              as List<PayloadResponseStoreProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseHomeSeeAllProduct
    implements _PayloadResponseHomeSeeAllProduct {
  const _$_PayloadResponseHomeSeeAllProduct(
      {required this.titleTab, required this.viewListStoreProductResponse});

  factory _$_PayloadResponseHomeSeeAllProduct.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadResponseHomeSeeAllProductFromJson(json);

  @override
  final String titleTab;
  @override
  final List<PayloadResponseStoreProduct> viewListStoreProductResponse;

  @override
  String toString() {
    return 'PayloadResponseHomeSeeAllProduct(titleTab: $titleTab, viewListStoreProductResponse: $viewListStoreProductResponse)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseHomeSeeAllProduct &&
            const DeepCollectionEquality().equals(other.titleTab, titleTab) &&
            const DeepCollectionEquality().equals(
                other.viewListStoreProductResponse,
                viewListStoreProductResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(titleTab),
      const DeepCollectionEquality().hash(viewListStoreProductResponse));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseHomeSeeAllProductCopyWith<_PayloadResponseHomeSeeAllProduct>
      get copyWith => __$PayloadResponseHomeSeeAllProductCopyWithImpl<
          _PayloadResponseHomeSeeAllProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseHomeSeeAllProductToJson(this);
  }
}

abstract class _PayloadResponseHomeSeeAllProduct
    implements PayloadResponseHomeSeeAllProduct {
  const factory _PayloadResponseHomeSeeAllProduct(
      {required String titleTab,
      required List<PayloadResponseStoreProduct>
          viewListStoreProductResponse}) = _$_PayloadResponseHomeSeeAllProduct;

  factory _PayloadResponseHomeSeeAllProduct.fromJson(
      Map<String, dynamic> json) = _$_PayloadResponseHomeSeeAllProduct.fromJson;

  @override
  String get titleTab;
  @override
  List<PayloadResponseStoreProduct> get viewListStoreProductResponse;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseHomeSeeAllProductCopyWith<_PayloadResponseHomeSeeAllProduct>
      get copyWith => throw _privateConstructorUsedError;
}