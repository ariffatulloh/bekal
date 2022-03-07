import 'package:dio/dio.dart';

import 'ApiChatService.dart';

class ApiChatServiceClient {
  late Dio _dio;
  late ApiChatService _service;

  ApiChatServiceClient() {
    _dio = Dio();
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _service = ApiChatService(_dio);
  }

  ApiChatService getService() {
    return _service;
  }
}
