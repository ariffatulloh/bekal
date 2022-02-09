// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseUpdatePersonalInformation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseUpdatePersonalInformation
    _$PayloadResponseUpdatePersonalInformationFromJson(
        Map<String, dynamic> json) {
  return _PayloadResponseUpdatePersonalInformation.fromJson(json);
}

/// @nodoc
class _$PayloadResponseUpdatePersonalInformationTearOff {
  const _$PayloadResponseUpdatePersonalInformationTearOff();

  _PayloadResponseUpdatePersonalInformation call(
      {required String fullName,
      required String phoneNumber,
      required String address}) {
    return _PayloadResponseUpdatePersonalInformation(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  PayloadResponseUpdatePersonalInformation fromJson(Map<String, Object?> json) {
    return PayloadResponseUpdatePersonalInformation.fromJson(json);
  }
}

/// @nodoc
const $PayloadResponseUpdatePersonalInformation =
    _$PayloadResponseUpdatePersonalInformationTearOff();

/// @nodoc
mixin _$PayloadResponseUpdatePersonalInformation {
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseUpdatePersonalInformationCopyWith<
          PayloadResponseUpdatePersonalInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseUpdatePersonalInformationCopyWith<$Res> {
  factory $PayloadResponseUpdatePersonalInformationCopyWith(
          PayloadResponseUpdatePersonalInformation value,
          $Res Function(PayloadResponseUpdatePersonalInformation) then) =
      _$PayloadResponseUpdatePersonalInformationCopyWithImpl<$Res>;
  $Res call({String fullName, String phoneNumber, String address});
}

/// @nodoc
class _$PayloadResponseUpdatePersonalInformationCopyWithImpl<$Res>
    implements $PayloadResponseUpdatePersonalInformationCopyWith<$Res> {
  _$PayloadResponseUpdatePersonalInformationCopyWithImpl(
      this._value, this._then);

  final PayloadResponseUpdatePersonalInformation _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseUpdatePersonalInformation) _then;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PayloadResponseUpdatePersonalInformationCopyWith<$Res>
    implements $PayloadResponseUpdatePersonalInformationCopyWith<$Res> {
  factory _$PayloadResponseUpdatePersonalInformationCopyWith(
          _PayloadResponseUpdatePersonalInformation value,
          $Res Function(_PayloadResponseUpdatePersonalInformation) then) =
      __$PayloadResponseUpdatePersonalInformationCopyWithImpl<$Res>;
  @override
  $Res call({String fullName, String phoneNumber, String address});
}

/// @nodoc
class __$PayloadResponseUpdatePersonalInformationCopyWithImpl<$Res>
    extends _$PayloadResponseUpdatePersonalInformationCopyWithImpl<$Res>
    implements _$PayloadResponseUpdatePersonalInformationCopyWith<$Res> {
  __$PayloadResponseUpdatePersonalInformationCopyWithImpl(
      _PayloadResponseUpdatePersonalInformation _value,
      $Res Function(_PayloadResponseUpdatePersonalInformation) _then)
      : super(_value,
            (v) => _then(v as _PayloadResponseUpdatePersonalInformation));

  @override
  _PayloadResponseUpdatePersonalInformation get _value =>
      super._value as _PayloadResponseUpdatePersonalInformation;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_PayloadResponseUpdatePersonalInformation(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseUpdatePersonalInformation
    implements _PayloadResponseUpdatePersonalInformation {
  const _$_PayloadResponseUpdatePersonalInformation(
      {required this.fullName,
      required this.phoneNumber,
      required this.address});

  factory _$_PayloadResponseUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadResponseUpdatePersonalInformationFromJson(json);

  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String address;

  @override
  String toString() {
    return 'PayloadResponseUpdatePersonalInformation(fullName: $fullName, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadResponseUpdatePersonalInformation &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.address, address));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(address));

  @JsonKey(ignore: true)
  @override
  _$PayloadResponseUpdatePersonalInformationCopyWith<
          _PayloadResponseUpdatePersonalInformation>
      get copyWith => __$PayloadResponseUpdatePersonalInformationCopyWithImpl<
          _PayloadResponseUpdatePersonalInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseUpdatePersonalInformationToJson(this);
  }
}

abstract class _PayloadResponseUpdatePersonalInformation
    implements PayloadResponseUpdatePersonalInformation {
  const factory _PayloadResponseUpdatePersonalInformation(
      {required String fullName,
      required String phoneNumber,
      required String address}) = _$_PayloadResponseUpdatePersonalInformation;

  factory _PayloadResponseUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =
      _$_PayloadResponseUpdatePersonalInformation.fromJson;

  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$PayloadResponseUpdatePersonalInformationCopyWith<
          _PayloadResponseUpdatePersonalInformation>
      get copyWith => throw _privateConstructorUsedError;
}
