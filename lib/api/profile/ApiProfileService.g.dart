// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiProfileService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiProfileService implements ApiProfileService {
  _ApiProfileService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://51.79.251.50:3000/api/my/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PayloadResponseApi<PayloadResponseProfile>> getProfile(
      authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseProfile>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseProfile>.fromJson(
      _result.data!,
      (json) => PayloadResponseProfile.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseMyProfileDashboard>>
      myProfileDashboard(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseMyProfileDashboard>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile/dashboard',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<PayloadResponseMyProfileDashboard>.fromJson(
      _result.data!,
      (json) => PayloadResponseMyProfileDashboard.fromJson(
          json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(
      authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseVerification>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile/re-submit-verified',
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
      submitVerifiedAccount(authorization, payloadRequestLogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestLogin.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseVerification>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile/submit-verified',
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
  Future<PayloadResponseApi<PayloadResponseUpdatePersonalInformation?>>
      updatePersonalInformation(
          authorization, file, fullName, phoneNumber, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (file != null)
      _data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('fullName', fullName));
    _data.fields.add(MapEntry('phoneNumber', phoneNumber));
    _data.fields.add(MapEntry('address', address));
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        PayloadResponseApi<PayloadResponseUpdatePersonalInformation>>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data')
        .compose(_dio.options, 'profile/update/datapribadi',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<PayloadResponseUpdatePersonalInformation>.fromJson(
      _result.data!,
      (json) => PayloadResponseUpdatePersonalInformation.fromJson(
          json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseUpdateEmail?>> updateEmail(
      authorization, payloadRequestUpdateEmail) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestUpdateEmail.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseUpdateEmail>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile/update-email',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseUpdateEmail>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseUpdateEmail.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseUpdatePassword?>> updatePassword(
      authorization, payloadRequestUpdatePassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(payloadRequestUpdatePassword.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseUpdatePassword>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'profile/update-password',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseUpdatePassword>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseUpdatePassword.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createStore(
      authorization,
      file,
      nameStore,
      addressStore,
      phoneNumber,
      detailAddressStore,
      status) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (file != null)
      _data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('nameStore', nameStore));
    _data.fields.add(MapEntry('addressStore', addressStore));
    _data.fields.add(MapEntry('phoneNumber', phoneNumber));
    _data.fields.add(MapEntry('detailAddressStore', detailAddressStore));
    _data.fields.add(MapEntry('status', status));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseCreateStore>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'create/outlet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseCreateStore>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseCreateStore.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createProduct(
      authorization,
      imgThumbnail,
      files,
      nameStore,
      addressStore,
      phoneNumber,
      detailAddressStore,
      status,
      idstore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (imgThumbnail != null)
      _data.files.add(MapEntry(
          'imgThumbnail',
          MultipartFile.fromFileSync(imgThumbnail.path,
              filename: imgThumbnail.path.split(Platform.pathSeparator).last)));
    if (files != null) {
      _data.files.addAll(files.map((i) => MapEntry(
          'files',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    _data.fields.add(MapEntry('deskripsiProduct', nameStore));
    _data.fields.add(MapEntry('priceProduct', addressStore));
    _data.fields.add(MapEntry('stockProduct', phoneNumber));
    _data.fields.add(MapEntry('nameProduct', detailAddressStore));
    status.forEach((i) {
      _data.fields.add(MapEntry('storeCatProd', i));
    });
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseCreateStore>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'outlet/${idstore}/create/product',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseCreateStore>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseCreateStore.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseStoreCategory>>> getCategory(
      authorization, idstore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<List<PayloadResponseStoreCategory>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'outlet/${idstore}/categorys',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseStoreCategory>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseStoreCategory>((i) =>
              PayloadResponseStoreCategory.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseStoreProduct>>> getProducts(
      authorization, storeName, categoryName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<List<PayloadResponseStoreProduct>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'outlet/${storeName}/${categoryName}/products',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseStoreProduct>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseStoreProduct>((i) =>
              PayloadResponseStoreProduct.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseStoreProduct>> getDetailProduct(
      authorization, idProduct, idStore) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseStoreProduct>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'home/see/product/${idProduct}/${idStore}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseStoreProduct>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseStoreProduct.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<List<PayloadResponseHomeSeeAllProduct>>>
      getHomeSeeAllProduct(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PayloadResponseApi<List<PayloadResponseHomeSeeAllProduct>>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'home/see/all/products',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        PayloadResponseApi<List<PayloadResponseHomeSeeAllProduct>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<PayloadResponseHomeSeeAllProduct>((i) =>
              PayloadResponseHomeSeeAllProduct.fromJson(
                  i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> updateStore(
      authorization,
      idstore,
      file,
      nameStore,
      addressStore,
      phoneNumber,
      detailAddressStore,
      status) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (file != null)
      _data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('nameStore', nameStore));
    _data.fields.add(MapEntry('addressStore', addressStore));
    _data.fields.add(MapEntry('phoneNumber', phoneNumber));
    _data.fields.add(MapEntry('detailAddressStore', detailAddressStore));
    _data.fields.add(MapEntry('status', status));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PayloadResponseApi<PayloadResponseCreateStore>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'outlet/${idstore}/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PayloadResponseApi<PayloadResponseCreateStore>.fromJson(
      _result.data!,
      (json) =>
          PayloadResponseCreateStore.fromJson(json as Map<String, dynamic>),
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
