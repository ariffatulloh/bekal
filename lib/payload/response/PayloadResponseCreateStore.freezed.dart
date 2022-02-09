// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseCreateStore.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseCreateStore _$PayloadResponseCreateStoreFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseCreateStore.fromJson(json);
}

/// @nodoc
class _$PayloadResponseCreateStoreTearOff {
  const _$PayloadResponseCreateStoreTearOff();

  _PayloadResponseCreateStore call({required String message}) {
    return _PayloadResponseCreateStore(
      message: message,
    );
  }

  PayloadResponseCreateStore fromJson(Map<String, Object?> json) {
    return PayloadResponseCreateStore.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseCreateStore = _$PayloadResponseCreateStoreTearOff();

/// @nodoc
mixin _$PayloadResponseCreateStore {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseCreateStoreCopyWith<PayloadResponseCreateStore>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseCreateStoreCopyWith<$Res> {
  factory $PayloadResponseCreateStoreCopyWith(PayloadResponseCreateStore value,
          $Res Function(PayloadResponseCreateStore) then) =
      _$PayloadResponseCreateStoreCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$PayloadResponseCreateStoreCopyWithImpl<$Res>
    implements $PayloadResponseCreateStoreCopyWith<$Res> {
  _$PayloadResponseCreateStoreCopyWithImpl(this._value, this._then);

  final PayloadResponseCreateStore _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseCreateStore) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseCreateStoreCopyWith<$Res>
    implements $PayloadResponseCreateStoreCopyWith<$Res> {
  factory _$PayloadResponseCreateStoreCopyWith(
          _PayloadResponseCreateStore value,
          $Res Function(_PayloadResponseCreateStore) then) =
      __$PayloadResponseCreateStoreCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$PayloadResponseCreateStoreCopyWithImpl<$Res>
    extends _$PayloadResponseCreateStoreCopyWithImpl<$Res>
    implements _$PayloadResponseCreateStoreCopyWith<$Res> {
  __$PayloadResponseCreateStoreCopyWithImpl(_PayloadResponseCreateStore _value,
      $Res Function(_PayloadResponseCreateStore) _then)
      : super(_value, (v) => _then(v as _PayloadResponseCreateStore));

  @override
  _PayloadResponseCreateStore get _value =>
      super._value as _PayloadResponseCreateStore;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_PayloadResponseCreateStore(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseCreateStore implements _PayloadResponseCreateStore {
  const _$_PayloadResponseCreateStore({required this.message});

  factory _$_PayloadResponseCreateStore.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseCreateStoreFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'PayloadResponseCreateStore(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseCreateStore &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseCreateStoreCopyWith<_PayloadResponseCreateStore>
      get copyWith => __$PayloadResponseCreateStoreCopyWithImpl<
          _PayloadResponseCreateStore>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseCreateStoreToJson(this);
  }
}

abstract class _PayloadResponseCreateStore
    implements PayloadResponseCreateStore {
  const factory _PayloadResponseCreateStore({required String message}) =
      _$_PayloadResponseCreateStore;

  factory _PayloadResponseCreateStore.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseCreateStore.fromJson;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseCreateStoreCopyWith<_PayloadResponseCreateStore>
      get copyWith => throw _privateConstructorUsedError;
}
