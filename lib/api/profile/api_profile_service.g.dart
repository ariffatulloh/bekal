// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_profile_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiProfileService implements ApiProfileService {
  _ApiProfileService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://rifias.live/api/profile/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PayloadResponseApi<PayloadResponseProfile>> getProfile(
      Authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': Authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseProfile>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseProfile>.fromJson(
      _result.data!,
      (json) => PayloadResponseProfile.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(
      Authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': Authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseVerification>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 're-submit-verified',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseVerification>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseVerification.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseVerification?>>
      submitVerifiedAccount(Authorization, payloadRequestLogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': Authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestLogin.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseVerification>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'submit-verified',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseVerification>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseVerification.fromJson(json as Map<String, dynamic>),
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
