import 'package:bekal/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api/auth/api_auth_service.dart';

var getIt = GetIt.I;
void Locator() {
  Dio dio = Dio();
  getIt.registerFactory(() => dio);
  //
  ApiAuthService apiAuthService = ApiAuthService(getIt.call());
  getIt.registerLazySingleton(() => apiAuthService);

  AuthRepository authRepository = AuthRepository();
  getIt.registerLazySingleton(() => authRepository);
}
