// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseVerification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseVerification _$PayloadResponseVerificationFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseVerification.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseVerification {
  String get email => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseVerificationCopyWith<PayloadResponseVerification>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseVerificationCopyWith<$Res> {
  factory $PayloadResponseVerificationCopyWith(
          PayloadResponseVerification value,
          $Res Function(PayloadResponseVerification) then) =
      _$PayloadResponseVerificationCopyWithImpl<$Res>;
  $Res call({String email, String message});
}

/// @nodoc
class _$PayloadResponseVerificationCopyWithImpl<$Res>
    implements $PayloadResponseVerificationCopyWith<$Res> {
  _$PayloadResponseVerificationCopyWithImpl(this._value, this._then);

  final PayloadResponseVerification _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseVerification) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadResponseVerificationCopyWith<$Res>
    implements $PayloadResponseVerificationCopyWith<$Res> {
  factory _$$_PayloadResponseVerificationCopyWith(
          _$_PayloadResponseVerification value,
          $Res Function(_$_PayloadResponseVerification) then) =
      __$$_PayloadResponseVerificationCopyWithImpl<$Res>;
  @override
  $Res call({String email, String message});
}

/// @nodoc
class __$$_PayloadResponseVerificationCopyWithImpl<$Res>
    extends _$PayloadResponseVerificationCopyWithImpl<$Res>
    implements _$$_PayloadResponseVerificationCopyWith<$Res> {
  __$$_PayloadResponseVerificationCopyWithImpl(
      _$_PayloadResponseVerification _value,
      $Res Function(_$_PayloadResponseVerification) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseVerification));

  @override
  _$_PayloadResponseVerification get _value =>
      super._value as _$_PayloadResponseVerification;

  @override
  $Res call({
    Object? email = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_PayloadResponseVerification(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseVerification implements _PayloadResponseVerification {
  const _$_PayloadResponseVerification(
      {required this.email, required this.message});

  factory _$_PayloadResponseVerification.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseVerificationFromJson(json);

  @override
  final String email;
  @override
  final String message;

  @override
  String toString() {
    return 'PayloadResponseVerification(email: $email, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseVerification &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseVerificationCopyWith<_$_PayloadResponseVerification>
      get copyWith => __$$_PayloadResponseVerificationCopyWithImpl<
          _$_PayloadResponseVerification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseVerificationToJson(this);
  }
}

abstract class _PayloadResponseVerification
    implements PayloadResponseVerification {
  const factory _PayloadResponseVerification(
      {required final String email,
      required final String message}) = _$_PayloadResponseVerification;

  factory _PayloadResponseVerification.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseVerification.fromJson;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseVerificationCopyWith<_$_PayloadResponseVerification>
      get copyWith => throw _privateConstructorUsedError;
}
