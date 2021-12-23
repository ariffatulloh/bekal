import 'package:bekal/api/auth/api_auth_service.dart';
import 'package:bekal/api/auth/api_auth_service_client.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/request/PayloadRequestRegister.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseRegister.dart';

class AuthRepository {
  late ApiAuthService _service;

  AuthRepository() {
    _service = ApiAuthServiceClient().getService();
  }

  Future<PayloadResponseApi<PayloadResponseLogin>> login(
          PayloadRequestLogin payloadRequestLogin) =>
      _service.login(payloadRequestLogin);

  Future<PayloadResponseApi<PayloadResponseRegister>> register(
          PayloadRequestRegister payloadRequestRegister) =>
      _service.register(payloadRequestRegister);
}
