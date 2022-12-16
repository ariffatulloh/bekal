import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';

class HomeScreenCubit {
  ProfileRepository profileRepository = ProfileRepository();

  AuthRepository _authRepository = AuthRepository();
  Future<PayloadResponseApi> getHomeSeeAllProduct() async {
    var token = await SecureStorage().getToken();
    return profileRepository.getHomeSeeAllProduct(token ?? "XXX");
  }

  Future<PayloadResponseApi> getHomeSeeDetailProduct(
      {required int idProduct, required int idStore}) async {
    var token = await SecureStorage().getToken();

    return profileRepository.getDetailProduct(
        token ?? "XXX", idProduct, idStore);
  }
}
