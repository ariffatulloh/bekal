import 'package:bekal/page/auth/cubit/register/register_cubit.dart';
import 'package:bekal/page/auth/cubit/register/register_cubit_state.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/utility_ui/AnimationConfig.dart';
import 'package:bekal/page/utility_ui/PropAnimation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_animations/stateless_animation/custom_animation.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:sizer/sizer.dart';

import 'RegisterForm.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<RegisterCubit>(
        create: (context) => RegisterCubit(),
        child: Scaffold(body: BlocBuilder<RegisterCubit, RegisterCubitState>(
          builder: (cubitContext, cubitState) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: res(context, cubitState),
              ),
            );
          },
        )));
  }
}

Widget res(context, RegisterCubitState cubitState) {
  return CustomAnimation<TimelineValue<PropsLoadUiRegister>>(
    control: CustomAnimationControl.play,
    tween: AnimationConfig().AnimationLoadUiRegister(context),
    builder: (context, child, value) {
      return Stack(
        children: [
          Positioned(
            top: .2.h,
            // -MediaQuery.of(context).size.width * .17
            right: -17.w,
            // MediaQuery.of(context).size.width * .4
            height:
                value.get(PropsLoadUiRegister.positionBackground1HeighWidth),
            width: value.get(PropsLoadUiRegister.positionBackground1HeighWidth),
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Color.fromRGBO(243, 146, 0, .5),
                  boxShape: NeumorphicBoxShape.circle(),
                  oppositeShadowLightSource: false,
                  depth: -.2.h,
                  intensity: 1),
            ),
          ),
          Positioned(
            top: 10.h,
            // -MediaQuery.of(context).size.width * .17
            left: 30.w,
            // MediaQuery.of(context).size.width * .4
            height: value
                .get(PropsLoadUiRegister.positionSmallBackground1HeighWidth),
            width: value
                .get(PropsLoadUiRegister.positionSmallBackground1HeighWidth),
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Color.fromRGBO(243, 146, 0, .5),
                  boxShape: NeumorphicBoxShape.circle(),
                  oppositeShadowLightSource: false,
                  depth: -.2.h,
                  intensity: 1),
            ),
          ),
          Positioned(
            top: 30.h,
            // -MediaQuery.of(context).size.width * .17
            right: 30.w,
            // MediaQuery.of(context).size.width * .4
            height: value
                .get(PropsLoadUiRegister.positionSmallBackground2HeighWidth),
            width: value
                .get(PropsLoadUiRegister.positionSmallBackground2HeighWidth),
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Color.fromRGBO(243, 146, 0, .5),
                  boxShape: NeumorphicBoxShape.circle(),
                  oppositeShadowLightSource: false,
                  depth: -.2.h,
                  intensity: 1),
            ),
          ),
          Positioned(
            top: 35.h,
            // -MediaQuery.of(context).size.width * .17
            left: -17.w,
            // MediaQuery.of(context).size.width * .4
            height:
                value.get(PropsLoadUiRegister.positionBackground2HeighWidth),
            width: value.get(PropsLoadUiRegister.positionBackground2HeighWidth),
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Color.fromRGBO(243, 146, 0, .5),
                  boxShape: NeumorphicBoxShape.circle(),
                  oppositeShadowLightSource: false,
                  depth: -.2.h,
                  intensity: 1),
            ),
          ),
          Positioned(
            bottom: 0,
            // -MediaQuery.of(context).size.width * .17
            right: 0,
            // MediaQuery.of(context).size.width * .4
            height:
                value.get(PropsLoadUiRegister.positionBackground3HeighWidth),
            width: value.get(PropsLoadUiRegister.positionBackground3HeighWidth),
            child: Stack(
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                        topLeft: Radius.circular(value.get(
                            PropsLoadUiRegister.positionBackground3HeighWidth)),
                      )),
                      color: Color.fromRGBO(243, 146, 0, .5),
                      oppositeShadowLightSource: false,
                      depth: -.2.h,
                      intensity: 1),
                  padding: EdgeInsets.all(0),
                  // pressed: true,

                  child: Stack(
                    children: [
                      Positioned(
                        right: -value.get(
                            PropsLoadUiRegister.positionBackground3HeighWidth),
                        bottom: -value.get(
                            PropsLoadUiRegister.positionBackground3HeighWidth),
                        child: SpinKitPulse(
                          color: Color.fromRGBO(255, 255, 255, .5),
                          size: value.get(PropsLoadUiRegister
                                  .positionBackground3HeighWidth) *
                              2,
                        ),
                      ),

                      // Container(
                      //   color: Colors.black,
                      //   width: (120 * 120) / 3.14,
                      //   height: (120 * 120) / 3.14,
                      //   child: SpinKitPulse(
                      //     color: Color.fromRGBO(255, 255, 255, 1.0),
                      //     size: 60,
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: value.get(PropsLoadUiRegister
                                      .positionBackground3HeighWidth) /
                                  3.5,
                              left: value.get(PropsLoadUiRegister
                                      .positionBackground3HeighWidth) /
                                  3.5),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    print("chuk");

                    context.read<ControllerPageCubit>().goto("LOGIN");
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .1,
            left: MediaQuery.of(context).size.width * .1,
            right: MediaQuery.of(context).size.width * .1,
            child: Container(
              child: Column(
                children: [
                  _logoWidget(),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                      child: Column(
                    children: [
                      // NeumorphicButton(
                      //   style: NeumorphicStyle(
                      //       shape: NeumorphicShape.convex,
                      //       color: Color.fromRGBO(
                      //           243, 146, 0, 1),
                      //       boxShape: NeumorphicBoxShape
                      //           .stadium(),
                      //       depth: 1,
                      //       intensity: .8),
                      //   child: Container(
                      //       width: 100,
                      //       height: 30,
                      //       child: Center(
                      //         child: Text(
                      //           "deleteToken",
                      //           style: TextStyle(
                      //               color: Colors.white),
                      //         ),
                      //       )),
                      //   onPressed: () {
                      //     LoginCubitcontext.read<LoginCubit>()
                      //         .deleteStorageToken();
                      //   },
                      // ),
                      RegisterForm(),
                    ],
                  )),
                ],
              ),
              // child: ContactForm(),
            ),
          ),
          Container(
            child: showAnotherWidget(state: cubitState, context: context),
          ),
        ],
      );
    },
  );
}

