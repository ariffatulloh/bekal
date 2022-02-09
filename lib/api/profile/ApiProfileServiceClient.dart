import 'package:dio/dio.dart';

import 'ApiProfileService.dart';

class ApiProfileServiceClient {
  late Dio _dio;
  late ApiProfileService _service;

  ApiProfileServiceClient() {
    _dio = Dio();
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _service = ApiProfileService(_dio);
  }

  ApiProfileService getService() {
    return _service;
  }
}
