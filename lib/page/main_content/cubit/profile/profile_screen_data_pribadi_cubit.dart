import 'dart:io';

import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/payload/request/PayloadRequestCreateStore.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/response/PayloadResponseCreateStore.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseUpdateEmail.dart';
import 'package:bekal/payload/response/PayloadResponseUpdatePassword.dart';
import 'package:bekal/payload/response/PayloadResponseUpdatePersonalInformation.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenDataPribadiCubit
    extends Cubit<ProfileScreenDataPribadiCubitState> {
  ProfileScreenDataPribadiCubit() : super(InitialDataPribadiState());
  ProfileRepository profileRepository = ProfileRepository();
  AuthRepository _authRepository = AuthRepository();
  void reLogin(PayloadRequestLogin data, bool rememberme,
      {dynamic param, dynamic callBackMethod}) {
    print("cubit action button login ${data.email} ${data.password}");
    emit(LoadingDataPribadi());

    // emit(Loading());
    _authRepository.login(data).then((value) async {
      PayloadResponseLogin? dataValue = value.data;
      if (dataValue != null) {
        // print("sukses login with email:${payloadRequestLogin.email}");
        if (rememberme) {
          print("Login Sukses : User Remembered Login ");
          SecureStorage().saveTokenWithCredential(
              dataValue.token, data.email, data.password);
        } else {
          print("Login Sukses : User not Remembered Login");
          SecureStorage().saveTokenOnly(dataValue.token);
        }
        if (callBackMethod == "LoadMyProfileDataPribadi") {
          LoadMyProfileDataPribadi(indexMenu: param);
        } else {
          updateDataPribadi(param: param);
        }
      } else {
        print("Login fail : message  ${value.errorMessage}");
        emit(GoToDataPribadiState("LOGIN"));
      }
    }).catchError((e) async {
      emit(GoToDataPribadiState("LOGIN"));
    });
  }

  Future<void> updateDataPribadi({required dynamic param, File? file}) async {
    emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();

    profileRepository
        .updatePersonalInformation(token!, param, file)
        .then((value) async {
      // print("this ${value}");
      PayloadResponseUpdatePersonalInformation? data = value.data;
      if (data != null) {
        LoadMyProfileDataPribadi();
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            reLogin(
                PayloadRequestLogin(email: email!, password: password!), true,
                param: param, callBackMethod: "updateDataPribadi");
          } else {
            emit(GoToDataPribadiState("LOGIN"));
          }
        } else {
          emit(GoToDataPribadiState("LOGIN"));
        }
      }
    }).catchError((e) {
      emit(GoToDataPribadiState("LOGIN"));
    });
  }

  Future<bool> updatePassword({required dynamic param}) async {
    // emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();
    return profileRepository.updatePassword(token!, param).then((value) async {
      // print("this ${value}");
      PayloadResponseUpdatePassword? data = value.data;
      if (data != null) {
        if (data.message == "Update Sukses") {
          return true;
          // emit(GoToDataPribadiState("LOGIN",
          //     message: "Silahkan Login ulang dengan email baru"));
          // LoadMyProfileDataPribadi();
          // if (SecureStorage().getRememberLogin() == "true") {
          //   SecureStorage().saveTokenWithCredential(
          //       dataValue.token, data.email, data.password);
          // }
          // else
        } else {
          return false;
        }
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> updateEmail({required dynamic param}) async {
    // emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();
    return profileRepository.updateEmail(token!, param).then((value) async {
      // print("this ${value}");
      PayloadResponseUpdateEmail? data = value.data;
      if (data != null) {
        if (data.message == "Update Sukses") {
          return true;
          // emit(GoToDataPribadiState("LOGIN",
          //     message: "Silahkan Login ulang dengan email baru"));
          // LoadMyProfileDataPribadi();
          // if (SecureStorage().getRememberLogin() == "true") {
          //   SecureStorage().saveTokenWithCredential(
          //       dataValue.token, data.email, data.password);
          // }
          // else
        } else {
          return false;
        }
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }

  Future<void> LoadMyProfileDataPribadi({int? indexMenu}) async {
    emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();
    profileRepository.getProfile(token!).then((value) async {
      // print("this ${value}");
      PayloadResponseProfile? data = value.data;
      if (data != null) {
        emit(LoadDataPribadiStateSukses(data: data));
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            reLogin(
                PayloadRequestLogin(email: email!, password: password!), true,
                param: null, callBackMethod: "LoadMyProfileDataPribadi");
          } else {
            emit(GoToDataPribadiState("LOGIN"));
          }
        } else {
          emit(GoToDataPribadiState("LOGIN"));
        }
      }
    }).catchError((e) {
      emit(GoToDataPribadiState("LOGIN"));
    });
  }

  Future<bool> logout() async {
    emit(LoadingDataPribadi());
    SecureStorage().deleteStorageToken();
    var token = await SecureStorage().getToken();
    if (token == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createStore({required dynamic param, File? file}) async {
    emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();
    var response = false;
    await profileRepository
        .createStore(token!, file, param)
        .then((value) async {
      // print("this ${value}");
      PayloadResponseCreateStore? data = value.data;
      if (data != null) {
        // LoadMyProfileDataPribadi();
        response = true;
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            reLogin(
                PayloadRequestLogin(email: email!, password: password!), true,
                param: param, callBackMethod: "createStore");
          } else {
            emit(GoToDataPribadiState("LOGIN"));
          }
        } else {
          emit(GoToDataPribadiState("LOGIN"));
        }
      }
    }).catchError((e) {
      emit(GoToDataPribadiState("LOGIN"));
    });
    return response;
  }

  Future<bool> updateStore({required dynamic param, File? file}) async {
    print("updateStore");
    emit(LoadingDataPribadi());
    var token = await SecureStorage().getToken();
    var response = false;
    PayloadRequestCreateStore data = param;
    print(data.idStore);
    await profileRepository
        .updateStore(token!, data.idStore!, param, file)
        .then((value) async {
      print(value.data!.message);
      // print("this ${value}");
      PayloadResponseCreateStore? data = value.data;
      if (data != null) {
        // LoadMyProfileDataPribadi();
        response = true;
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            reLogin(
                PayloadRequestLogin(email: email!, password: password!), true,
                param: param, callBackMethod: "createStore");
          } else {
            emit(GoToDataPribadiState("LOGIN"));
          }
        } else {
          emit(GoToDataPribadiState("LOGIN"));
        }
      }
    }).catchError((e) {
      emit(GoToDataPribadiState("LOGIN"));
    });
    return response;
  }
}
