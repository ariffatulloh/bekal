import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadResponseListConversation.freezed.dart';
part 'PayloadResponseListConversation.g.dart';

@freezed
class PayloadResponseListConversation with _$PayloadResponseListConversation {
  const factory PayloadResponseListConversation({
    ChatWith? chatWith,
    ChatWith? chatFrom,
    ChatWith? chatTo,
    String? lastChat,
    String? timeChat,
  }) = _PayloadResponseListConversation;

  factory PayloadResponseListConversation.fromJson(Object? json) =>
      _$PayloadResponseListConversationFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseListConversation data) =>

}

@JsonSerializable()
class ChatWith {
  String? fullName;
  int? id;
  String? image;
  String? userOrStore;

  ChatWith({
    this.fullName,
    this.image,
    this.id,
    this.userOrStore,
  });
  factory ChatWith.fromJson(Map<String, dynamic> json) =>
      _$ChatWithFromJson(json);
}
