// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiAuthService implements ApiAuthService {
  _ApiAuthService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://rifias.live/auth/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PayloadResponseApi<PayloadResponseLogin>> login(
      payloadRequestLogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestLogin.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseLogin>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseLogin>.fromJson(
      _result.data!,
      (json) => PayloadResponseLogin.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseRegister>> register(
      payloadRequestRegister) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestRegister.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseRegister>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseRegister>.fromJson(
      _result.data!,
      (json) => PayloadResponseRegister.fromJson(json as Map<String, dynamic>),
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
