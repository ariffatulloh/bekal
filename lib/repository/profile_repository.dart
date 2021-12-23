import 'package:bekal/api/profile/ApiProfileServiceClient.dart';
import 'package:bekal/api/profile/api_profile_service.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestVerificationCode.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseVerification.dart';

class ProfileRepository {
  late ApiProfileService _service;

  ProfileRepository() {
    _service = ApiProfileServiceClient().getService();
  }

  Future<PayloadResponseApi<PayloadResponseProfile?>> getProfile(
          String authorization) =>
      _service.getProfile("Bearer $authorization");

  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(
          String authorization) =>
      _service.getResendVerifyCode("Bearer $authorization");

  Future<PayloadResponseApi<PayloadResponseVerification?>> submitVerifyCode(
          String authorization,
          PayloadRequestVerificationCode payloadRequestVerificationCode) =>
      _service.submitVerifiedAccount(
          "Bearer $authorization", payloadRequestVerificationCode);
}
