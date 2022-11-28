import 'dart:async';

import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_cubit_state.dart';

// enum splashScreen{CheckingTOken}

class LoginCubit extends Cubit<LoginCubitState> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final AuthRepository _authRepository = AuthRepository();
  ProfileRepository profileRepository = ProfileRepository();

  LoginCubit() : super(InitialLoginState());

  void buttonLogin(PayloadRequestLogin data, bool rememberme) {
    if (kDebugMode) {
      print("cubit action button login ${data.email} ${data.password}");
    }
    emit(LOADING());

    // emit(Loading());
    _authRepository.login(data).then((value) async {
      PayloadResponseLogin? dataValue = value.data;
      if (dataValue != null) {
        // print("sukses login with email:${payloadRequestLogin.email}");
        if (rememberme) {
          if (kDebugMode) {
            print("Login Sukses : User Remembered Login ");
          }
          SecureStorage().saveTokenWithCredential(
              dataValue.token, data.email, data.password);
        } else {
          if (kDebugMode) {
            print("Login Sukses : User not Remembered Login");
          }
          SecureStorage().saveTokenOnly(dataValue.token);
        }
        print("here");
        isVerified(dataValue.token);
        // getProfile(dataValue.token);
        //
        // CheckingToken();
      } else {
        if (kDebugMode) {
          print("Login fail : message  ${value.errorMessage}");
        }
        try {
          emit(FailedLogin(message: value.errorMessage));
          await Future.delayed(const Duration(seconds: 3));

          emit(InitialLoginState());
        } catch (err) {
          if (kDebugMode) {
            print("catch");
          }
        }
      }
    }).catchError((e) async {
      if (kDebugMode) {
        print("catch");
      }

      try {
        emit(FailedLogin(message: "Silahkan Check Koneksi Internet Anda"));
        await Future.delayed(const Duration(seconds: 3));

        emit(InitialLoginState());
      } catch (err) {
        if (kDebugMode) {
          print("catch");
        }
      }
    });
  }

  void isVerified(String token) {
    // emit(LoginScreenState(Loginstate: "LOADING"));
    if (kDebugMode) {
      print(token);
    }

    profileRepository.getProfile(token).then((value) async {
      print("this ${value}");
      PayloadResponseProfile? data = value.data;
      if (data != null) {
        if (kDebugMode) {
          print("check isverivied? ${data.isVerify}");
        }
        if (data.isVerify) {
          emit(GotoHome());
        } else {
          if (kDebugMode) {
            print("goto VERIFIED_ACCOUNT");
          }
          emit(GotoVerifiedAccount());
        }
      } else {
        if (value.status == "Token Expired") {
          if (kDebugMode) {
            print("Token Expired");
          }
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            buttonLogin(
                PayloadRequestLogin(email: email!, password: password!), true);
          } else {
            emit(FailedLogin(message: "SESSION EXPIRED PLEASE LOGIN AGAIN"));
          }
        } else {}
      }
    }).catchError((e) async {
      if (kDebugMode) {
        print("catch");
        print(e);
      }

      try {
        emit(FailedLogin(message: "Silahkan Check Koneksi Internet Anda"));
        await Future.delayed(const Duration(seconds: 3));

        emit(InitialLoginState());
      } catch (err) {
        if (kDebugMode) {
          print("catch");
        }
      }
      // print("catch ${e}");
      // emit(FailGetProfile("Silahkan Login"));
    });
  }

// void resendVerifyCode(token) {
//   ProfileRepository profileRepository = ProfileRepository();
//   profileRepository.getResendVerifyCode(token).then((value) {
//     emit(NeedVerifyCode(value.data!.email));
//   }).catchError((onError) {});
// }

// void loadRegisterUI() {
//   emit(LoadRegisterUI());
// }

// void suksesLoadRegisterUI() {
//   emit(SuksesLoadRegisterUI());
// }

// void submitRegister(PayloadRequestRegister payloadRequestRegister) {
//   print("try to Register with email:${payloadRequestRegister.email}");
//   AuthRepository _authRepository = AuthRepository();
//
//   emit(SubmitLoginLoading());
//   _authRepository.register(payloadRequestRegister).then((value) async {
//     PayloadResponseRegister? data = value.data;
//     if (data != null) {
//       if (data.registrationSukses) {
//         print(
//             "sukses to Register with email:${payloadRequestRegister.email}");
//         // submitLogin(PayloadRequestLogin(
//         //     email: payloadRequestRegister.email,
//         //     password: payloadRequestRegister.password));
//       }
//       // await _storage.write(
//       //     key: "token",
//       //     value: data.token,
//       //     iOptions: _getIOSOptions(),
//       //     aOptions: _getAndroidOptions());
//       // CheckingToken();
//     } else {
//       print(value.errorMessage);
//       emit(SubmitLoginFail(value.errorMessage));
//     }
//   }).catchError((e) {
//     print("catch error");
//     emit(SubmitLoginFail("Silahkan Login"));
//   });
// }

// void submitLogin(PayloadRequestLogin payloadRequestLogin, bool rememberme) {
//   print("try to login with email:${payloadRequestLogin.email}");
//
// }

// IOSOptions _getIOSOptions() =>
//     IOSOptions(accessibility: IOSAccessibility.first_unlock);
//
// AndroidOptions _getAndroidOptions() => const AndroidOptions(
//       encryptedSharedPreferences: true,
//     );
}
