// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PayloadResponseListConversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PayloadResponseListConversation _$PayloadResponseListConversationFromJson(
    Map<String, dynamic> json) {
  return _PayloadResponseListConversation.fromJson(json);
}

/// @nodoc
mixin _$PayloadResponseListConversation {
  ChatWith? get chatWith => throw _privateConstructorUsedError;
  ChatWith? get chatFrom => throw _privateConstructorUsedError;
  ChatWith? get chatTo => throw _privateConstructorUsedError;
  String? get lastChat => throw _privateConstructorUsedError;
  String? get timeChat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayloadResponseListConversationCopyWith<PayloadResponseListConversation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadResponseListConversationCopyWith<$Res> {
  factory $PayloadResponseListConversationCopyWith(
          PayloadResponseListConversation value,
          $Res Function(PayloadResponseListConversation) then) =
      _$PayloadResponseListConversationCopyWithImpl<$Res>;
  $Res call(
      {ChatWith? chatWith,
      ChatWith? chatFrom,
      ChatWith? chatTo,
      String? lastChat,
      String? timeChat});
}

/// @nodoc
class _$PayloadResponseListConversationCopyWithImpl<$Res>
    implements $PayloadResponseListConversationCopyWith<$Res> {
  _$PayloadResponseListConversationCopyWithImpl(this._value, this._then);

  final PayloadResponseListConversation _value;
  // ignore: unused_field
  final $Res Function(PayloadResponseListConversation) _then;

  @override
  $Res call({
    Object? chatWith = freezed,
    Object? chatFrom = freezed,
    Object? chatTo = freezed,
    Object? lastChat = freezed,
    Object? timeChat = freezed,
  }) {
    return _then(_value.copyWith(
      chatWith: chatWith == freezed
          ? _value.chatWith
          : chatWith // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      chatFrom: chatFrom == freezed
          ? _value.chatFrom
          : chatFrom // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      chatTo: chatTo == freezed
          ? _value.chatTo
          : chatTo // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      lastChat: lastChat == freezed
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String?,
      timeChat: timeChat == freezed
          ? _value.timeChat
          : timeChat // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_PayloadResponseListConversationCopyWith<$Res>
    implements $PayloadResponseListConversationCopyWith<$Res> {
  factory _$$_PayloadResponseListConversationCopyWith(
          _$_PayloadResponseListConversation value,
          $Res Function(_$_PayloadResponseListConversation) then) =
      __$$_PayloadResponseListConversationCopyWithImpl<$Res>;
  @override
  $Res call(
      {ChatWith? chatWith,
      ChatWith? chatFrom,
      ChatWith? chatTo,
      String? lastChat,
      String? timeChat});
}

/// @nodoc
class __$$_PayloadResponseListConversationCopyWithImpl<$Res>
    extends _$PayloadResponseListConversationCopyWithImpl<$Res>
    implements _$$_PayloadResponseListConversationCopyWith<$Res> {
  __$$_PayloadResponseListConversationCopyWithImpl(
      _$_PayloadResponseListConversation _value,
      $Res Function(_$_PayloadResponseListConversation) _then)
      : super(_value, (v) => _then(v as _$_PayloadResponseListConversation));

  @override
  _$_PayloadResponseListConversation get _value =>
      super._value as _$_PayloadResponseListConversation;

  @override
  $Res call({
    Object? chatWith = freezed,
    Object? chatFrom = freezed,
    Object? chatTo = freezed,
    Object? lastChat = freezed,
    Object? timeChat = freezed,
  }) {
    return _then(_$_PayloadResponseListConversation(
      chatWith: chatWith == freezed
          ? _value.chatWith
          : chatWith // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      chatFrom: chatFrom == freezed
          ? _value.chatFrom
          : chatFrom // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      chatTo: chatTo == freezed
          ? _value.chatTo
          : chatTo // ignore: cast_nullable_to_non_nullable
              as ChatWith?,
      lastChat: lastChat == freezed
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String?,
      timeChat: timeChat == freezed
          ? _value.timeChat
          : timeChat // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PayloadResponseListConversation
    implements _PayloadResponseListConversation {
  const _$_PayloadResponseListConversation(
      {this.chatWith,
      this.chatFrom,
      this.chatTo,
      this.lastChat,
      this.timeChat});

  factory _$_PayloadResponseListConversation.fromJson(
          Map<String, dynamic> json) =>
      _$$_PayloadResponseListConversationFromJson(json);

  @override
  final ChatWith? chatWith;
  @override
  final ChatWith? chatFrom;
  @override
  final ChatWith? chatTo;
  @override
  final String? lastChat;
  @override
  final String? timeChat;

  @override
  String toString() {
    return 'PayloadResponseListConversation(chatWith: $chatWith, chatFrom: $chatFrom, chatTo: $chatTo, lastChat: $lastChat, timeChat: $timeChat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayloadResponseListConversation &&
            const DeepCollectionEquality().equals(other.chatWith, chatWith) &&
            const DeepCollectionEquality().equals(other.chatFrom, chatFrom) &&
            const DeepCollectionEquality().equals(other.chatTo, chatTo) &&
            const DeepCollectionEquality().equals(other.lastChat, lastChat) &&
            const DeepCollectionEquality().equals(other.timeChat, timeChat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chatWith),
      const DeepCollectionEquality().hash(chatFrom),
      const DeepCollectionEquality().hash(chatTo),
      const DeepCollectionEquality().hash(lastChat),
      const DeepCollectionEquality().hash(timeChat));

  @JsonKey(ignore: true)
  @override
  _$$_PayloadResponseListConversationCopyWith<
          _$_PayloadResponseListConversation>
      get copyWith => __$$_PayloadResponseListConversationCopyWithImpl<
          _$_PayloadResponseListConversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayloadResponseListConversationToJson(this);
  }
}

abstract class _PayloadResponseListConversation
    implements PayloadResponseListConversation {
  const factory _PayloadResponseListConversation(
      {final ChatWith? chatWith,
      final ChatWith? chatFrom,
      final ChatWith? chatTo,
      final String? lastChat,
      final String? timeChat}) = _$_PayloadResponseListConversation;

  factory _PayloadResponseListConversation.fromJson(Map<String, dynamic> json) =
      _$_PayloadResponseListConversation.fromJson;

  @override
  ChatWith? get chatWith => throw _privateConstructorUsedError;
  @override
  ChatWith? get chatFrom => throw _privateConstructorUsedError;
  @override
  ChatWith? get chatTo => throw _privateConstructorUsedError;
  @override
  String? get lastChat => throw _privateConstructorUsedError;
  @override
  String? get timeChat => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PayloadResponseListConversationCopyWith<
          _$_PayloadResponseListConversation>
      get copyWith => throw _privateConstructorUsedError;
}
