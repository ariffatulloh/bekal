import 'package:bekal/page/auth/cubit/register/register_cubit_state.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/request/PayloadRequestRegister.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseRegister.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit() : super(InitialRegisterState());
  final AuthRepository _authRepository = AuthRepository();
  ProfileRepository profileRepository = ProfileRepository();

  void submitRegister(PayloadRequestRegister payloadRequestRegister) {
    print("try to Register with email:${payloadRequestRegister.email}");
    emit(LOADING());
    _authRepository.register(payloadRequestRegister).then((value) async {
      PayloadResponseRegister? data = value.data;
      if (data != null) {
        if (data.registrationSukses) {
          print(
              "sukses to Register with email:${payloadRequestRegister.email}");
          login(
              PayloadRequestLogin(
                  email: payloadRequestRegister.email,
                  password: payloadRequestRegister.password),
              false);
        }
      } else {
        try {
          print(value.errorMessage);
          emit(REGISTER_FAILED(Message: value.errorMessage));
          await Future.delayed(Duration(seconds: 3));

          emit(InitialRegisterState());
        } catch (err) {}
      }
    }).catchError((e) async {
      try {
        emit(REGISTER_FAILED(Message: "Silahkan Check Koneksi Internet Anda"));
        await Future.delayed(Duration(seconds: 3));

        emit(InitialRegisterState());
      } catch (err) {}
    });
  }

  void login(PayloadRequestLogin data, bool rememberme) {
    print("cubit action button login ${data.email} ${data.password}");
    emit(LOADING());

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
        emit(GOTO_LOGIN());
      }
    }).catchError((e) async {
      try {
        emit(REGISTER_FAILED(Message: "Silahkan Check Koneksi Internet Anda"));
        await Future.delayed(Duration(seconds: 3));

        emit(InitialRegisterState());
      } catch (err) {}
    });
  }

  void isVerified(String token) {
    emit(LOADING());
    print(token);

    profileRepository.getProfile(token).then((value) async {
      // print("this ${value}");
      PayloadResponseProfile? data = value.data;
      if (data != null) {
        print("check isverivied? ${data.isVerify}");
        if (data.isVerify) {
          emit(GotoHome());
        } else {
          emit(GotoVerifiedAccount());
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
            emit(GOTO_LOGIN());
          }
        } else {
          emit(GOTO_LOGIN());
        }
      }
    }).catchError((e) async {
      try {
        emit(REGISTER_FAILED(Message: "Silahkan Check Koneksi Internet Anda"));
        await Future.delayed(Duration(seconds: 3));

        emit(InitialRegisterState());
      } catch (err) {}
    });
  }
}
