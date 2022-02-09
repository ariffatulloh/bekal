import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';

class HomeScreenCubit {
  ProfileRepository profileRepository = ProfileRepository();

  AuthRepository _authRepository = AuthRepository();
  Future<PayloadResponseApi> getHomeSeeAllProduct() async {
    var token = await SecureStorage().getToken();
    return profileRepository.getHomeSeeAllProduct(token!);
  }
}
