// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseProfile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseProfile _$PayloadResponseProfileFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseProfile.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseProfile {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isVerify => throw _privateConstructorUsedError;
  Profile get profile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseProfileCopyWith<PayloadResponseProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseProfileCopyWith<$Res> {
  factory $PayloadResponseProfileCopyWith(PayloadResponseProfile value,
          $Res Function(PayloadResponseProfile) then) =
      _$PayloadResponseProfileCopyWithImpl<$Res>;
  $Res call({String fullName, String email, bool isVerify, Profile profile});
}

/// @nodoc
class _$PayloadResponseProfileCopyWithImpl<$Res>
    implements $PayloadResponseProfileCopyWith<$Res> {
  _$PayloadResponseProfileCopyWithImpl(this._value, this._then);

  final PayloadResponseProfile _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseProfile) _then;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? email = freezed,
    Object? isVerify = freezed,
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isVerify: isVerify == freezed
          ? _value.isVerify
          : isVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadResponseProfileCopyWith<$Res>
    implements $PayloadResponseProfileCopyWith<$Res> {
  factory _$$_PayloadResponseProfileCopyWith(_$_PayloadResponseProfile value,
          $Res Function(_$_PayloadResponseProfile) then) =
      __$$_PayloadResponseProfileCopyWithImpl<$Res>;
  @override
  $Res call({String fullName, String email, bool isVerify, Profile profile});
}

/// @nodoc
class __$$_PayloadResponseProfileCopyWithImpl<$Res>
    extends _$PayloadResponseProfileCopyWithImpl<$Res>
    implements _$$_PayloadResponseProfileCopyWith<$Res> {
  __$$_PayloadResponseProfileCopyWithImpl(_$_PayloadResponseProfile _value,
      $Res Function(_$_PayloadResponseProfile) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseProfile));

  @override
  _$_PayloadResponseProfile get _value =>
      super._value as _$_PayloadResponseProfile;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? email = freezed,
    Object? isVerify = freezed,
    Object? profile = freezed,
  }) {
    return _then(_$_PayloadResponseProfile(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isVerify: isVerify == freezed
          ? _value.isVerify
          : isVerify // ignore: cast_nullable_to_non_nullable
              as bool,
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseProfile implements _PayloadResponseProfile {
  const _$_PayloadResponseProfile(
      {required this.fullName,
      required this.email,
      required this.isVerify,
      required this.profile});

  factory _$_PayloadResponseProfile.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseProfileFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  final bool isVerify;
  @override
  final Profile profile;

  @override
  String toString() {
    return 'PayloadResponseProfile(fullName: $fullName, email: $email, isVerify: $isVerify, profile: $profile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseProfile &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.isVerify, isVerify) &&
            const DeepCollectionEquality().equals(other.profile, profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(isVerify),
      const DeepCollectionEquality().hash(profile));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseProfileCopyWith<_$_PayloadResponseProfile> get copyWith =>
      __$$_PayloadResponseProfileCopyWithImpl<_$_PayloadResponseProfile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseProfileToJson(this);
  }
}

abstract class _PayloadResponseProfile implements PayloadResponseProfile {
  const factory _PayloadResponseProfile(
      {required final String fullName,
      required final String email,
      required final bool isVerify,
      required final Profile profile}) = _$_PayloadResponseProfile;

  factory _PayloadResponseProfile.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseProfile.fromJson;

  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  bool get isVerify => throw _privateConstructorUsedError;
  @override
  Profile get profile => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseProfileCopyWith<_$_PayloadResponseProfile> get copyWith =>
      throw _privateConstructorUsedError;
}