loadingFull(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
    child: SpinKitFadingCube(
      color: Colors.white,
    ),
  );
}

showAnotherWidget(
    {required RegisterCubitState state, required BuildContext context}) {
  var valueState = state;
  if (valueState is LOADING) {
    return loadingFull(context);
  } else if (valueState is GotoVerifiedAccount) {
    context.read<ControllerPageCubit>().goto("VERIFIED_ACCOUNT");
    return null;
  } else if (valueState is GotoHome) {
    context.read<ControllerPageCubit>().goto("HOME");
    return null;
  } else if (valueState is REGISTER_FAILED) {
    String message = state is REGISTER_FAILED ? state.Message! : "";
    return notifError(context, message);
  } else {
    return null;
  }
  // switch (valueState.toString()) {
  //   case "LOADING":
  //     return loadingFull(context);
  //   case "GotoVerifiedAccount":
  //     context.read<ControllerPageCubit>().goto("VERIFIED_ACCOUNT");
  //     return null;
  //   case "GOTO_HOME":
  //     context.read<ControllerPageCubit>().goto("HOME");
  //     return null;
  //   case "REGISTER_FAILED":
  //     // context.read<ControllerPageCubit>().goto("HOME");
  //     String message = state is REGISTER_FAILED ? state.Message! : "";
  //     return notifError(context, message);
  //   default:
  //     return null;
  // }
}

notifError(BuildContext context, String description) {
  return Positioned(
    right: 0,
    child: Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Container(
              child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 30, left: 0),
                decoration: new BoxDecoration(
                  color: Colors.redAccent.withOpacity(.8),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // To make the card compact
                  children: <Widget>[
                    Neumorphic(
                      padding: EdgeInsets.all(5),
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(), depth: 0),
                      child: Icon(
                        Icons.error,
                        color: Colors.deepOrange,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'ghotic',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        )
      ],
    ),
  );
}

Widget _logoWidget() {
  return Neumorphic(
    padding: EdgeInsets.all(3.h),
    style: NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: .2.h,
        intensity: .7),
    child: Image.asset(
      'assets/logokabelv2.png',
      width: 20.h,
      height: 10.h,
      fit: BoxFit.contain,
    ),
  );
}
