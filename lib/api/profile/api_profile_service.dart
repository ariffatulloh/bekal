import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestVerificationCode.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseVerification.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_profile_service.g.dart';

@RestApi(baseUrl: 'http://rifias.live/api/profile/')
abstract class ApiProfileService {
  factory ApiProfileService(Dio dio, {String baseUrl}) = _ApiProfileService;

  @GET('')
  Future<PayloadResponseApi<PayloadResponseProfile>> getProfile(
      @Header("Authorization") String authorization);

  @GET('re-submit-verified')
  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(
      @Header("Authorization") String authorization);

  @POST('submit-verified')
  Future<PayloadResponseApi<PayloadResponseVerification?>>
      submitVerifiedAccount(@Header("Authorization") String authorization,
          @Body() PayloadRequestVerificationCode payloadRequestLogin);
}
