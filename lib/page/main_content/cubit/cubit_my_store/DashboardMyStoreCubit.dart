import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseStoreCategory.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DashboardMyStoreCubitState.dart';

class DashboardMyStoreCubit extends Cubit<DashboardMyStoreCubitState> {
  DashboardMyStoreCubit() : super(InitialStateDashboardMyStoreCubitState());
  ProfileRepository profileRepository = ProfileRepository();

  AuthRepository _authRepository = AuthRepository();
  Future<PayloadResponseApi> getCategory({required int idStore}) async {
    emit(LoadingDashboardMyStoreCubitState());
    var token = await SecureStorage().getToken();
    List<PayloadResponseStoreCategory> result = [];
    return profileRepository.getCategory(token!, idStore);
  }

  Future<PayloadResponseApi> getProduct({
    required String storeName,
    required String categoryName,
  }) async {
    emit(LoadingDashboardMyStoreCubitState());
    var token = await SecureStorage().getToken();
    return profileRepository.getProduct(token!, storeName, categoryName);
  }

  void LoadDataProduct() {
    emit(StateLoadDataProduct());
  }
}
