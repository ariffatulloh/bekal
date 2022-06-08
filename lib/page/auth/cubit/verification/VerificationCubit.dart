import 'package:bekal/payload/request/PayloadRequestVerificationCode.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'VerificationCubitState.dart';

class VerificationCubit extends Cubit<VerificationCubitState> {
  VerificationCubit() : super(InitialVerificationState());
  ProfileRepository profileRepository = ProfileRepository();

  Future<bool> logout() async {
    emit(LOADING());
    await SecureStorage().deleteStorageToken();
    var token = await SecureStorage().getToken();
    if (token == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> resendEmail() async {
    emit(LOADING());
    var token = await SecureStorage().getToken();
    if (token != null) {
      profileRepository.getResendVerifyCode(token).then((value) async {
        var data = value.data;
        if (data != null) {
          if (data.message.toLowerCase() == "code hasben sent") {
            try {
              // removing the next line will never emit the SearchLoading()-state and no spinner is shown
              emit(SUKSES_RESEND_CODE(
                  message: "Code Telah Dikirim Ke ${data.email}"));
              await Future.delayed(Duration(seconds: 5));
              emit(InitialVerificationState());
            } catch (err, stacktrace) {}
          }
        }
      });
    }
  }

  Future<void> submitVerificationAccount(String verificationCode) async {
    emit(LOADING());
    var token = await SecureStorage().getToken();
    if (token != null) {
      profileRepository
          .submitVerifyCode(
              token,
              PayloadRequestVerificationCode(
                  verificationCode: verificationCode))
          .then((value) async {
        var data = value.data;
        if (data != null) {
          if (data.message.toLowerCase() == "your account is verified") {
            try {
              // removing the next line will never emit the SearchLoading()-state and no spinner is shown
              emit(SUKSES_RESEND_CODE(
                  message: "Akun Anda Telah Ter-Verifikasi"));
              await Future.delayed(Duration(seconds: 3));
              emit(GotoHome());
            } catch (err, stacktrace) {}
          }
        } else {
          try {
            if (value.errorMessage == "code expired") {
              emit(FAILED_RESEND_CODE(
                  message:
                      "kode verivikasi anda telah kadaluarsa \nsilahkan kirim ulang"));
            } else {
              emit(FAILED_RESEND_CODE(message: value.errorMessage));
            }
            // removing the next line will never emit the SearchLoading()-state and no spinner is shown

            await Future.delayed(Duration(seconds: 5));
            // emit(GotoHome());
          } catch (err, stacktrace) {}
        }
      });
    }
  }
}
