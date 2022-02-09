import 'package:bekal/page/auth/cubit/register/register_cubit.dart';
import 'package:bekal/payload/request/PayloadRequestRegister.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  bool selected = false;
  String passwordField = "";
  String fullNameField = "";
  String emailField = "";
  final _formKey = GlobalKey<FormState>();
  late String _name, _age, _job;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _widgetTextField(
            title: "Nama Lengkap",
            obSecure: false,
            icon: Icons.person,
            messageError: "Silahkan Masukan Nama Lengkap",
            isError: fullNameField.isEmpty,
            onChanged: (String? value) {
              setState(() {
                fullNameField = value!;
              });
            },
            // onValidator: (value) {
            //   // validator!(value);
            //   if (value!.isEmpty) {
            //     print("Nama Lengkap ${value.isEmpty}");
            //     return false;
            //   }
            //   return true;
            // },
            onSaved: (String? value) {
              setState(() {
                fullNameField = value!;
              });
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          _widgetTextField(
              title: "Email",
              obSecure: false,
              icon: Icons.email,
              messageError: "Silahkan Masukan Email Yang Valid",
              //     var email = "tony@starkindustries.com"
              // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
              isError: emailField.isEmpty,
              // onValidator: (value) {
              //   // validator!(value);
              //   if (value!.isEmpty) {
              //     return "lengkapi email";
              //   } else {
              //     if (RegExp(
              //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //         .hasMatch(value!)) {
              //       return "Format email salah";
              //     } else {
              //       return "Format email salah";
              //     }
              //   }
              // },
              onChanged: (String? value) {
                setState(() {
                  //
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!)) {
                    emailField = value;
                  } else {
                    emailField = "";
                    print("email out regex");
                  }
                });
              },
              onSaved: (String? value) {
                setState(() {
                  emailField = value!;
                });
              }),
          SizedBox(
            height: 20,
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
            // onValidator: (value) {
            //   // validator!(value);
            //   if (value!.isEmpty) {
            //     return "Lengkapi password";
            //   }
            //   return null;
            // },
            onSaved: (String? value) {
              setState(() {
                passwordField = value!;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 30,
          ),
          _widgetRegisterButton(
            onPressed: () {
              print(_formKey.currentState!.validate());
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                PayloadRequestRegister data = PayloadRequestRegister(
                    fullName: fullNameField,
                    email: emailField,
                    password: passwordField);
                // data.email=emailField
                print(
                    "fullname: ${fullNameField},\nemail: ${emailField},\npassword: ${passwordField} ");
                context.read<RegisterCubit>().submitRegister(data);
                // print("waw");

              }
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  _widgetForgetPassword() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                "Lupa Kata Sandi?, ",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                " KLIK DISINI ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetTextField(
      {onSaved,
      title,
      messageError,
      isError,
      onChanged,
      obSecure,
      icon,
      onValidator}) {
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
                      fontWeight: FontWeight.bold,
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
        Neumorphic(
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
              contentPadding: EdgeInsets.all(0.h),
              prefixIcon: Icon(
                icon,
                size: 16.sp,
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.4), width: 0.0),
                  borderRadius: BorderRadius.circular(32)),
            ),
            validator: (value) {
              // validator!(value);
              if (value!.isNotEmpty) {
                // print(
                //     "email ${equalsIgnoreAsciiCase(title.toString(), "email")}");
                if (equalsIgnoreAsciiCase(title.toString(), "email")) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    print("email valid");
                    return null;
                  } else {
                    // print("valid");
                    // onSaved(null);
                    return "password error";
                  }
                }
                return null;
              }
              return "password error";
            },
            onSaved: (value) {
              onSaved(value);
              // this._name = value!;
            },
          ),
        ),
      ],
    );
  }

  // ButtonState state = ButtonState.init;
  bool isAnimating = true;

  _widgetRegisterButton({onPressed}) {
    // state = ButtonState.init;
    final double buttonWidth = 100;

    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: NeumorphicButton(
              padding: EdgeInsets.only(
                  top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Color.fromRGBO(243, 146, 0, 1),
                  boxShape: NeumorphicBoxShape.stadium(),
                  depth: .2.h,
                  surfaceIntensity: .1,
                  intensity: .8),
              child: Wrap(children: [
                Text(
                  "Register",
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ]),
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
