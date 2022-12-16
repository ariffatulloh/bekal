import 'dart:convert';
import 'dart:io';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/auth/cubit/login/login_cubit.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/utility_ui/TextFieldCustom.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/payload/request/PayloadRequestLogin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool selected = false;
  String passwordField = "";
  String emailField = "";
  bool rememberme = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _widgetTextField(
              title: "Email",
              obSecure: false,
              icon: Icons.email,
              messageError: "Silahkan Masukan Email",
              isError: emailField.isEmpty,
              onChanged: (String? value) {
                setState(() {
                  emailField = value!;
                });
              },
              onSaved: (String? value) {
                setState(() {
                  emailField = value!;
                });
              }),
          SizedBox(
            height: 2.h,
          ),
          _widgetTextField(
            title: "Password",
            obSecure: true,
            icon: Icons.password,
            messageError: "Silahkan Masukan Password",
            isError: passwordField.isEmpty,
            onChanged: (String? value) {
              setState(() {
                passwordField = value!;
              });
            },
            onSaved: (String? value) {
              setState(() {
                passwordField = value!;
              });
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                          color: rememberme ? Colors.white : Colors.black45),
                      padding: const EdgeInsets.all(3),
                      child: Icon(
                        Icons.check,
                        size: 14.sp,
                        color:
                            rememberme ? Colors.lightBlueAccent : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          rememberme = !rememberme;
                        });
                      },
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "Remember",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 3.h,
          ),
          _widgetLoginButton(
            onPressed: () {
              if (kDebugMode) {
                print(_formKey.currentState!.validate());
              }
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                PayloadRequestLogin data = PayloadRequestLogin(
                    email: emailField, password: passwordField);
                if (kDebugMode) {
                  print("email: $emailField,\npassword: $passwordField ");
                }
                context.read<LoginCubit>().buttonLogin(data, rememberme);
              }
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          _widgetForgetPassword(),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tidak Memiliki Akun?",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  NeumorphicButton(
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(
                        top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        color: Color.fromRGBO(243, 146, 0, 1),
                        boxShape: NeumorphicBoxShape.stadium(),
                        depth: .2.h,
                        intensity: .8),
                    child: Wrap(
                      children: [
                        Text(
                          "Daftar",
                          style:
                              TextStyle(fontSize: 10.sp, color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      context.read<ControllerPageCubit>().goto("REGISTER");
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ]),
          )
        ],
      ),
    );
  }

  _widgetForgetPassword() {
    return Visibility(
        visible: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lupa Kata Sandi?,",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            TextButton(
              child: Text(
                "KLIK DISINI ",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              onPressed: () {
                showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return FormForgetPassword();
                    });
              },
            )
          ],
        ));
  }

  Widget _widgetTextField(
      {onSaved, title, messageError, isError, onChanged, obSecure, icon}) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 10.sp,
                      // fontWeight: FontWeight.semi,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'ghotic',
                      color: Colors.white),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Container(
                  child: isError
                      ? Tooltip(
                          preferBelow: false,
                          triggerMode: TooltipTriggerMode.tap,
                          waitDuration: const Duration(seconds: 0),
                          showDuration: const Duration(seconds: 2),
                          textStyle: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                          message: messageError,
                          child: Icon(
                            Icons.info,
                            color: Colors.red,
                            size: 3.h,
                          ),
                        )
                      : null,
                ),
              ],
            )),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 100.w,
          child: Neumorphic(
            padding: EdgeInsets.only(left: 10),
            style: NeumorphicStyle(
                color: Colors.white,
                depth: .2.h,
                intensity: 1,
                shadowLightColor: Colors.white70,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.all(Radius.circular(100)))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              // textAlign: Alignment.centerLeft,
              style: TextStyle(fontSize: 10.sp),
              onChanged: onChanged,
              obscureText: obSecure,
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                contentPadding: EdgeInsets.only(left: 10),
                prefixIcon: Icon(
                  icon,
                  size: 16.sp,
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.4), width: 0.0),
                ),
              ),
              validator: (value) {
                // validator!(value);
                if (value!.isEmpty) {
                  if (kDebugMode) {
                    print("$title ${value.isEmpty}");
                  }
                  return "password error";
                }
                return null;
              },
              onSaved: (value) {
                onSaved(value);
                // this._name = value!;
              },
            ),
          ),
        )
      ],
    );
  }

  // ButtonState state = ButtonState.init;
  bool isAnimating = true;

  _widgetLoginButton({onPressed}) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: NeumorphicButton(
              padding: EdgeInsets.only(
                  top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
              style: NeumorphicStyle(
                depth: .2.h,
                intensity: 1,
                shape: NeumorphicShape.flat,
                shadowLightColor: Colors.white70,
                color: const Color.fromRGBO(243, 146, 0, .8),
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              child: Wrap(
                children: [
                  Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  )
                ],
              ),
              onPressed: () {
                onPressed();
              },
            )),
      ],
    );
  }

  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}

class FormForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormForgetPasswordState();
  }
}

class FormForgetPasswordState extends State<FormForgetPassword> {
  var _emailForgetCtrl = TextEditingController();
  var _codeVerifCtrl = TextEditingController();
  var _newPasswordCtrl = TextEditingController();
  var _emailForgetCtrlKey = GlobalKey<FormState>();
  var _codeVerifCtrlKey = GlobalKey<FormState>();
  var _newPasswordCtrlKey = GlobalKey<FormState>();
  String responseData = "";
  @override
  Widget build(BuildContext context) {
    Widget showWidget() {
      switch (responseData) {
        case "Code terkirim ke email":
          return Column(
            children: [
              TextFieldCustom(
                  controller: _codeVerifCtrl,
                  keys: _codeVerifCtrlKey,
                  label: "Code Verifikasi",
                  hint: "Code Verifikasi",
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              TextFieldCustom(
                  controller: _newPasswordCtrl,
                  keys: _newPasswordCtrlKey,
                  label: "Password Baru",
                  hint: "Password Baru",
                  obscureText: true,
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              NeumorphicButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text("Ubah Password"),
              )
            ],
          );
        case "code tidak sesuai":
          return Column(
            children: [
              TextFieldCustom(
                  controller: _codeVerifCtrl,
                  keys: _codeVerifCtrlKey,
                  label: "Code Verifikasi",
                  hint: "Code Verifikasi",
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              TextFieldCustom(
                  controller: _newPasswordCtrl,
                  keys: _newPasswordCtrlKey,
                  label: "Password Baru",
                  hint: "Password Baru",
                  obscureText: true,
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              NeumorphicButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text("Ubah Password"),
              )
            ],
          );
        case "code sudah kadaluarsa":
          return Column(
            children: [
              TextFieldCustom(
                  controller: _codeVerifCtrl,
                  keys: _codeVerifCtrlKey,
                  label: "Code Verifikasi",
                  hint: "Code Verifikasi",
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              TextFieldCustom(
                  controller: _newPasswordCtrl,
                  keys: _newPasswordCtrlKey,
                  label: "Password Baru",
                  hint: "Password Baru",
                  obscureText: true,
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              NeumorphicButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text("Ubah Password"),
              )
            ],
          );
        case "wait":
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.grey,
              size: 25.0,
            ),
          );
        default:
          return Center(
              child: NeumorphicButton(
            onPressed: () {
              forgetPassword();
            },
            child: Text("Lupa Sandi"),
          ));
      }
    }

    // TODO: implement build
    return SafeArea(
      top: true,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldCustom(
                  controller: _emailForgetCtrl,
                  keys: _emailForgetCtrlKey,
                  label: "Email",
                  hint: "Email",
                  fieldColor: Colors.white,
                  onChanged: (value) {
                    // setState(() {
                    //   _emailForgetCtrl.text = value;
                    // });
                  }),
              SizedBox(
                height: 1.h,
              ),
              showWidget()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> forgetPassword() async {
    setState(() {
      responseData = "wait";
    });
    var responseForget = await http.get(Uri.parse(
        "${DioClient.ipServer}/auth/forget-password/${_emailForgetCtrl.text}"));
    print(responseForget.body);
    if (responseForget.statusCode == HttpStatus.ok) {
      Toaster(context).showSuccessToast(
          jsonDecode(responseForget.body)["data"] ?? "",
          gravity: ToastGravity.CENTER);
      setState(() {
        responseData = jsonDecode(responseForget.body)["data"] ?? "";
      });
    } else {
      setState(() {
        responseData = "";
      });
    }
  }

  Future<void> resetPassword() async {
    setState(() {
      responseData = "wait";
    });
    var payloadResetPassword = {
      "codeVerifikasi": "${_codeVerifCtrl.text}",
      "email": "${_emailForgetCtrl.text}",
      "password": "${_newPasswordCtrl.text}"
    };
    var responseForget = await http.post(
        Uri.parse("${DioClient.ipServer}/auth/request-password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payloadResetPassword));
    print(responseForget.body);
    if (responseForget.statusCode == HttpStatus.ok) {
      Toaster(context).showSuccessToast(
          jsonDecode(responseForget.body)["data"] ?? "",
          gravity: ToastGravity.CENTER);
      if ("berhasil mengganti password" ==
          jsonDecode(responseForget.body)["data"]) {
        Navigator.pop(context);
      }

      setState(() {
        responseData = jsonDecode(responseForget.body)["data"] ?? "";
      });
    } else {
      setState(() {
        responseData = "";
      });
    }
  }
}
