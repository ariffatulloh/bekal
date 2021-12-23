import 'package:dio/dio.dart';

import 'api_auth_service.dart';

class ApiAuthServiceClient {
  late Dio _dio;
  late ApiAuthService _service;

  ApiAuthServiceClient() {
    _dio = Dio();
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _service = ApiAuthService(_dio);
  }

  ApiAuthService getService() {
    return _service;
  }
}
