// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseStoreCategory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseStoreCategory _$PayloadResponseStoreCategoryFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseStoreCategory.fromJson(json);
}

/// @nodoc
class _$PayloadResponseStoreCategoryTearOff {
  const _$PayloadResponseStoreCategoryTearOff();

  _PayloadResponseStoreCategory call(
      {required String storeName,
      required String categoryName,
      required int categoryId}) {
    return _PayloadResponseStoreCategory(
      storeName: storeName,
      categoryName: categoryName,
      categoryId: categoryId,
    );
  }

  PayloadResponseStoreCategory fromJson(Map<String, Object?> json) {
    return PayloadResponseStoreCategory.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseStoreCategory = _$PayloadResponseStoreCategoryTearOff();

/// @nodoc
mixin _$PayloadResponseStoreCategory {
  String get storeName => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseStoreCategoryCopyWith<PayloadResponseStoreCategory>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseStoreCategoryCopyWith<$Res> {
  factory $PayloadResponseStoreCategoryCopyWith(
          PayloadResponseStoreCategory value,
          $Res Function(PayloadResponseStoreCategory) then) =
      _$PayloadResponseStoreCategoryCopyWithImpl<$Res>;
  $Res call({String storeName, String categoryName, int categoryId});
}

/// @nodoc
class _$PayloadResponseStoreCategoryCopyWithImpl<$Res>
    implements $PayloadResponseStoreCategoryCopyWith<$Res> {
  _$PayloadResponseStoreCategoryCopyWithImpl(this._value, this._then);

  final PayloadResponseStoreCategory _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseStoreCategory) _then;

  @override
  $Res call({
    Object? storeName = freezed,
    Object? categoryName = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      storeName: storeName == freezed
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseStoreCategoryCopyWith<$Res>
    implements $PayloadResponseStoreCategoryCopyWith<$Res> {
  factory _$PayloadResponseStoreCategoryCopyWith(
          _PayloadResponseStoreCategory value,
          $Res Function(_PayloadResponseStoreCategory) then) =
      __$PayloadResponseStoreCategoryCopyWithImpl<$Res>;
  @override
  $Res call({String storeName, String categoryName, int categoryId});
}

/// @nodoc
class __$PayloadResponseStoreCategoryCopyWithImpl<$Res>
    extends _$PayloadResponseStoreCategoryCopyWithImpl<$Res>
    implements _$PayloadResponseStoreCategoryCopyWith<$Res> {
  __$PayloadResponseStoreCategoryCopyWithImpl(
      _PayloadResponseStoreCategory _value,
      $Res Function(_PayloadResponseStoreCategory) _then)
      : super(_value, (v) => _then(v as _PayloadResponseStoreCategory));

  @override
  _PayloadResponseStoreCategory get _value =>
      super._value as _PayloadResponseStoreCategory;

  @override
  $Res call({
    Object? storeName = freezed,
    Object? categoryName = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_PayloadResponseStoreCategory(
      storeName: storeName == freezed
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseStoreCategory implements _PayloadResponseStoreCategory {
  const _$_PayloadResponseStoreCategory(
      {required this.storeName,
      required this.categoryName,
      required this.categoryId});

  factory _$_PayloadResponseStoreCategory.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseStoreCategoryFromJson(json);

  @override
  final String storeName;
  @override
  final String categoryName;
  @override
  final int categoryId;

  @override
  String toString() {
    return 'PayloadResponseStoreCategory(storeName: $storeName, categoryName: $categoryName, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseStoreCategory &&
            const DeepCollectionEquality().equals(other.storeName, storeName) &&
            const DeepCollectionEquality()
                .equals(other.categoryName, categoryName) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(storeName),
      const DeepCollectionEquality().hash(categoryName),
      const DeepCollectionEquality().hash(categoryId));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseStoreCategoryCopyWith<_PayloadResponseStoreCategory>
      get copyWith => __$PayloadResponseStoreCategoryCopyWithImpl<
          _PayloadResponseStoreCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseStoreCategoryToJson(this);
  }
}

abstract class _PayloadResponseStoreCategory
    implements PayloadResponseStoreCategory {
  const factory _PayloadResponseStoreCategory(
      {required String storeName,
      required String categoryName,
      required int categoryId}) = _$_PayloadResponseStoreCategory;

  factory _PayloadResponseStoreCategory.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseStoreCategory.fromJson;

  @override
  String get storeName;
  @override
  String get categoryName;
  @override
  int get categoryId;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseStoreCategoryCopyWith<_PayloadResponseStoreCategory>
      get copyWith => throw _privateConstructorUsedError;
}