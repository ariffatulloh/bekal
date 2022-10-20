// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestUpdateEmail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestUpdateEmail _$PayloadRequestUpdateEmailFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestUpdateEmail.fromJson(json);
}

/// @nodoc
mixin _$PayloadRequestUpdateEmail {
  String get existingEmail => throw _privateConstructorUsedError;
  String get newEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestUpdateEmailCopyWith<PayloadRequestUpdateEmail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestUpdateEmailCopyWith<$Res> {
  factory $PayloadRequestUpdateEmailCopyWith(PayloadRequestUpdateEmail value,
          $Res Function(PayloadRequestUpdateEmail) then) =
      _$PayloadRequestUpdateEmailCopyWithImpl<$Res>;
  $Res call({String existingEmail, String newEmail});
}

/// @nodoc
class _$PayloadRequestUpdateEmailCopyWithImpl<$Res>
    implements $PayloadRequestUpdateEmailCopyWith<$Res> {
  _$PayloadRequestUpdateEmailCopyWithImpl(this._value, this._then);

  final PayloadRequestUpdateEmail _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestUpdateEmail) _then;

  @override
  $Res call({
    Object? existingEmail = freezed,
    Object? newEmail = freezed,
  }) {
    return _then(_value.copyWith(
      existingEmail: existingEmail == freezed
          ? _value.existingEmail
          : existingEmail // ignore: cast_nullable_to_non_nullable
              as String,
      newEmail: newEmail == freezed
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadRequestUpdateEmailCopyWith<$Res>
    implements $PayloadRequestUpdateEmailCopyWith<$Res> {
  factory _$$_PayloadRequestUpdateEmailCopyWith(
          _$_PayloadRequestUpdateEmail value,
          $Res Function(_$_PayloadRequestUpdateEmail) then) =
      __$$_PayloadRequestUpdateEmailCopyWithImpl<$Res>;
  @override
  $Res call({String existingEmail, String newEmail});
}

/// @nodoc
class __$$_PayloadRequestUpdateEmailCopyWithImpl<$Res>
    extends _$PayloadRequestUpdateEmailCopyWithImpl<$Res>
    implements _$$_PayloadRequestUpdateEmailCopyWith<$Res> {
  __$$_PayloadRequestUpdateEmailCopyWithImpl(
      _$_PayloadRequestUpdateEmail _value,
      $Res Function(_$_PayloadRequestUpdateEmail) _then)
      : super(_value, (v) => _then(v as _$_PayloadRequestUpdateEmail));

  @override
  _$_PayloadRequestUpdateEmail get _value =>
      super._value as _$_PayloadRequestUpdateEmail;

  @override
  $Res call({
    Object? existingEmail = freezed,
    Object? newEmail = freezed,
  }) {
    return _then(_$_PayloadRequestUpdateEmail(
      existingEmail: existingEmail == freezed
          ? _value.existingEmail
          : existingEmail // ignore: cast_nullable_to_non_nullable
              as String,
      newEmail: newEmail == freezed
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestUpdateEmail implements _PayloadRequestUpdateEmail {
  const _$_PayloadRequestUpdateEmail(
      {required this.existingEmail, required this.newEmail});

  factory _$_PayloadRequestUpdateEmail.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadRequestUpdateEmailFromJson(json);

  @override
  final String existingEmail;
  @override
  final String newEmail;

  @override
  String toString() {
    return 'PayloadRequestUpdateEmail(existingEmail: $existingEmail, newEmail: $newEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadRequestUpdateEmail &&
            const DeepCollectionEquality()
                .equals(other.existingEmail, existingEmail) &&
            const DeepCollectionEquality().equals(other.newEmail, newEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(existingEmail),
      const DeepCollectionEquality().hash(newEmail));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadRequestUpdateEmailCopyWith<_$_PayloadRequestUpdateEmail>
      get copyWith => __$$_PayloadRequestUpdateEmailCopyWithImpl<
          _$_PayloadRequestUpdateEmail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestUpdateEmailToJson(this);
  }
}

abstract class _PayloadRequestUpdateEmail implements PayloadRequestUpdateEmail {
  const factory _PayloadRequestUpdateEmail(
      {required final String existingEmail,
      required final String newEmail}) = _$_PayloadRequestUpdateEmail;

  factory _PayloadRequestUpdateEmail.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestUpdateEmail.fromJson;

  @override
  String get existingEmail => throw _privateConstructorUsedError;
  @override
  String get newEmail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadRequestUpdateEmailCopyWith<_$_PayloadRequestUpdateEmail>
      get copyWith => throw _privateConstructorUsedError;
}
