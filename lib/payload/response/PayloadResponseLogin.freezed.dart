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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseLogin _$PayloadResponseLoginFromJson(Map<String, dynamic> json) {
  return _PayloadResponseLogin.fromJson(json);
}

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
abstract class _$$_PayloadResponseLoginCopyWith<$Res>
    implements $PayloadResponseLoginCopyWith<$Res> {
  factory _$$_PayloadResponseLoginCopyWith(_$_PayloadResponseLogin value,
          $Res Function(_$_PayloadResponseLogin) then) =
      __$$_PayloadResponseLoginCopyWithImpl<$Res>;
  @override
  $Res call({String token});
}

/// @nodoc
class __$$_PayloadResponseLoginCopyWithImpl<$Res>
    extends _$PayloadResponseLoginCopyWithImpl<$Res>
    implements _$$_PayloadResponseLoginCopyWith<$Res> {
  __$$_PayloadResponseLoginCopyWithImpl(_$_PayloadResponseLogin _value,
      $Res Function(_$_PayloadResponseLogin) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseLogin));

  @override
  _$_PayloadResponseLogin get _value => super._value as _$_PayloadResponseLogin;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_$_PayloadResponseLogin(
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
            other is _$_PayloadResponseLogin &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseLoginCopyWith<_$_PayloadResponseLogin> get copyWith =>
      __$$_PayloadResponseLoginCopyWithImpl<_$_PayloadResponseLogin>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseLoginToJson(this);
  }
}

abstract class _PayloadResponseLogin implements PayloadResponseLogin {
  const factory _PayloadResponseLogin({required final String token}) =
      _$_PayloadResponseLogin;

  factory _PayloadResponseLogin.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseLogin.fromJson;

  @override
  String get token => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseLoginCopyWith<_$_PayloadResponseLogin> get copyWith =>
      throw _privateConstructorUsedError;
}
