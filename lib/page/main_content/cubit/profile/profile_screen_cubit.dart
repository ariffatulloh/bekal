import 'package:bekal/page/main_content/cubit/profile/profile_screen_cubit_state.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:bekal/payload/response/PayloadResponseLogin.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/repository/auth_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenCubitState> {
  ProfileScreenCubit() : super(InitialStateProfileScreenCubitState());
  ProfileRepository profileRepository = ProfileRepository();

  AuthRepository _authRepository = AuthRepository();
  Future<void> LoadMyProfileDashboard() async {
    emit(Loading());
    var token = await SecureStorage().getToken();
    profileRepository.myProfileDashboard(token!).then((value) async {
      PayloadResponseMyProfileDashboard? data = value.data;
      print(data!.emailUser);
      print(data.myOutlets!.length);
      emit(LoadProfileSukses(data: data));
    }).catchError((e) async {
      print("catch");
      // try {
      //   emit(FailedLogin(message: "Silahkan Check Koneksi Internet Anda"));
      //   await Future.delayed(const Duration(seconds: 3));
      //
      //   emit(InitialLoginState());
      // } catch (err) {
      //   if (kDebugMode) {
      //     print("catch");
      //   }
      // }
      // print("catch ${e}");
      // emit(FailGetProfile("Silahkan Login"));
    });
  }

  void reLogin(PayloadRequestLogin data, bool rememberme,
      {required int indexMenu}) {
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
        LoadMyProfileDataPribadi(indexMenu: indexMenu);
      } else {
        print("Login fail : message  ${value.errorMessage}");
        emit(GoTo("LOGIN"));
      }
    }).catchError((e) async {
      emit(GoTo("LOGIN"));
    });
  }

  Future<void> LoadMyProfileDataPribadi({required int indexMenu}) async {
    emit(Loading());
    var token = await SecureStorage().getToken();
    profileRepository.getProfile(token!).then((value) async {
      // print("this ${value}");
      PayloadResponseProfile? data = value.data;
      if (data != null) {
        emit(LoadDataPribadiSukses(data: data, indexMenu: indexMenu));
      } else {
        if (value.status == "Token Expired") {
          print("Token Expired");
          if (SecureStorage().getRememberLogin() == "true") {
            var email = await SecureStorage().getEmail();
            var password = await SecureStorage().getPassword();
            reLogin(
                PayloadRequestLogin(email: email!, password: password!), true,
                indexMenu: indexMenu);
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
