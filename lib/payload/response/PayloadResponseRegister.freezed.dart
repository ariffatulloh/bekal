// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseRegister.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseRegister _$PayloadResponseRegisterFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseRegister.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseRegister {
  bool get registrationSukses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseRegisterCopyWith<PayloadResponseRegister> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseRegisterCopyWith<$Res> {
  factory $PayloadResponseRegisterCopyWith(PayloadResponseRegister value,
          $Res Function(PayloadResponseRegister) then) =
      _$PayloadResponseRegisterCopyWithImpl<$Res>;
  $Res call({bool registrationSukses});
}

/// @nodoc
class _$PayloadResponseRegisterCopyWithImpl<$Res>
    implements $PayloadResponseRegisterCopyWith<$Res> {
  _$PayloadResponseRegisterCopyWithImpl(this._value, this._then);

  final PayloadResponseRegister _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseRegister) _then;

  @override
  $Res call({
    Object? registrationSukses = freezed,
  }) {
    return _then(_value.copyWith(
      registrationSukses: registrationSukses == freezed
          ? _value.registrationSukses
          : registrationSukses // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadResponseRegisterCopyWith<$Res>
    implements $PayloadResponseRegisterCopyWith<$Res> {
  factory _$$_PayloadResponseRegisterCopyWith(_$_PayloadResponseRegister value,
          $Res Function(_$_PayloadResponseRegister) then) =
      __$$_PayloadResponseRegisterCopyWithImpl<$Res>;
  @override
  $Res call({bool registrationSukses});
}

/// @nodoc
class __$$_PayloadResponseRegisterCopyWithImpl<$Res>
    extends _$PayloadResponseRegisterCopyWithImpl<$Res>
    implements _$$_PayloadResponseRegisterCopyWith<$Res> {
  __$$_PayloadResponseRegisterCopyWithImpl(_$_PayloadResponseRegister _value,
      $Res Function(_$_PayloadResponseRegister) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseRegister));

  @override
  _$_PayloadResponseRegister get _value =>
      super._value as _$_PayloadResponseRegister;

  @override
  $Res call({
    Object? registrationSukses = freezed,
  }) {
    return _then(_$_PayloadResponseRegister(
      registrationSukses: registrationSukses == freezed
          ? _value.registrationSukses
          : registrationSukses // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseRegister implements _PayloadResponseRegister {
  const _$_PayloadResponseRegister({required this.registrationSukses});

  factory _$_PayloadResponseRegister.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadResponseRegisterFromJson(json);

  @override
  final bool registrationSukses;

  @override
  String toString() {
    return 'PayloadResponseRegister(registrationSukses: $registrationSukses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseRegister &&
            const DeepCollectionEquality()
                .equals(other.registrationSukses, registrationSukses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(registrationSukses));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseRegisterCopyWith<_$_PayloadResponseRegister>
      get copyWith =>
          __$$_PayloadResponseRegisterCopyWithImpl<_$_PayloadResponseRegister>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseRegisterToJson(this);
  }
}

abstract class _PayloadResponseRegister implements PayloadResponseRegister {
  const factory _PayloadResponseRegister(
      {required final bool registrationSukses}) = _$_PayloadResponseRegister;

  factory _PayloadResponseRegister.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseRegister.fromJson;

  @override
  bool get registrationSukses => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseRegisterCopyWith<_$_PayloadResponseRegister>
      get copyWith => throw _privateConstructorUsedError;
}
