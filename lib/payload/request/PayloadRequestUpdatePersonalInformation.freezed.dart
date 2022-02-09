// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestUpdatePersonalInformation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestUpdatePersonalInformation
    _$PayloadRequestUpdatePersonalInformationFromJson(
        Map<String, dynamic> json) {
  return _PayloadRequestUpdatePersonalInformation.fromJson(json);
}

/// @nodoc
class _$PayloadRequestUpdatePersonalInformationTearOff {
  const _$PayloadRequestUpdatePersonalInformationTearOff();

  _PayloadRequestUpdatePersonalInformation call(
      {required String fullName,
      required String phoneNumber,
      required String address}) {
    return _PayloadRequestUpdatePersonalInformation(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  PayloadRequestUpdatePersonalInformation fromJson(Map<String, Object?> json) {
    return PayloadRequestUpdatePersonalInformation.fromJson(json);
  }
}

/// @nodoc
const $PayloadRequestUpdatePersonalInformation =
    _$PayloadRequestUpdatePersonalInformationTearOff();

/// @nodoc
mixin _$PayloadRequestUpdatePersonalInformation {
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestUpdatePersonalInformationCopyWith<
          PayloadRequestUpdatePersonalInformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  factory $PayloadRequestUpdatePersonalInformationCopyWith(
          PayloadRequestUpdatePersonalInformation value,
          $Res Function(PayloadRequestUpdatePersonalInformation) then) =
      _$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>;
  $Res call({String fullName, String phoneNumber, String address});
}

/// @nodoc
class _$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>
    implements $PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  _$PayloadRequestUpdatePersonalInformationCopyWithImpl(
      this._value, this._then);

  final PayloadRequestUpdatePersonalInformation _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestUpdatePersonalInformation) _then;

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
abstract class _$PayloadRequestUpdatePersonalInformationCopyWith<$Res>
    implements $PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  factory _$PayloadRequestUpdatePersonalInformationCopyWith(
          _PayloadRequestUpdatePersonalInformation value,
          $Res Function(_PayloadRequestUpdatePersonalInformation) then) =
      __$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>;
  @override
  $Res call({String fullName, String phoneNumber, String address});
}

/// @nodoc
class __$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>
    extends _$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>
    implements _$PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  __$PayloadRequestUpdatePersonalInformationCopyWithImpl(
      _PayloadRequestUpdatePersonalInformation _value,
      $Res Function(_PayloadRequestUpdatePersonalInformation) _then)
      : super(_value,
            (v) => _then(v as _PayloadRequestUpdatePersonalInformation));

  @override
  _PayloadRequestUpdatePersonalInformation get _value =>
      super._value as _PayloadRequestUpdatePersonalInformation;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_PayloadRequestUpdatePersonalInformation(
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
class _$_PayloadRequestUpdatePersonalInformation
    implements _PayloadRequestUpdatePersonalInformation {
  const _$_PayloadRequestUpdatePersonalInformation(
      {required this.fullName,
      required this.phoneNumber,
      required this.address});

  factory _$_PayloadRequestUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadRequestUpdatePersonalInformationFromJson(json);

  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String address;

  @override
  String toString() {
    return 'PayloadRequestUpdatePersonalInformation(fullName: $fullName, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadRequestUpdatePersonalInformation &&
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
  _$PayloadRequestUpdatePersonalInformationCopyWith<
          _PayloadRequestUpdatePersonalInformation>
      get copyWith => __$PayloadRequestUpdatePersonalInformationCopyWithImpl<
          _PayloadRequestUpdatePersonalInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestUpdatePersonalInformationToJson(this);
  }
}

abstract class _PayloadRequestUpdatePersonalInformation
    implements PayloadRequestUpdatePersonalInformation {
  const factory _PayloadRequestUpdatePersonalInformation(
      {required String fullName,
      required String phoneNumber,
      required String address}) = _$_PayloadRequestUpdatePersonalInformation;

  factory _PayloadRequestUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =
      _$_PayloadRequestUpdatePersonalInformation.fromJson;

  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$PayloadRequestUpdatePersonalInformationCopyWith<
          _PayloadRequestUpdatePersonalInformation>
      get copyWith => throw _privateConstructorUsedError;
}
