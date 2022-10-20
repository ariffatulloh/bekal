// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseUpdateEmail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseUpdateEmail _$PayloadResponseUpdateEmailFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseUpdateEmail.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseUpdateEmail {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseUpdateEmailCopyWith<PayloadResponseUpdateEmail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseUpdateEmailCopyWith<$Res> {
  factory $PayloadResponseUpdateEmailCopyWith(PayloadResponseUpdateEmail value,
          $Res Function(PayloadResponseUpdateEmail) then) =
      _$PayloadResponseUpdateEmailCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$PayloadResponseUpdateEmailCopyWithImpl<$Res>
    implements $PayloadResponseUpdateEmailCopyWith<$Res> {
  _$PayloadResponseUpdateEmailCopyWithImpl(this._value, this._then);

  final PayloadResponseUpdateEmail _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseUpdateEmail) _then;

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
abstract class _$$_PayloadResponseUpdateEmailCopyWith<$Res>
    implements $PayloadResponseUpdateEmailCopyWith<$Res> {
  factory _$$_PayloadResponseUpdateEmailCopyWith(
          _$_PayloadResponseUpdateEmail value,
          $Res Function(_$_PayloadResponseUpdateEmail) then) =
      __$$_PayloadResponseUpdateEmailCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$$_PayloadResponseUpdateEmailCopyWithImpl<$Res>
    extends _$PayloadResponseUpdateEmailCopyWithImpl<$Res>
    implements _$$_PayloadResponseUpdateEmailCopyWith<$Res> {
  __$$_PayloadResponseUpdateEmailCopyWithImpl(
      _$_PayloadResponseUpdateEmail _value,
      $Res Function(_$_PayloadResponseUpdateEmail) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseUpdateEmail));

  @override
  _$_PayloadResponseUpdateEmail get _value =>
      super._value as _$_PayloadResponseUpdateEmail;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_PayloadResponseUpdateEmail(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseUpdateEmail implements _PayloadResponseUpdateEmail {
  const _$_PayloadResponseUpdateEmail({required this.message});

  factory _$_PayloadResponseUpdateEmail.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseUpdateEmailFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'PayloadResponseUpdateEmail(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseUpdateEmail &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseUpdateEmailCopyWith<_$_PayloadResponseUpdateEmail>
      get copyWith => __$$_PayloadResponseUpdateEmailCopyWithImpl<
          _$_PayloadResponseUpdateEmail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseUpdateEmailToJson(this);
  }
}

abstract class _PayloadResponseUpdateEmail
    implements PayloadResponseUpdateEmail {
  const factory _PayloadResponseUpdateEmail({required final String message}) =
      _$_PayloadResponseUpdateEmail;

  factory _PayloadResponseUpdateEmail.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseUpdateEmail.fromJson;

  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseUpdateEmailCopyWith<_$_PayloadResponseUpdateEmail>
      get copyWith => throw _privateConstructorUsedError;
}
