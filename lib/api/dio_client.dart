import 'dart:io';

import 'package:bekal/api/logger.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.sunmotor.co.id',
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ),
  )..interceptors.add(Logger());

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<DioResponse> getAsync(String request, {dynamic params}) async {
    try {
      String token = await SecureStorage().getToken() ?? "";

      Response response = await _dio.get('/api/$request',
          queryParameters: params,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      return DioResponse.success(response.data);
    } on DioError catch (error) {
      if (error.response != null)
        return DioResponse.success(error.response!.data);
      else
        return DioResponse.success({
          "statusCode": 403,
          "statusText": "Forbidden",
          "message": "Terjadi kesalahan pada jaringan internet"
        });
    }
  }

  Future<DioResponse> postAsync(String request, dynamic data) async {
    try {
      String token = await SecureStorage().getToken() ?? "";

      Response response = await _dio.post('/api/$request',
          data: data,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));

      print(response.data);

      return DioResponse.success(response.data);
    } catch (e) {
      print(e);

      if (e is DioError) {
        DioError error = e;
        return DioResponse.success(error.response!.data);
      }
      return DioResponse.success({
        "statusCode": 403,
        "statusText": "Forbidden",
        "message": "Terjadi kesalahan pada jaringan internet"
      });
    }
  }

  Future<DioResponse> putAsync(String request, dynamic data) async {
    try {
      String token = await SecureStorage().getToken() ?? "";

      Response response = await _dio.put('/api/$request',
          data: data,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      print(response.data);
      return DioResponse.success(response.data);
    } on DioError catch (error) {
      if (error.response != null)
        return DioResponse.success(error.response!.data);
      else
        return DioResponse.success({
          "statusCode": 403,
          "statusText": "Forbidden",
          "message": "Terjadi kesalahan pada jaringan internet"
        });
    }
  }

  Future<DioResponse> deleteAsync(String request, {dynamic params}) async {
    try {
      String token = await SecureStorage().getToken() ?? "";

      Response response = await _dio.delete('/api/$request',
          queryParameters: params,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      return DioResponse.success(response.data);
    } on DioError catch (error) {
      if (error.response != null)
        return DioResponse.success(error.response!.data);
      else
        return DioResponse.success({
          "statusCode": 403,
          "statusText": "Forbidden",
          "message": "Terjadi kesalahan pada jaringan internet"
        });
    }
  }
}

class DioResponse {
  dynamic results;
  dynamic error;
  StackTrace? stackTrace;

  DioResponse(this.results, this.error, this.stackTrace);

  DioResponse.success(dynamic json)
      : results = json,
        error = '',
        stackTrace = null;

  DioResponse.error(dynamic error, StackTrace stackTrace)
      : results = null,
        error = error,
        stackTrace = stackTrace;
}
