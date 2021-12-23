import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller_page_cubit_state.dart';

class ControllerPageCubit extends Cubit<ControllerPageCubitState> {
  ControllerPageCubit() : super(SPLASH());

  void goto(String goto) {
    print("ControllerPageCubitState $goto");
    switch (goto) {
      case "LOGIN":
        return emit(LOGIN());
      case "VERIFIED_ACCOUNT":
        if (kDebugMode) {
          print("emit ControllerPageCubitState $goto");
        }
        return emit(VERIFIEDACCOUNT());

      case "HOME":
        return emit(HOME());
      case "REGISTER":
        return emit(REGISTER());
    }
  }
}
