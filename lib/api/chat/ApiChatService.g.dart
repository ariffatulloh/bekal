// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiChatService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiChatService implements ApiChatService {
  _ApiChatService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://51.79.251.50:3000/chat/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PayloadResponseApi<PayloadResponseListConversation>> sendMessage(
      authorization, message) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(message.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseListConversation>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseListConversation>.fromJson(
      _result.data!,
      (json) => PayloadResponseListConversation.fromJson(
          json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseListConversation>>
      sendMessageAsStore(authorization, message, idStore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(message.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseListConversation>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'as-store/${idStore}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseListConversation>.fromJson(
      _result.data!,
      (json) => PayloadResponseListConversation.fromJson(
          json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversation(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PayloadResponseApi<List<PayloadResponseListConversation>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseListConversation>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseListConversation>((i) =>
              PayloadResponseListConversation.fromJson(
                  i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListConversationAsStore(authorization, idStore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PayloadResponseApi<List<PayloadResponseListConversation>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'as-store/${idStore}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseListConversation>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseListConversation>((i) =>
              PayloadResponseListConversation.fromJson(
                  i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversationAsStore(authorization, withUser, idStore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PayloadResponseApi<List<PayloadResponseListConversation>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'as-store/${idStore}/${withUser}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseListConversation>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseListConversation>((i) =>
              PayloadResponseListConversation.fromJson(
                  i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseListConversation>>>
      getListDetailConversation(authorization, withUser) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PayloadResponseApi<List<PayloadResponseListConversation>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '${withUser}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseListConversation>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseListConversation>((i) =>
              PayloadResponseListConversation.fromJson(
                  i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
