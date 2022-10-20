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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestUpdatePersonalInformation
    _$PayloadRequestUpdatePersonalInformationFromJson(
        Map<String, dynamic> json) {
  return _PayloadRequestUpdatePersonalInformation.fromJson(json);
}

/// @nodoc
mixin _$PayloadRequestUpdatePersonalInformation {
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;

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
  $Res call({String fullName, String phoneNumber, Address? address});
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
              as Address?,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadRequestUpdatePersonalInformationCopyWith<$Res>
    implements $PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  factory _$$_PayloadRequestUpdatePersonalInformationCopyWith(
          _$_PayloadRequestUpdatePersonalInformation value,
          $Res Function(_$_PayloadRequestUpdatePersonalInformation) then) =
      __$$_PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>;
  @override
  $Res call({String fullName, String phoneNumber, Address? address});
}

/// @nodoc
class __$$_PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>
    extends _$PayloadRequestUpdatePersonalInformationCopyWithImpl<$Res>
    implements _$$_PayloadRequestUpdatePersonalInformationCopyWith<$Res> {
  __$$_PayloadRequestUpdatePersonalInformationCopyWithImpl(
      _$_PayloadRequestUpdatePersonalInformation _value,
      $Res Function(_$_PayloadRequestUpdatePersonalInformation) _then)
      : super(_value,
            (v) => _then(v as _$_PayloadRequestUpdatePersonalInformation));

  @override
  _$_PayloadRequestUpdatePersonalInformation get _value =>
      super._value as _$_PayloadRequestUpdatePersonalInformation;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? address = freezed,
  }) {
    return _then(_$_PayloadRequestUpdatePersonalInformation(
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
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestUpdatePersonalInformation
    implements _PayloadRequestUpdatePersonalInformation {
  _$_PayloadRequestUpdatePersonalInformation(
      {required this.fullName, required this.phoneNumber, this.address});

  factory _$_PayloadRequestUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadRequestUpdatePersonalInformationFromJson(json);

  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final Address? address;

  @override
  String toString() {
    return 'PayloadRequestUpdatePersonalInformation(fullName: $fullName, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadRequestUpdatePersonalInformation &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.address, address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(address));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadRequestUpdatePersonalInformationCopyWith<
          _$_PayloadRequestUpdatePersonalInformation>
      get copyWith => __$$_PayloadRequestUpdatePersonalInformationCopyWithImpl<
          _$_PayloadRequestUpdatePersonalInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestUpdatePersonalInformationToJson(this);
  }
}

abstract class _PayloadRequestUpdatePersonalInformation
    implements PayloadRequestUpdatePersonalInformation {
  factory _PayloadRequestUpdatePersonalInformation(
      {required final String fullName,
      required final String phoneNumber,
      final Address? address}) = _$_PayloadRequestUpdatePersonalInformation;

  factory _PayloadRequestUpdatePersonalInformation.fromJson(
          Map<String, dynamic> json) =
      _$_PayloadRequestUpdatePersonalInformation.fromJson;

  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get phoneNumber => throw _privateConstructorUsedError;
  @override
  Address? get address => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadRequestUpdatePersonalInformationCopyWith<
          _$_PayloadRequestUpdatePersonalInformation>
      get copyWith => throw _privateConstructorUsedError;
}
