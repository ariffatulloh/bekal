import 'package:bekal/page/auth/cubit/verification/VerificationCubit.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class VerifikasiScreen extends StatefulWidget {
  @override
  VerifikasiScreenState createState() => VerifikasiScreenState();
}

class VerifikasiScreenState extends State<VerifikasiScreen> {
  // const VerifikasiProfileS({Key? key, this.email}) : super(key: key);
  // final String? email;
  TextEditingController controller = TextEditingController(text: "");
  String verificationCode = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationCubit>(
        create: (context) => VerificationCubit(),
        child: Scaffold(body:
            BlocBuilder<VerificationCubit, VerificationCubitState>(
                builder: (cubitContext, cubitState) {
          return Container(
              color: Color.fromRGBO(243, 146, 0, 1),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 80.w,
                              // color: Colors.black,
                              child: Lottie.network(
                                'https://assets6.lottiefiles.com/private_files/lf30_gcroxmlt.json',
                                // artboard: 'Truck',
                              ),
                            ),
                            Container(
                              width: 80.w,
                              child: Text(
                                "Kami Telah Mengirim Kode Verifikasi Ke Email Anda, Silahkan Masukan Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 10.sp,
                                    color: Color.fromRGBO(241, 241, 241, 1.0),
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Container(
                              width: 80.w,
                              child: PinCodeTextField(
                                onCompleted: (value) {
                                  print("onComplee ${value}");
                                  verificationCode = value;
                                },
                                appContext: context,
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                // autoFocus: true,
                                autoDisposeControllers: false,
                                hintCharacter: '-',
                                textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color: Color.fromRGBO(241, 241, 241, 1.0),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(255, 0, 0, 1.0),
                                ),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  inactiveFillColor: Colors.transparent,
                                  activeColor: Colors.white,
                                  inactiveColor: Color.fromRGBO(255, 0, 0, 1.0),
                                ),

                                // onSaved: (value) {
                                //   verificationCode = value!;
                                // },
                                onChanged: (String value) {
                                  // print(value);
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                                animationDuration: Duration(milliseconds: 300),
                                // backgroundColor: Colors.blue.shade50,
                                // enableActiveFill: true,
                                // errorAnimationController: errorController,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cubitContext
                                    .read<VerificationCubit>()
                                    .resendEmail();
                              },
                              child: Text(
                                "Kirim Ulang",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'ghotic',
                                  fontSize: 10.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            NeumorphicButton(
                              padding: EdgeInsets.only(
                                  top: 6.sp,
                                  bottom: 6.sp,
                                  left: 12.sp,
                                  right: 12.sp),
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  color: Color.fromRGBO(241, 147, 16, 1.0),
                                  boxShape: NeumorphicBoxShape.stadium(),
                                  depth: .2.h,
                                  surfaceIntensity: .1,
                                  intensity: .8),
                              child: Wrap(
                                children: [
                                  Text(
                                    "Verifikasi",
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () {
                                cubitContext
                                    .read<VerificationCubit>()
                                    .submitVerificationAccount(
                                        verificationCode);
                                // print(verificationCode);
                                // print("controller ${controller.text}");
                                // onPressed();
                              },
                            ),
                            NeumorphicButton(
                              margin: EdgeInsets.all(2.5.h),
                              padding: EdgeInsets.only(
                                  top: 6.sp,
                                  bottom: 6.sp,
                                  left: 12.sp,
                                  right: 12.sp),
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.convex,
                                  color: Color.fromRGBO(241, 147, 16, 1.0),
                                  boxShape: NeumorphicBoxShape.stadium(),
                                  depth: .2.h,
                                  surfaceIntensity: .1,
                                  intensity: .8),
                              child: Wrap(
                                children: [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () {
                                cubitContext
                                    .read<VerificationCubit>()
                                    .logout()
                                    .then((value) {
                                  if (value) {
                                    cubitContext
                                        .read<ControllerPageCubit>()
                                        .goto("LOGIN");
                                  }
                                });
                                // print(verificationCode);
                                // print("controller ${controller.text}");
                                // onPressed();
                              },
                            )
                            // SizedBox(
                            //   height: 50.h,
                            // ),
                            // LoginForm()
                          ],
                        ),
                      )),
                  Container(
                    child: showAnotherWidget(
                        state: cubitState, context: cubitContext),
                  ),
                  // notifError(
                  //     context,
                  //     "Code Telah Dikirim Ke email Ipan.prs@gmail.com",
                  //     Colors.redAccent)
                ],
              ));
          // return Stack(
          //   children: [
          //     Container(
          //         // color: Colors.red,
          //         width: 100.w,
          //         height: 100.h,
          //         color: Color.fromRGBO(243, 146, 0, 1),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             SizedBox(
          //               height: 5.h,
          //             ),
          //             Container(
          //               width: 80.w,
          //               // color: Colors.black,
          //               child: Stack(
          //                 children: [
          //                   Lottie.network(
          //                     'https://assets6.lottiefiles.com/private_files/lf30_gcroxmlt.json',
          //                     // artboard: 'Truck',
          //                   )
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: 2.5.h,
          //             ),
          //             Container(
          //               width: 80.w,
          //               child: Text(
          //                 "Kami Telah Mengirim Kode Verifikasi Ke Email Anda, Silahkan Masukan Code",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontFamily: 'ghotic',
          //                     fontSize: 10.sp,
          //                     color: Color.fromRGBO(241, 241, 241, 1.0),
          //                     fontWeight: FontWeight.w900),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 5.h,
          //             ),
          //             Container(
          //               width: 80.w,
          //               child: PinCodeTextField(
          //                 onCompleted: (value) {
          //                   print("onComplee ${value}");
          //                   verificationCode = value;
          //                 },
          //                 appContext: context,
          //                 length: 6,
          //                 obscureText: false,
          //                 animationType: AnimationType.fade,
          //                 // autoFocus: true,
          //                 autoDisposeControllers: false,
          //                 hintCharacter: '-',
          //                 textStyle: TextStyle(
          //                   fontSize: 10.sp,
          //                   color: Color.fromRGBO(241, 241, 241, 1.0),
          //                 ),
          //                 hintStyle: TextStyle(
          //                   color: Color.fromRGBO(255, 0, 0, 1.0),
          //                 ),
          //                 pinTheme: PinTheme(
          //                   shape: PinCodeFieldShape.underline,
          //                   inactiveFillColor: Colors.transparent,
          //                   activeColor: Colors.white,
          //                   inactiveColor: Color.fromRGBO(255, 0, 0, 1.0),
          //                 ),
          //
          //                 // onSaved: (value) {
          //                 //   verificationCode = value!;
          //                 // },
          //                 onChanged: (String value) {
          //                   // print(value);
          //                 },
          //                 beforeTextPaste: (text) {
          //                   print("Allowing to paste $text");
          //                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
          //                   return true;
          //                 },
          //                 animationDuration: Duration(milliseconds: 300),
          //                 // backgroundColor: Colors.blue.shade50,
          //                 // enableActiveFill: true,
          //                 // errorAnimationController: errorController,
          //               ),
          //             ),
          //             SizedBox(
          //               height: 5.h,
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 cubitContext.read<VerificationCubit>().resendEmail();
          //               },
          //               child: Text(
          //                 "Kirim Ulang",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   fontFamily: 'ghotic',
          //                   fontSize: 17.5,
          //                   color: Colors.black54,
          //                   fontWeight: FontWeight.w900,
          //                   decoration: TextDecoration.underline,
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             NeumorphicButton(
          //               style: NeumorphicStyle(
          //                   shape: NeumorphicShape.convex,
          //                   color: Color.fromRGBO(241, 147, 16, 1.0),
          //                   boxShape: NeumorphicBoxShape.stadium(),
          //                   depth: 1.2,
          //                   surfaceIntensity: .1,
          //                   intensity: .8),
          //               child: Container(
          //                   width: 200,
          //                   height: 30,
          //                   child: Center(
          //                     child: Text(
          //                       "Verifikasi",
          //                       style: TextStyle(color: Colors.white),
          //                     ),
          //                   )),
          //               onPressed: () {
          //                 cubitContext
          //                     .read<VerificationCubit>()
          //                     .submitVerificationAccount(verificationCode);
          //                 // print(verificationCode);
          //                 // print("controller ${controller.text}");
          //                 // onPressed();
          //               },
          //             )
          //           ],
          //         )),
          //     Positioned(
          //       bottom: 0,
          //       left: 0,
          //       height: 30.w,
          //       width: 30.w,
          //       child: Stack(
          //         children: [
          //           NeumorphicButton(
          //             style: NeumorphicStyle(
          //                 shape: NeumorphicShape.convex,
          //                 boxShape:
          //                     NeumorphicBoxShape.roundRect(BorderRadius.only(
          //                   topRight: Radius.circular(100),
          //                 )),
          //                 color: Color.fromRGBO(191, 189, 193, 1),
          //                 oppositeShadowLightSource: false,
          //                 depth: -3,
          //                 intensity: 1),
          //             padding: EdgeInsets.all(0),
          //             // pressed: true,
          //
          //             child: Stack(
          //               children: [
          //                 Positioned(
          //                   left: -100,
          //                   bottom: -100,
          //                   child: SpinKitPulse(
          //                     color: Color.fromRGBO(255, 255, 255, 1.0),
          //                     size: 100 * 2,
          //                   ),
          //                 ),
          //
          //                 // Container(
          //                 //   color: Colors.black,
          //                 //   width: (120 * 120) / 3.14,
          //                 //   height: (120 * 120) / 3.14,
          //                 //   child: SpinKitPulse(
          //                 //     color: Color.fromRGBO(255, 255, 255, 1.0),
          //                 //     size: 60,
          //                 //   ),
          //                 // ),
          //                 Align(
          //                   alignment: Alignment.center,
          //                   child: Container(
          //                     margin: EdgeInsets.only(
          //                         top: 100 / 3.5, right: 100 / 3.5),
          //                     child: Text(
          //                       "Logout",
          //                       style: TextStyle(
          //                           color: Color.fromRGBO(255, 255, 255, 1.0),
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //             onPressed: () {
          //               print("chuk");
          //
          //               cubitContext
          //                   .read<VerificationCubit>()
          //                   .logout()
          //                   .then((value) {
          //                 if (value) {
          //                   cubitContext
          //                       .read<ControllerPageCubit>()
          //                       .goto("LOGIN");
          //                 }
          //               });
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       child:
          //           showAnotherWidget(state: cubitState, context: cubitContext),
          //     ),
          //   ],
          // );
        })));
  }

  showAnotherWidget(
      {required VerificationCubitState state, required BuildContext context}) {
    var valueState = state;
    print(valueState);
    if (valueState is LOADING) {
      return loadingFull(context);
    } else if (valueState is GotoHome) {
      context.read<ControllerPageCubit>().goto("HOME");
      return null;
    } else if (valueState is FAILED_RESEND_CODE) {
      String message = state is FAILED_RESEND_CODE ? state.message! : "";
      return notifError(context, message, Colors.redAccent);
    } else if (valueState is SUKSES_RESEND_CODE) {
      String message = state is SUKSES_RESEND_CODE ? state.message! : "";
      return notifError(context, message, Colors.greenAccent);
    } else {
      return null;
    }
    // switch (valueState.toString()) {
    //   case "LOADING":
    //     return loadingFull(context);
    //   // case "GOTO_VERIVIED_ACCOUNT":
    //   //   context.read<ControllerPageCubit>().goto("VERIFIED_ACCOUNT");
    //   //   return null;
    //   case "GotoHome":
    //     context.read<ControllerPageCubit>().goto("HOME");
    //     return null;
    //   case "FAILED_RESEND_CODE":
    //     // context.read<ControllerPageCubit>().goto("HOME");
    //     String message = state is FAILED_RESEND_CODE ? state.message! : "";
    //     return notifError(context, message, Colors.redAccent);
    //   case "SUKSES_RESEND_CODE":
    //     // context.read<ControllerPageCubit>().goto("HOME");
    //     String message = state is SUKSES_RESEND_CODE ? state.message! : "";
    //     return notifError(context, message, Colors.greenAccent);
    //   default:
    //     return null;
    // }
  }

  notifError(BuildContext context, String description, Color color) {
    return Positioned(
        top: 30,
        right: 0,
        child: Container(
          width: 80.w,
          padding: EdgeInsets.all(1.h),
          // margin: EdgeInsets.only(top: 30, left: 0),
          decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Neumorphic(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 5.w),
                  style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(), depth: 0),
                  child: Icon(
                    color == Colors.greenAccent ? Icons.check : Icons.error,
                    color: color.withOpacity(.8),
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  description,
                  style: TextStyle(
                    color: color == Colors.greenAccent
                        ? Colors.black
                        : Colors.white,
                    fontSize: 10.sp,
                    fontFamily: 'ghotic',
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // child: Container(
  // padding: EdgeInsets.all(1.h),
  // margin: EdgeInsets.only(top: 30, left: 0),
  // decoration: new BoxDecoration(
  // color: color,
  // shape: BoxShape.rectangle,
  // borderRadius: BorderRadius.only(
  // topLeft: Radius.circular(20),
  // bottomLeft: Radius.circular(20)),
  // boxShadow: [
  // BoxShadow(
  // color: Colors.black26,
  // blurRadius: 10.0,
  // offset: const Offset(0.0, 10.0),
  // ),
  // ],
  // ),
  // child: Wrap(
  // children: [
  // Neumorphic(
  // padding: EdgeInsets.all(5),
  // style: NeumorphicStyle(
  // boxShape: NeumorphicBoxShape.circle(), depth: 0),
  // child: Icon(
  // color == Colors.greenAccent ? Icons.check : Icons.error,
  // color: color.withOpacity(.8),
  // size: 25,
  // ),
  // ),
  // SizedBox(
  // width: 10,
  // ),
  // Text(
  // description,
  // style: TextStyle(
  // color: color == Colors.greenAccent
  // ? Colors.black
  //     : Colors.white,
  // fontSize: 10.sp,
  // fontFamily: 'ghotic',
  // ),
  // ),
  // ],
  // ),
  // ),
  loadingFull(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      child: SpinKitFadingCube(
        color: Colors.white,
      ),
    );
  }
}
