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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestUpdateEmail _$PayloadRequestUpdateEmailFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestUpdateEmail.fromJson(json);
}

/// @nodoc
class _$PayloadRequestUpdateEmailTearOff {
  const _$PayloadRequestUpdateEmailTearOff();

  _PayloadRequestUpdateEmail call(
      {required String existingEmail, required String newEmail}) {
    return _PayloadRequestUpdateEmail(
      existingEmail: existingEmail,
      newEmail: newEmail,
    );
  }

  PayloadRequestUpdateEmail fromJson(Map<String, Object?> json) {
    return PayloadRequestUpdateEmail.fromJson(json);
  }
}

/// @nodoc
const $PayloadRequestUpdateEmail = _$PayloadRequestUpdateEmailTearOff();

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
abstract class _$PayloadRequestUpdateEmailCopyWith<$Res>
    implements $PayloadRequestUpdateEmailCopyWith<$Res> {
  factory _$PayloadRequestUpdateEmailCopyWith(_PayloadRequestUpdateEmail value,
          $Res Function(_PayloadRequestUpdateEmail) then) =
      __$PayloadRequestUpdateEmailCopyWithImpl<$Res>;
  @override
  $Res call({String existingEmail, String newEmail});
}

/// @nodoc
class __$PayloadRequestUpdateEmailCopyWithImpl<$Res>
    extends _$PayloadRequestUpdateEmailCopyWithImpl<$Res>
    implements _$PayloadRequestUpdateEmailCopyWith<$Res> {
  __$PayloadRequestUpdateEmailCopyWithImpl(_PayloadRequestUpdateEmail _value,
      $Res Function(_PayloadRequestUpdateEmail) _then)
      : super(_value, (v) => _then(v as _PayloadRequestUpdateEmail));

  @override
  _PayloadRequestUpdateEmail get _value =>
      super._value as _PayloadRequestUpdateEmail;

  @override
  $Res call({
    Object? existingEmail = freezed,
    Object? newEmail = freezed,
  }) {
    return _then(_PayloadRequestUpdateEmail(
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
            other is _PayloadRequestUpdateEmail &&
            const DeepCollectionEquality()
                .equals(other.existingEmail, existingEmail) &&
            const DeepCollectionEquality().equals(other.newEmail, newEmail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(existingEmail),
      const DeepCollectionEquality().hash(newEmail));

  @JsonKey(ignore: true)
  @override
  _$PayloadRequestUpdateEmailCopyWith<_PayloadRequestUpdateEmail>
      get copyWith =>
          __$PayloadRequestUpdateEmailCopyWithImpl<_PayloadRequestUpdateEmail>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestUpdateEmailToJson(this);
  }
}

abstract class _PayloadRequestUpdateEmail implements PayloadRequestUpdateEmail {
  const factory _PayloadRequestUpdateEmail(
      {required String existingEmail,
      required String newEmail}) = _$_PayloadRequestUpdateEmail;

  factory _PayloadRequestUpdateEmail.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestUpdateEmail.fromJson;

  @override
  String get existingEmail;
  @override
  String get newEmail;
  @override
  @JsonKey(ignore: true)
  _$PayloadRequestUpdateEmailCopyWith<_PayloadRequestUpdateEmail>
      get copyWith => throw _privateConstructorUsedError;
}
