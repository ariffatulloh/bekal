// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestCreateStore.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestCreateStore _$PayloadRequestCreateStoreFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestCreateStore.fromJson(json);
}

/// @nodoc
class _$PayloadRequestCreateStoreTearOff {
  const _$PayloadRequestCreateStoreTearOff();

  _PayloadRequestCreateStore call(
      {required String nameStore,
      required String addressStore,
      required String phoneNumber,
      required String detailAddressStore,
      required String status,
      int? idStore}) {
    return _PayloadRequestCreateStore(
      nameStore: nameStore,
      addressStore: addressStore,
      phoneNumber: phoneNumber,
      detailAddressStore: detailAddressStore,
      status: status,
      idStore: idStore,
    );
  }

  PayloadRequestCreateStore fromJson(Map<String, Object?> json) {
    return PayloadRequestCreateStore.fromJson(json);
  }
}

/// @nodoc
const $PayloadRequestCreateStore = _$PayloadRequestCreateStoreTearOff();

/// @nodoc
mixin _$PayloadRequestCreateStore {
  String get nameStore => throw _privateConstructorUsedError;
  String get addressStore => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get detailAddressStore => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get idStore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestCreateStoreCopyWith<PayloadRequestCreateStore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestCreateStoreCopyWith<$Res> {
  factory $PayloadRequestCreateStoreCopyWith(PayloadRequestCreateStore value,
          $Res Function(PayloadRequestCreateStore) then) =
      _$PayloadRequestCreateStoreCopyWithImpl<$Res>;
  $Res call(
      {String nameStore,
      String addressStore,
      String phoneNumber,
      String detailAddressStore,
      String status,
      int? idStore});
}

/// @nodoc
class _$PayloadRequestCreateStoreCopyWithImpl<$Res>
    implements $PayloadRequestCreateStoreCopyWith<$Res> {
  _$PayloadRequestCreateStoreCopyWithImpl(this._value, this._then);

  final PayloadRequestCreateStore _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestCreateStore) _then;

  @override
  $Res call({
    Object? nameStore = freezed,
    Object? addressStore = freezed,
    Object? phoneNumber = freezed,
    Object? detailAddressStore = freezed,
    Object? status = freezed,
    Object? idStore = freezed,
  }) {
    return _then(_value.copyWith(
      nameStore: nameStore == freezed
          ? _value.nameStore
          : nameStore // ignore: cast_nullable_to_non_nullable
              as String,
      addressStore: addressStore == freezed
          ? _value.addressStore
          : addressStore // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      detailAddressStore: detailAddressStore == freezed
          ? _value.detailAddressStore
          : detailAddressStore // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      idStore: idStore == freezed
          ? _value.idStore
          : idStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$PayloadRequestCreateStoreCopyWith<$Res>
    implements $PayloadRequestCreateStoreCopyWith<$Res> {
  factory _$PayloadRequestCreateStoreCopyWith(_PayloadRequestCreateStore value,
          $Res Function(_PayloadRequestCreateStore) then) =
      __$PayloadRequestCreateStoreCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nameStore,
      String addressStore,
      String phoneNumber,
      String detailAddressStore,
      String status,
      int? idStore});
}

/// @nodoc
class __$PayloadRequestCreateStoreCopyWithImpl<$Res>
    extends _$PayloadRequestCreateStoreCopyWithImpl<$Res>
    implements _$PayloadRequestCreateStoreCopyWith<$Res> {
  __$PayloadRequestCreateStoreCopyWithImpl(_PayloadRequestCreateStore _value,
      $Res Function(_PayloadRequestCreateStore) _then)
      : super(_value, (v) => _then(v as _PayloadRequestCreateStore));

  @override
  _PayloadRequestCreateStore get _value =>
      super._value as _PayloadRequestCreateStore;

  @override
  $Res call({
    Object? nameStore = freezed,
    Object? addressStore = freezed,
    Object? phoneNumber = freezed,
    Object? detailAddressStore = freezed,
    Object? status = freezed,
    Object? idStore = freezed,
  }) {
    return _then(_PayloadRequestCreateStore(
      nameStore: nameStore == freezed
          ? _value.nameStore
          : nameStore // ignore: cast_nullable_to_non_nullable
              as String,
      addressStore: addressStore == freezed
          ? _value.addressStore
          : addressStore // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      detailAddressStore: detailAddressStore == freezed
          ? _value.detailAddressStore
          : detailAddressStore // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      idStore: idStore == freezed
          ? _value.idStore
          : idStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestCreateStore implements _PayloadRequestCreateStore {
  const _$_PayloadRequestCreateStore(
      {required this.nameStore,
      required this.addressStore,
      required this.phoneNumber,
      required this.detailAddressStore,
      required this.status,
      this.idStore});

  factory _$_PayloadRequestCreateStore.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadRequestCreateStoreFromJson(json);

  @override
  final String nameStore;
  @override
  final String addressStore;
  @override
  final String phoneNumber;
  @override
  final String detailAddressStore;
  @override
  final String status;
  @override
  final int? idStore;

  @override
  String toString() {
    return 'PayloadRequestCreateStore(nameStore: $nameStore, addressStore: $addressStore, phoneNumber: $phoneNumber, detailAddressStore: $detailAddressStore, status: $status, idStore: $idStore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadRequestCreateStore &&
            const DeepCollectionEquality().equals(other.nameStore, nameStore) &&
            const DeepCollectionEquality()
                .equals(other.addressStore, addressStore) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other.detailAddressStore, detailAddressStore) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.idStore, idStore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nameStore),
      const DeepCollectionEquality().hash(addressStore),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(detailAddressStore),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(idStore));

  @JsonKey(ignore: true)
  @override
  _$PayloadRequestCreateStoreCopyWith<_PayloadRequestCreateStore>
      get copyWith =>
          __$PayloadRequestCreateStoreCopyWithImpl<_PayloadRequestCreateStore>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestCreateStoreToJson(this);
  }
}

abstract class _PayloadRequestCreateStore implements PayloadRequestCreateStore {
  const factory _PayloadRequestCreateStore(
      {required String nameStore,
      required String addressStore,
      required String phoneNumber,
      required String detailAddressStore,
      required String status,
      int? idStore}) = _$_PayloadRequestCreateStore;

  factory _PayloadRequestCreateStore.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestCreateStore.fromJson;

  @override
  String get nameStore;
  @override
  String get addressStore;
  @override
  String get phoneNumber;
  @override
  String get detailAddressStore;
  @override
  String get status;
  @override
  int? get idStore;
  @override
  @JsonKey(ignore: true)
  _$PayloadRequestCreateStoreCopyWith<_PayloadRequestCreateStore>
      get copyWith => throw _privateConstructorUsedError;
}