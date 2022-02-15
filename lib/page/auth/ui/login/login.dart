import 'package:bekal/page/auth/cubit/login/login_cubit.dart';
import 'package:bekal/page/auth/cubit/login/login_cubit_state.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/utility_ui/config_wave_widget.dart';
import 'package:bekal/page/utility_ui/wave_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import 'login_form.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CustomAnimationControl _controlAnimation = CustomAnimationControl.stop;

    // TODO: implement build
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Scaffold(body: BlocBuilder<LoginCubit, LoginCubitState>(
          builder: (cubitContext, cubitState) {
        return Container(
          color: Colors.black12,
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                  top: 20.h,
                  left: -17.w,
                  height: 50.w,
                  width: 50.w,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: .2.h,
                          intensity: 1,
                          shape: NeumorphicShape.flat,
                          shadowLightColor: Colors.white70,
                          // shadowDarkColor: Colors.white60,
                          color: const Color.fromRGBO(243, 146, 0, .8),
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Container(
                          // decoration: BoxDecoration(
                          //     color: const Color.fromRGBO(243, 146, 0, .8),
                          //     borderRadius: BorderRadius.circular(50.w)),
                          ))),
              Positioned(
                  top: 60.h,
                  left: 17.w,
                  height: 10.w,
                  width: 10.w,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: .2.h,
                          intensity: 1,
                          shape: NeumorphicShape.flat,
                          shadowLightColor: Colors.white70,
                          // shadowDarkColor: Colors.white60,
                          color: const Color.fromRGBO(243, 146, 0, .8),
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Container(
                          // decoration: BoxDecoration(
                          //     color: const Color.fromRGBO(243, 146, 0, .8),
                          //     borderRadius: BorderRadius.circular(50.w)),
                          ))),
              Positioned(
                  top: 20.h,
                  left: 70.w,
                  height: 2.h,
                  width: 2.h,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: .2.h,
                          intensity: 1,
                          shape: NeumorphicShape.flat,
                          shadowLightColor: Colors.white70,
                          // shadowDarkColor: Colors.white60,
                          color: const Color.fromRGBO(243, 146, 0, .8),
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Container(
                          // decoration: BoxDecoration(
                          //     color: const Color.fromRGBO(243, 146, 0, .8),
                          //     borderRadius: BorderRadius.circular(50.w)),
                          ))),
              Positioned(
                  top: .2.h,
                  right: -17.w,
                  height: 40.w,
                  width: 40.w,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          depth: .2.h,
                          intensity: 1,
                          shape: NeumorphicShape.flat,
                          shadowLightColor: Colors.white70,
                          // shadowDarkColor: Colors.white60,
                          color: const Color.fromRGBO(243, 146, 0, .8),
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Container(
                          // decoration: BoxDecoration(
                          //     color: const Color.fromRGBO(243, 146, 0, .8),
                          //     borderRadius: BorderRadius.circular(50.w)),
                          ))),
              Positioned(
                bottom: 0.h,
                height: 2.4.h,
                width: MediaQuery.of(context).size.width,
                child: RotatedBox(
                  quarterTurns: 0,
                  child: _waveWidget(),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _logoWidget(),
                        // SizedBox(
                        //   height: 50.h,
                        // ),
                        const LoginForm()
                      ],
                    ),
                  )),

              // Positioned(
              //   top: 10.h,
              //   left: 10.w,
              //   right: 10.w,
              //   child: Container(
              //     child: Column(
              //       children: [
              //         _logoWidget(),
              //         SizedBox(
              //           height: 50.h,
              //         ),
              //         Container(
              //           child: Column(
              //             children: [
              //               // NeumorphicButton(
              //               //   style: NeumorphicStyle(
              //               //       shape: NeumorphicShape.convex,
              //               //       color: Color.fromRGBO(243, 146, 0, 1),
              //               //       boxShape: NeumorphicBoxShape.stadium(),
              //               //       depth: 1,
              //               //       intensity: .8),
              //               //   child: Container(
              //               //       width: 100,
              //               //       height: 30,
              //               //       child: Center(
              //               //         child: Text(
              //               //           "deleteToken",
              //               //           style: TextStyle(color: Colors.white),
              //               //         ),
              //               //       )),
              //               //   onPressed: () {
              //               //     SecureStorage().deleteStorageToken();
              //               //   },
              //               // ),
              //               // getWidgetState(cubitState, cubitContext)
              //               SingleChildScrollView(child: LoginForm())
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              Container(
                child:
                    showAnotherWidget(state: cubitState, context: cubitContext),
              ),
              // gotoWidget(cubitState, cubitContext),
            ],
          ),
        );
      })),
    );
  }
}

