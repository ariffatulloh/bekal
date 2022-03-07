import 'package:bekal/api/dio_client.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestSendMessage.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiChatService.g.dart';

@RestApi(baseUrl: '${DioClient.ipServer}/chat/')
abstract class ApiChatService {
  factory ApiChatService(Dio dio, {String baseUrl}) = _ApiChatService;

  @POST('')
  Future<PayloadResponseApi<PayloadResponseListConversation>> sendMessage(
      @Header("Authorization") String authorization,
      @Body() PayloadRequestSendMessage message);
  @POST('as-store/{idStore}')
  Future<PayloadResponseApi<PayloadResponseListConversation>>
      sendMessageAsStore(@Header("Authorization") String authorization,
          @Body() PayloadRequestSendMessage message, @Path() int idStore);
  @GET('')
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversation(@Header("Authorization") String authorization);
  @GET('as-store/{idStore}')
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversationAsStore(
          @Header("Authorization") String authorization, @Path() int idStore);

  @GET('as-store/{idStore}/{withUser}')
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversationAsStore(
          @Header("Authorization") String authorization,
          @Path() int withUser,
          @Path() int idStore);
  @GET('{withUser}')
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversation(
          @Header("Authorization") String authorization, @Path() int withUser);
}
