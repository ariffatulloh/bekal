import 'package:bekal/page/auth/cubit/login/login_cubit.dart';
import 'package:bekal/page/auth/cubit/login/login_cubit_state.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/utility_ui/config_wave_widget.dart';
import 'package:bekal/page/utility_ui/wave_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import 'login_form.dart';

class Login extends StatelessWidget {
  bool? fromPorduct;
  Login({Key? key, this.fromPorduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Container(),
                ),
              ),
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
                      color: const Color.fromRGBO(243, 146, 0, .8),
                      boxShape: NeumorphicBoxShape.circle()),
                  child: Container(),
                ),
              ),
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
                  child: Container(),
                ),
              ),
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
              Container(
                child: showAnotherWidget(
                    state: cubitState,
                    context: cubitContext,
                    fromPorduct: fromPorduct),
              ),
            ],
          ),
        );
      })),
    );
  }
}

showAnotherWidget(
    {required LoginCubitState state,
    required BuildContext context,
    required fromPorduct}) {
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
      'assets/newlogo.png',
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