showAnotherWidget(
    {required LoginCubitState state, required BuildContext context}) {
  var valueState = state;
  if (kDebugMode) {
    print(valueState);
  }
  if (valueState is LOADING) {
    return loadingFull(context);
  } else if (valueState is GotoVerifiedAccount) {
    context.read<ControllerPageCubit>().goto("VERIFIED_ACCOUNT");
    return null;
  } else if (valueState is GotoHome) {
    context.read<ControllerPageCubit>().goto("HOME");
    return null;
  } else if (valueState is FailedLogin) {
    String message = state is FailedLogin ? state.message! : "";
    return notifError(context, message);
  } else {
    return null;
  }
  // switch (valueState.toString()) {
  //   case "LOADING":
  //     return loadingFull(context);
  //   case "GotoVerifiedAccount":
  //     if (kDebugMode) {
  //       print("in case $valueState");
  //     }
  //     context.read<ControllerPageCubit>().goto("VERIFIED_ACCOUNT");
  //     return null;
  //   case "GotoHome":
  //     context.read<ControllerPageCubit>().goto("HOME");
  //     return null;
  //   case "FailedLogin":
  //     String message = state is FailedLogin ? state.message! : "";
  //     return notifError(context, message);
  //   default:
  //     return null;
  // }

  // switch (state.toString()) {
  //   case "Loading":
  //     return LoadingFull(context);
  //   case "LoadRegisterUI":
  //     return LoadRegisterUI(context);
  //   case "SuksesLoadRegisterUI":
  // return Container(
  //   width: MediaQuery.of(context).size.width,
  //   height: MediaQuery.of(context).size.height,
  //   decoration: BoxDecoration(
  //     color: Color.fromRGBO(243, 146, 0, 1),
  //   ),
  //   child: Register(context),
  // );
  //   case "SuksesGetProfile":
  //     return VerifikasiProfile(
  //       email: state is SuksesGetProfile ? state.responseProfile.email : null,
  //     );
  //   default:
  //     return Container();
  // }
}

notifError(BuildContext context, String description) {
  return Positioned(
    right: 0,
    child: Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 30, left: 0),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(.8),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // To make the card compact
                  children: <Widget>[
                    Neumorphic(
                      padding: const EdgeInsets.all(5),
                      style: const NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(), depth: 0),
                      child: const Icon(
                        Icons.error,
                        color: Colors.deepOrange,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'ghotic',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

loadingFull(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
    child: const SpinKitFadingCube(
      color: Colors.white,
    ),
  );
}

// getWidgetState(
//     LoginCubitState LoginCubitState, BuildContext LoginCubitcontext) {
//   var height = MediaQuery.of(LoginCubitcontext).size.height;
//   if (LoginCubitState is SuksesCheckingToken) {
//     print("checking token sukses in ui");
//     LoginCubitcontext.read<LoginCubit>().getProfile(LoginCubitState.token!);
//     return Container(
//       height: height - 150 - (height * .1) - (height * .1) - 150,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 100,
//             width: 100,
//             child: Neumorphic(
//               style: NeumorphicStyle(
//                   depth: 5, intensity: 20, color: Color.fromRGBO(1, 1, 0, .4)),
//               child: SpinKitFadingCube(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             "Loading",
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   } else if (LoginCubitState is FailCheckingToken) {
//     print("checking token fail in ui");
//     return Column(children: [
//       Text(LoginCubitState.errorMessage!),
//       LoginForm(),
//       SizedBox(
//         height: 100,
//       ),
//     ]);
//   } else if (LoginCubitState is LoadingGetProfile) {
//     print("get profile loading in ui");
//     return Container(
//       height: height - 150 - (height * .1) - (height * .1) - 150,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 100,
//             width: 100,
//             child: Neumorphic(
//               style: NeumorphicStyle(
//                   depth: 5, intensity: 20, color: Color.fromRGBO(1, 1, 0, .4)),
//               child: SpinKitFadingCube(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             "Loading",
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   } else if (LoginCubitState is SuksesGetProfile) {
//     print("get profile sukses in ui");
//     return Column(
//       children: [
//         Text(LoginCubitState.responseProfile.fullName),
//       ],
//     );
//   } else if (LoginCubitState is FailGetProfile) {
//     print("get profile fail in ui");
//     return Column(children: [Text(LoginCubitState.errorMessage!), LoginForm()]);
//   } else if (LoginCubitState is SubmitLoginLoading) {
//     print("submit login loading in ui");
//     return Container(
//       height: height - 150 - (height * .1) - (height * .1) - 150,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 100,
//             width: 100,
//             child: Neumorphic(
//               style: NeumorphicStyle(
//                   depth: 5, intensity: 20, color: Color.fromRGBO(1, 1, 0, .4)),
//               child: SpinKitFadingCube(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             "Loading",
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   } else if (LoginCubitState is SubmitLoginFail) {
//     print("submit login fail in ui");
//     return Column(children: [Text(LoginCubitState.errorMessage!), LoginForm()]);
//   } else {
//     return LoginForm();
//   }
// }

Widget _logoWidget() {
  return Neumorphic(
    padding: EdgeInsets.all(3.h),
    style: NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(),
        depth: .2.h,
        intensity: 1),
    child: Image.asset(
      'assets/logokabelv2.png',
      width: 20.h,
      height: 10.h,
      fit: BoxFit.contain,
    ),
  );
}

Widget _waveWidget() {
  return WaveWidget(
    config: CustomConfig(
      gradients: [
        [
          const Color.fromRGBO(63, 142, 252, .4),
          const Color.fromRGBO(63, 142, 252, .1)
        ],
        [
          const Color.fromRGBO(243, 146, 0, .5),
          const Color.fromRGBO(243, 146, 0, .1)
        ],
        [
          const Color.fromRGBO(233, 78, 27, .5),
          const Color.fromRGBO(233, 78, 27, .1)
        ],
        [
          const Color.fromRGBO(231, 48, 42, .5),
          const Color.fromRGBO(231, 48, 42, .1)
        ]
      ],
      durations: [18000, 9440, 10800, 6000],
      heightPercentages: [-0.20, -0.23, -.1, -.22],
      blur: const MaskFilter.blur(BlurStyle.solid, 20),
      gradientBegin: Alignment.bottomLeft,
      gradientEnd: Alignment.topRight,
    ),
    waveAmplitude: 8,
    waveFrequency: 2,
    heightPercentange: 2,
    isLoop: true,
    size: const Size(double.infinity, double.infinity),
  );
}
//
// enum ButtonState { init, submitting, completed }
