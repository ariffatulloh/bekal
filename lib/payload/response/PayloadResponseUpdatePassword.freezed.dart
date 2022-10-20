// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseUpdatePassword.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseUpdatePassword _$PayloadResponseUpdatePasswordFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseUpdatePassword.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseUpdatePassword {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseUpdatePasswordCopyWith<PayloadResponseUpdatePassword>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseUpdatePasswordCopyWith<$Res> {
  factory $PayloadResponseUpdatePasswordCopyWith(
          PayloadResponseUpdatePassword value,
          $Res Function(PayloadResponseUpdatePassword) then) =
      _$PayloadResponseUpdatePasswordCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$PayloadResponseUpdatePasswordCopyWithImpl<$Res>
    implements $PayloadResponseUpdatePasswordCopyWith<$Res> {
  _$PayloadResponseUpdatePasswordCopyWithImpl(this._value, this._then);

  final PayloadResponseUpdatePassword _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseUpdatePassword) _then;

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
abstract class _$$_PayloadResponseUpdatePasswordCopyWith<$Res>
    implements $PayloadResponseUpdatePasswordCopyWith<$Res> {
  factory _$$_PayloadResponseUpdatePasswordCopyWith(
          _$_PayloadResponseUpdatePassword value,
          $Res Function(_$_PayloadResponseUpdatePassword) then) =
      __$$_PayloadResponseUpdatePasswordCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$$_PayloadResponseUpdatePasswordCopyWithImpl<$Res>
    extends _$PayloadResponseUpdatePasswordCopyWithImpl<$Res>
    implements _$$_PayloadResponseUpdatePasswordCopyWith<$Res> {
  __$$_PayloadResponseUpdatePasswordCopyWithImpl(
      _$_PayloadResponseUpdatePassword _value,
      $Res Function(_$_PayloadResponseUpdatePassword) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseUpdatePassword));

  @override
  _$_PayloadResponseUpdatePassword get _value =>
      super._value as _$_PayloadResponseUpdatePassword;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_PayloadResponseUpdatePassword(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseUpdatePassword
    implements _PayloadResponseUpdatePassword {
  const _$_PayloadResponseUpdatePassword({required this.message});

  factory _$_PayloadResponseUpdatePassword.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadResponseUpdatePasswordFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'PayloadResponseUpdatePassword(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseUpdatePassword &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseUpdatePasswordCopyWith<_$_PayloadResponseUpdatePassword>
      get copyWith => __$$_PayloadResponseUpdatePasswordCopyWithImpl<
          _$_PayloadResponseUpdatePassword>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseUpdatePasswordToJson(this);
  }
}

abstract class _PayloadResponseUpdatePassword
    implements PayloadResponseUpdatePassword {
  const factory _PayloadResponseUpdatePassword(
      {required final String message}) = _$_PayloadResponseUpdatePassword;

  factory _PayloadResponseUpdatePassword.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseUpdatePassword.fromJson;

  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseUpdatePasswordCopyWith<_$_PayloadResponseUpdatePassword>
      get copyWith => throw _privateConstructorUsedError;
}
