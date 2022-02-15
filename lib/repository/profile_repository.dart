import 'dart:io';

import 'package:bekal/api/profile/ApiProfileService.dart';
import 'package:bekal/api/profile/ApiProfileServiceClient.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestCreateProduct.dart';
import 'package:bekal/payload/request/PayloadRequestCreateStore.dart';
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

class ProfileRepository {
  late ApiProfileService _service;

  ProfileRepository() {
    _service = ApiProfileServiceClient().getService();
  }

  Future<PayloadResponseApi<PayloadResponseProfile?>> getProfile(
          String authorization) =>
      _service.getProfile("Bearer $authorization");

  Future<PayloadResponseApi<PayloadResponseMyProfileDashboard?>>
      myProfileDashboard(String authorization) =>
          _service.myProfileDashboard("Bearer $authorization");

  Future<PayloadResponseApi<PayloadResponseVerification?>> getResendVerifyCode(
          String authorization) =>
      _service.getResendVerifyCode("Bearer $authorization");

  Future<PayloadResponseApi<PayloadResponseVerification?>> submitVerifyCode(
          String authorization,
          PayloadRequestVerificationCode payloadRequestVerificationCode) =>
      _service.submitVerifiedAccount(
          "Bearer $authorization", payloadRequestVerificationCode);

  Future<PayloadResponseApi<PayloadResponseUpdatePersonalInformation?>>
      updatePersonalInformation(
              String authorization,
              File? file,
              PayloadRequestUpdatePersonalInformation
                  payloadRequestUpdatePersonalInformation) =>
          _service.updatePersonalInformation(
              "Bearer $authorization",
              file,
              payloadRequestUpdatePersonalInformation.fullName,
              payloadRequestUpdatePersonalInformation.phoneNumber,
              payloadRequestUpdatePersonalInformation.address);

  Future<PayloadResponseApi<PayloadResponseUpdateEmail?>> updateEmail(
          String authorization,
          PayloadRequestUpdateEmail payloadRequestUpdateEmail) =>
      _service.updateEmail("Bearer $authorization", payloadRequestUpdateEmail);

  Future<PayloadResponseApi<PayloadResponseUpdatePassword?>> updatePassword(
          String authorization,
          PayloadRequestUpdatePassword payloadRequestUpdatePassword) =>
      _service.updatePassword(
          "Bearer $authorization", payloadRequestUpdatePassword);

  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createStore(
          String authorization,
          File? file,
          PayloadRequestCreateStore payloadRequestCreateStore) =>
      _service.createStore(
        "Bearer $authorization",
        file,
        payloadRequestCreateStore.nameStore,
        payloadRequestCreateStore.addressStore,
        payloadRequestCreateStore.phoneNumber,
        payloadRequestCreateStore.detailAddressStore,
        payloadRequestCreateStore.status,
      );

  Future<PayloadResponseApi<PayloadResponseCreateStore?>> createProduct(
          String authorization,
          File? imgThumbnail,
          List<File>? files,
          int idStore,
          PayloadRequestCreateProduct payloadRequestCreateProduct) =>
      _service.createProduct(
          "Bearer $authorization",
          imgThumbnail,
          files,
          payloadRequestCreateProduct.deskripsiProduct,
          payloadRequestCreateProduct.priceProduct,
          payloadRequestCreateProduct.stockProduct,
          payloadRequestCreateProduct.nameProduct,
          payloadRequestCreateProduct.storeCatProd,
          idStore);

  Future<PayloadResponseApi<PayloadResponseCreateStore?>> updateStore(
    String authorization,
    int idstore,
    PayloadRequestCreateStore payloadRequestCreateStore,
    File? file,
  ) =>
      _service.updateStore(
        "Bearer $authorization",
        idstore,
        file,
        payloadRequestCreateStore.nameStore,
        payloadRequestCreateStore.addressStore,
        payloadRequestCreateStore.phoneNumber,
        payloadRequestCreateStore.detailAddressStore,
        payloadRequestCreateStore.status,
      );

  Future<PayloadResponseApi<List<PayloadResponseStoreCategory>>> getCategory(
    String authorization,
    int idstore,
  ) =>
      _service.getCategory("Bearer $authorization", idstore);

  Future<PayloadResponseApi<List<PayloadResponseStoreProduct>>> getProduct(
    String authorization,
    String storeName,
    String categoryName,
  ) =>
      _service.getProducts("Bearer $authorization", storeName, categoryName);

  Future<PayloadResponseApi<PayloadResponseStoreProduct>> getDetailProduct(
    String authorization,
    int idProduct,
    int idStore,
  ) =>
      _service.getDetailProduct("Bearer $authorization", idProduct, idStore);

  Future<PayloadResponseApi<List<PayloadResponseHomeSeeAllProduct>>>
      getHomeSeeAllProduct(
    String authorization,
  ) =>
          _service.getHomeSeeAllProduct("Bearer $authorization");
}
