// part 'LoginCubitEvent.dart';

import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
// enum splashScreen{CheckingTOken}
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'SplashCubitState.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  AuthRepository _authRepository = AuthRepository();
  ProfileRepository profileRepository = ProfileRepository();

  SplashCubit() : super(CheckingTokenState());

  void login(PayloadRequestLogin data, bool rememberme) {
    print("cubit action button login ${data.email} ${data.password}");
    emit(Loading());

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
        isVerified(dataValue.token);
      } else {
        print("Login fail : message  ${value.errorMessage}");
        emit(GoTo("LOGIN"));
      }
    }).catchError((e) async {
      emit(GoTo("LOGIN"));
    });
  }

  Future<void> CheckingToken() async {
    try {
      // removing the next line will never emit the SearchLoading()-state and no spinner is shown
      await Future.delayed(Duration(seconds: 10));
      emit(Loading());
      var token = await SecureStorage().getToken();
      if (token != null) {
        isVerified(token);
        // if (SecureStorage().getRememberLogin() != null) {
        //   if (SecureStorage().getRememberLogin() == "true") {
        //
        //   } else {
        //     // getProfile(getToken()!);
        //     // submitLogin(PayloadRequestLogin(email: getEmail()!,password: getPassword()!), false);
        //   }
        // } else {}
      } else {
        print("has Token ${SecureStorage().getToken()}");
        emit(GoTo("LOGIN"));
      }
    } catch (err, stacktrace) {}
  }

  void isVerified(String token) {
    emit(Loading());
    print(token);

    profileRepository.getProfile(token).then((value) async {
      // print("this ${value}");
      PayloadResponseProfile? data = value.data;
      if (data != null) {
        print("check isverivied? ${data.isVerify}");
        if (data.isVerify) {
          emit(GoTo("HOME"));
        } else {
          emit(GoTo("VERIFIED_ACCOUNT"));
        }
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            login(
                PayloadRequestLogin(email: email!, password: password!), true);
          } else {
            emit(GoTo("LOGIN"));
          }
        } else {
          emit(GoTo("LOGIN"));
        }
      }
    }).catchError((e) {
      emit(GoTo("LOGIN"));
    });
  }
}
