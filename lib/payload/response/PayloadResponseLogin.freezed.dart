// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseLogin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseLogin _$PayloadResponseLoginFromJson(Map<String, dynamic> json) {
  return _PayloadResponseLogin.fromJson(json);
}

/// @nodoc
class _$PayloadResponseLoginTearOff {
  const _$PayloadResponseLoginTearOff();

  _PayloadResponseLogin call({required String token}) {
    return _PayloadResponseLogin(
      token: token,
    );
  }

  PayloadResponseLogin fromJson(Map<String, Object?> json) {
    return PayloadResponseLogin.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseLogin = _$PayloadResponseLoginTearOff();

/// @nodoc
mixin _$PayloadResponseLogin {
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseLoginCopyWith<PayloadResponseLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseLoginCopyWith<$Res> {
  factory $PayloadResponseLoginCopyWith(PayloadResponseLogin value,
          $Res Function(PayloadResponseLogin) then) =
      _$PayloadResponseLoginCopyWithImpl<$Res>;
  $Res call({String token});
}

/// @nodoc
class _$PayloadResponseLoginCopyWithImpl<$Res>
    implements $PayloadResponseLoginCopyWith<$Res> {
  _$PayloadResponseLoginCopyWithImpl(this._value, this._then);

  final PayloadResponseLogin _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseLogin) _then;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseLoginCopyWith<$Res>
    implements $PayloadResponseLoginCopyWith<$Res> {
  factory _$PayloadResponseLoginCopyWith(_PayloadResponseLogin value,
          $Res Function(_PayloadResponseLogin) then) =
      __$PayloadResponseLoginCopyWithImpl<$Res>;
  @override
  $Res call({String token});
}

/// @nodoc
class __$PayloadResponseLoginCopyWithImpl<$Res>
    extends _$PayloadResponseLoginCopyWithImpl<$Res>
    implements _$PayloadResponseLoginCopyWith<$Res> {
  __$PayloadResponseLoginCopyWithImpl(
      _PayloadResponseLogin _value, $Res Function(_PayloadResponseLogin) _then)
      : super(_value, (v) => _then(v as _PayloadResponseLogin));

  @override
  _PayloadResponseLogin get _value => super._value as _PayloadResponseLogin;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_PayloadResponseLogin(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseLogin implements _PayloadResponseLogin {
  const _$_PayloadResponseLogin({required this.token});

  factory _$_PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseLoginFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'PayloadResponseLogin(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseLogin &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseLoginCopyWith<_PayloadResponseLogin> get copyWith =>
      __$PayloadResponseLoginCopyWithImpl<_PayloadResponseLogin>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseLoginToJson(this);
  }
}

abstract class _PayloadResponseLogin implements PayloadResponseLogin {
  const factory _PayloadResponseLogin({required String token}) =
      _$_PayloadResponseLogin;

  factory _PayloadResponseLogin.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseLogin.fromJson;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseLoginCopyWith<_PayloadResponseLogin> get copyWith =>
      throw _privateConstructorUsedError;
}
