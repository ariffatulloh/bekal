import 'dart:io';

import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestCreateProduct.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CreateProductMyStoreCubitState.dart';

class CreateProductMyStoreCubit extends Cubit<CreateProductMyStoreCubitState> {
  CreateProductMyStoreCubit()
      : super(InitialStateCreateProductMyStoreCubitState());
  ProfileRepository profileRepository = ProfileRepository();

  Future<PayloadResponseApi> createProduct({
    required File imgThumbnail,
    required List<File>? files,
    required int idStore,
    required PayloadRequestCreateProduct payloadRequestCreateProduct,
  }) async {
    emit(LoadingCreateProductMyStoreCubitState());
    var token = await SecureStorage().getToken();
    return profileRepository.createProduct(
        token!, imgThumbnail, files, idStore, payloadRequestCreateProduct);
  }

  void LoadDataProduct() {
    emit(StateLoadDataProduct());
  }
}
