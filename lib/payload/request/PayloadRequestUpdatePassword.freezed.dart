// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestUpdatePassword.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestUpdatePassword _$PayloadRequestUpdatePasswordFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestUpdatePassword.fromJson(json);
}

/// @nodoc
mixin _$PayloadRequestUpdatePassword {
  String get existingPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;
  String get rePassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestUpdatePasswordCopyWith<PayloadRequestUpdatePassword>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestUpdatePasswordCopyWith<$Res> {
  factory $PayloadRequestUpdatePasswordCopyWith(
          PayloadRequestUpdatePassword value,
          $Res Function(PayloadRequestUpdatePassword) then) =
      _$PayloadRequestUpdatePasswordCopyWithImpl<$Res>;
  $Res call({String existingPassword, String newPassword, String rePassword});
}

/// @nodoc
class _$PayloadRequestUpdatePasswordCopyWithImpl<$Res>
    implements $PayloadRequestUpdatePasswordCopyWith<$Res> {
  _$PayloadRequestUpdatePasswordCopyWithImpl(this._value, this._then);

  final PayloadRequestUpdatePassword _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestUpdatePassword) _then;

  @override
  $Res call({
    Object? existingPassword = freezed,
    Object? newPassword = freezed,
    Object? rePassword = freezed,
  }) {
    return _then(_value.copyWith(
      existingPassword: existingPassword == freezed
          ? _value.existingPassword
          : existingPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: newPassword == freezed
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      rePassword: rePassword == freezed
          ? _value.rePassword
          : rePassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadRequestUpdatePasswordCopyWith<$Res>
    implements $PayloadRequestUpdatePasswordCopyWith<$Res> {
  factory _$$_PayloadRequestUpdatePasswordCopyWith(
          _$_PayloadRequestUpdatePassword value,
          $Res Function(_$_PayloadRequestUpdatePassword) then) =
      __$$_PayloadRequestUpdatePasswordCopyWithImpl<$Res>;
  @override
  $Res call({String existingPassword, String newPassword, String rePassword});
}

/// @nodoc
class __$$_PayloadRequestUpdatePasswordCopyWithImpl<$Res>
    extends _$PayloadRequestUpdatePasswordCopyWithImpl<$Res>
    implements _$$_PayloadRequestUpdatePasswordCopyWith<$Res> {
  __$$_PayloadRequestUpdatePasswordCopyWithImpl(
      _$_PayloadRequestUpdatePassword _value,
      $Res Function(_$_PayloadRequestUpdatePassword) _then)
      : super(_value, (v) => _then(v as _$_PayloadRequestUpdatePassword));

  @override
  _$_PayloadRequestUpdatePassword get _value =>
      super._value as _$_PayloadRequestUpdatePassword;

  @override
  $Res call({
    Object? existingPassword = freezed,
    Object? newPassword = freezed,
    Object? rePassword = freezed,
  }) {
    return _then(_$_PayloadRequestUpdatePassword(
      existingPassword: existingPassword == freezed
          ? _value.existingPassword
          : existingPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: newPassword == freezed
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      rePassword: rePassword == freezed
          ? _value.rePassword
          : rePassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestUpdatePassword implements _PayloadRequestUpdatePassword {
  const _$_PayloadRequestUpdatePassword(
      {required this.existingPassword,
      required this.newPassword,
      required this.rePassword});

  factory _$_PayloadRequestUpdatePassword.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadRequestUpdatePasswordFromJson(json);

  @override
  final String existingPassword;
  @override
  final String newPassword;
  @override
  final String rePassword;

  @override
  String toString() {
    return 'PayloadRequestUpdatePassword(existingPassword: $existingPassword, newPassword: $newPassword, rePassword: $rePassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadRequestUpdatePassword &&
            const DeepCollectionEquality()
                .equals(other.existingPassword, existingPassword) &&
            const DeepCollectionEquality()
                .equals(other.newPassword, newPassword) &&
            const DeepCollectionEquality()
                .equals(other.rePassword, rePassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(existingPassword),
      const DeepCollectionEquality().hash(newPassword),
      const DeepCollectionEquality().hash(rePassword));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadRequestUpdatePasswordCopyWith<_$_PayloadRequestUpdatePassword>
      get copyWith => __$$_PayloadRequestUpdatePasswordCopyWithImpl<
          _$_PayloadRequestUpdatePassword>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestUpdatePasswordToJson(this);
  }
}

abstract class _PayloadRequestUpdatePassword
    implements PayloadRequestUpdatePassword {
  const factory _PayloadRequestUpdatePassword(
      {required final String existingPassword,
      required final String newPassword,
      required final String rePassword}) = _$_PayloadRequestUpdatePassword;

  factory _PayloadRequestUpdatePassword.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestUpdatePassword.fromJson;

  @override
  String get existingPassword => throw _privateConstructorUsedError;
  @override
  String get newPassword => throw _privateConstructorUsedError;
  @override
  String get rePassword => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadRequestUpdatePasswordCopyWith<_$_PayloadRequestUpdatePassword>
      get copyWith => throw _privateConstructorUsedError;
}
