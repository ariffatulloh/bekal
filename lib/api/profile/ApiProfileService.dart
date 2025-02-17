import 'dart:ffi';
import 'dart:io';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestUpdateEmail.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePassword.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePersonalInformation.dart';
import 'package:bekal/payload/request/PayloadRequestVerificationCode.dart';
import 'package:bekal/payload/response/PayloadResponseCreateStore.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseStoreCategory.dart';
import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:bekal/payload/response/PayloadResponseUpdateEmail.dart';
import 'package:bekal/payload/response/PayloadResponseUpdatePassword.dart';
import 'package:bekal/payload/response/PayloadResponseUpdatePersonalInformation.dart';
import 'package:bekal/payload/response/PayloadResponseVerification.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiProfileService.g.dart';

@RestApi(baseUrl: '${DioClient.ipServer}/api/my/')
abstract class ApiProfileService {
  factory ApiProfileService(Dio dio, {String baseUrl}) = _ApiProfileService;

  @GET('profile')
  Future<PayloadResponseApi<PayloadResponseProfile>> getProfile(@Header("Authorization") String authorization);
  @DELETE('profile/delete')
  Future<PayloadResponseApi<bool>> deleteAkun(@Header("Authorization") String authorization);

  @GET('profile/dashboard')
  Future<PayloadResponseApi<PayloadResponseMyProfileDashboard>> myProfileDashboard(@Header("Authorization") String authorization);

  @GET('profile/re-submit-verified')
  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(@Header("Authorization") String authorization);

  @POST('profile/submit-verified')
  Future<PayloadResponseApi<PayloadResponseVerification?>> submitVerifiedAccount(@Header("Authorization") String authorization, @Body() PayloadRequestVerificationCode payloadRequestLogin);

  @POST('profile/update/datapribadi')
  Future<PayloadResponseApi<PayloadResponseUpdatePersonalInformation?>> updatePersonalInformation(
    @Header("Authorization") String authorization,
    @Part() File? file,
    @Body() PayloadRequestUpdatePersonalInformation payloadRequestUpdatePersonalInformation,
  );

  @POST('profile/update-email')
  Future<PayloadResponseApi<PayloadResponseUpdateEmail?>> updateEmail(@Header("Authorization") String authorization, @Body() PayloadRequestUpdateEmail payloadRequestUpdateEmail);

  @POST('profile/update-password')
  Future<PayloadResponseApi<PayloadResponseUpdatePassword?>> updatePassword(@Header("Authorization") String authorization, @Body() PayloadRequestUpdatePassword payloadRequestUpdatePassword);

  @POST('create/outlet')
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createStore(
    @Header("Authorization") String authorization,
    @Part(name: "file") File? file,
    @Part(name: "nameStore") String nameStore,
    @Part(name: "addressStore") String addressStore,
    @Part(name: "phoneNumber") String phoneNumber,
    @Part(name: "detailAddressStore") String detailAddressStore,
    @Part(name: "status") String status,
  );
  @POST('outlet/{idstore}/create/product')
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createProduct(@Header("Authorization") String authorization, @Part(name: "imgThumbnail") File? imgThumbnail, @Part(name: "files") List<File>? files, @Part(name: "deskripsiProduct") String nameStore,
      @Part(name: "priceProduct") String addressStore, @Part(name: "stockProduct") String phoneNumber, @Part(name: "nameProduct") String detailAddressStore, @Part(name: "storeCatProd") List<String> status, @Path() int idstore);

  @GET('outlet/{idstore}/categorys')
  Future<PayloadResponseApi<List<PayloadResponseStoreCategory>>> getCategory(@Header("Authorization") String authorization, @Path() int idstore);

  @GET('outlet/{storeName}/{categoryName}/products')
  Future<PayloadResponseApi<List<PayloadResponseStoreProduct>>> getProducts(@Header("Authorization") String authorization, @Path() String storeName, @Path() String categoryName);

  @GET('home/see/product/{idProduct}/{idStore}')
  Future<PayloadResponseApi<PayloadResponseStoreProduct>> getDetailProduct(@Header("Authorization") String authorization, @Path() int idProduct, @Path() int idStore);
  @GET('home/see/all/products')
  Future<PayloadResponseApi<List<PayloadResponseHomeSeeAllProduct>>> getHomeSeeAllProduct(
    @Header("Authorization") String authorization,
  );

  @POST('outlet/{idstore}/')
  Future<PayloadResponseApi<PayloadResponseCreateStore?>> updateStore(@Header("Authorization") String authorization, @Path() int idstore, @Part(name: "file") File? file, @Part(name: "nameStore") String nameStore, @Part(name: "addressStore") String addressStore,
      @Part(name: "phoneNumber") String phoneNumber, @Part(name: "detailAddressStore") String detailAddressStore, @Part(name: "status") String status);
}
