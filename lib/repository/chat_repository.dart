import 'package:bekal/api/chat/ApiChatService.dart';
import 'package:bekal/api/chat/ApiChatServiceClient.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestSendMessage.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';

class ChatRepository {
  late ApiChatService _service;

  ChatRepository() {
    _service = ApiChatServiceClient().getService();
  }

  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversationAsStore(String authorization, int idStore) =>
          _service.getListConversationAsStore("Bearer $authorization", idStore);
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversationAsStore(
              String authorization, int withUser, int idStore) =>
          _service.getListDetailConversationAsStore(
              "Bearer $authorization", withUser, idStore);
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversation(String authorization) =>
          _service.getListConversation("Bearer $authorization");
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversation(String authorization, int withUser) =>
          _service.getListDetailConversation("Bearer $authorization", withUser);
  Future<PayloadResponseApi<PayloadResponseListConversation>> sendMessage(
          String authorization, PayloadRequestSendMessage sendMessage) =>
      _service.sendMessage("Bearer $authorization", sendMessage);
  Future<PayloadResponseApi<PayloadResponseListConversation>>
      sendMessageAsStore(String authorization,
              PayloadRequestSendMessage sendMessage, int idStore) =>
          _service.sendMessageAsStore(
              "Bearer $authorization", sendMessage, idStore);
}
