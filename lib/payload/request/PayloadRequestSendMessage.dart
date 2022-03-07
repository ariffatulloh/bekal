import 'package:freezed_annotation/freezed_annotation.dart';

part 'PayloadRequestSendMessage.freezed.dart';
part 'PayloadRequestSendMessage.g.dart';

@freezed
class PayloadRequestSendMessage with _$PayloadRequestSendMessage {
  const factory PayloadRequestSendMessage({
    String? message,
    int? toUser,
    int? toStore,
  }) = _PayloadRequestSendMessage;

  factory PayloadRequestSendMessage.fromJson(Object? json) =>
      _$PayloadRequestSendMessageFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
//   Map<String, dynamic> toJson(PayloadResponseListConversation data) =>

}
