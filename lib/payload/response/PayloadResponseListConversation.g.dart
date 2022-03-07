// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayloadResponseListConversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatWith _$ChatWithFromJson(Map<String, dynamic> json) => ChatWith(
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      id: json['id'] as int?,
      userOrStore: json['userOrStore'] as String?,
    );

Map<String, dynamic> _$ChatWithToJson(ChatWith instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'id': instance.id,
      'image': instance.image,
      'userOrStore': instance.userOrStore,
    };

_$_PayloadResponseListConversation _$$_PayloadResponseListConversationFromJson(
        Map<String, dynamic> json) =>
    _$_PayloadResponseListConversation(
      chatWith: json['chatWith'] == null
          ? null
          : ChatWith.fromJson(json['chatWith'] as Map<String, dynamic>),
      chatFrom: json['chatFrom'] == null
          ? null
          : ChatWith.fromJson(json['chatFrom'] as Map<String, dynamic>),
      chatTo: json['chatTo'] == null
          ? null
          : ChatWith.fromJson(json['chatTo'] as Map<String, dynamic>),
      lastChat: json['lastChat'] as String?,
      timeChat: json['timeChat'] as String?,
    );

Map<String, dynamic> _$$_PayloadResponseListConversationToJson(
        _$_PayloadResponseListConversation instance) =>
    <String, dynamic>{
      'chatWith': instance.chatWith,
      'chatFrom': instance.chatFrom,
      'chatTo': instance.chatTo,
      'lastChat': instance.lastChat,
      'timeChat': instance.timeChat,
    };
