import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/request/PayloadRequestRegister.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseRegister.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_auth_service.g.dart';

@RestApi(baseUrl: 'http://51.79.251.50:3000/auth/')
abstract class ApiAuthService {
  factory ApiAuthService(Dio dio, {String baseUrl}) = _ApiAuthService;

  @POST('login')
  Future<PayloadResponseApi<PayloadResponseLogin>> login(
      @Body() PayloadRequestLogin payloadRequestLogin);

  @POST('register')
  Future<PayloadResponseApi<PayloadResponseRegister>> register(
      @Body() PayloadRequestRegister payloadRequestRegister);
}
