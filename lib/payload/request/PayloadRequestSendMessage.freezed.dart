// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadRequestSendMessage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadRequestSendMessage _$PayloadRequestSendMessageFromJson(
    Map<String, dynamic> json) {
  return _PayloadRequestSendMessage.fromJson(json);
}

/// @nodoc
class _$PayloadRequestSendMessageTearOff {
  const _$PayloadRequestSendMessageTearOff();

  _PayloadRequestSendMessage call(
      {String? message, int? toUser, int? toStore}) {
    return _PayloadRequestSendMessage(
      message: message,
      toUser: toUser,
      toStore: toStore,
    );
  }

  PayloadRequestSendMessage fromJson(Map<String, Object?> json) {
    return PayloadRequestSendMessage.fromJson(json);
  }
}

/// @nodoc
const $PayloadRequestSendMessage = _$PayloadRequestSendMessageTearOff();

/// @nodoc
mixin _$PayloadRequestSendMessage {
  String? get message => throw _privateConstructorUsedError;
  int? get toUser => throw _privateConstructorUsedError;
  int? get toStore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadRequestSendMessageCopyWith<PayloadRequestSendMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadRequestSendMessageCopyWith<$Res> {
  factory $PayloadRequestSendMessageCopyWith(PayloadRequestSendMessage value,
          $Res Function(PayloadRequestSendMessage) then) =
      _$PayloadRequestSendMessageCopyWithImpl<$Res>;
  $Res call({String? message, int? toUser, int? toStore});
}

/// @nodoc
class _$PayloadRequestSendMessageCopyWithImpl<$Res>
    implements $PayloadRequestSendMessageCopyWith<$Res> {
  _$PayloadRequestSendMessageCopyWithImpl(this._value, this._then);

  final PayloadRequestSendMessage _value;
  // ignore: unused_field
  final $Res Function(PayloadRequestSendMessage) _then;

  @override
  $Res call({
    Object? message = freezed,
    Object? toUser = freezed,
    Object? toStore = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      toUser: toUser == freezed
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as int?,
      toStore: toStore == freezed
          ? _value.toStore
          : toStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$PayloadRequestSendMessageCopyWith<$Res>
    implements $PayloadRequestSendMessageCopyWith<$Res> {
  factory _$PayloadRequestSendMessageCopyWith(_PayloadRequestSendMessage value,
          $Res Function(_PayloadRequestSendMessage) then) =
      __$PayloadRequestSendMessageCopyWithImpl<$Res>;
  @override
  $Res call({String? message, int? toUser, int? toStore});
}

/// @nodoc
class __$PayloadRequestSendMessageCopyWithImpl<$Res>
    extends _$PayloadRequestSendMessageCopyWithImpl<$Res>
    implements _$PayloadRequestSendMessageCopyWith<$Res> {
  __$PayloadRequestSendMessageCopyWithImpl(_PayloadRequestSendMessage _value,
      $Res Function(_PayloadRequestSendMessage) _then)
      : super(_value, (v) => _then(v as _PayloadRequestSendMessage));

  @override
  _PayloadRequestSendMessage get _value =>
      super._value as _PayloadRequestSendMessage;

  @override
  $Res call({
    Object? message = freezed,
    Object? toUser = freezed,
    Object? toStore = freezed,
  }) {
    return _then(_PayloadRequestSendMessage(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      toUser: toUser == freezed
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as int?,
      toStore: toStore == freezed
          ? _value.toStore
          : toStore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadRequestSendMessage implements _PayloadRequestSendMessage {
  const _$_PayloadRequestSendMessage({this.message, this.toUser, this.toStore});

  factory _$_PayloadRequestSendMessage.fromJson(Map<String, dynamic> json) =>
      _$$_PayloadRequestSendMessageFromJson(json);

  @override
  final String? message;
  @override
  final int? toUser;
  @override
  final int? toStore;

  @override
  String toString() {
    return 'PayloadRequestSendMessage(message: $message, toUser: $toUser, toStore: $toStore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PayloadRequestSendMessage &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.toUser, toUser) &&
            const DeepCollectionEquality().equals(other.toStore, toStore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(toUser),
      const DeepCollectionEquality().hash(toStore));

  @JsonKey(ignore: true)
  @override
  _$PayloadRequestSendMessageCopyWith<_PayloadRequestSendMessage>
      get copyWith =>
          __$PayloadRequestSendMessageCopyWithImpl<_PayloadRequestSendMessage>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadRequestSendMessageToJson(this);
  }
}

abstract class _PayloadRequestSendMessage implements PayloadRequestSendMessage {
  const factory _PayloadRequestSendMessage(
      {String? message,
      int? toUser,
      int? toStore}) = _$_PayloadRequestSendMessage;

  factory _PayloadRequestSendMessage.fromJson(Map<String, dynamic> json) =
      _$_PayloadRequestSendMessage.fromJson;

  @override
  String? get message;
  @override
  int? get toUser;
  @override
  int? get toStore;
  @override
  @JsonKey(ignore: true)
  _$PayloadRequestSendMessageCopyWith<_PayloadRequestSendMessage>
      get copyWith => throw _privateConstructorUsedError;
}
