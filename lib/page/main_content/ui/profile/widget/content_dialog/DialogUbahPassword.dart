import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePassword.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class DialogUbahPassword extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogUbahPassword({Key? key, this.onDismiss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileScreenDataPribadiCubit>(
      create: (context) => ProfileScreenDataPribadiCubit(),
      child: BlocBuilder<ProfileScreenDataPribadiCubit,
              ProfileScreenDataPribadiCubitState>(
          builder: (cubitDataPribadiContext, cubitDataPribadiState) {
        if (cubitDataPribadiState is InitialDataPribadiState) {
          cubitDataPribadiContext
              .read<ProfileScreenDataPribadiCubit>()
              .LoadMyProfileDataPribadi();
        }

        return Stack(
          children: [
            cubitDataPribadiState is LoadDataPribadiStateSukses
                ? FormUbahPassword(
                    cubitContext: cubitDataPribadiContext,
                    data: cubitDataPribadiState.data!,
                    onDismiss: onDismiss)
                : LoadingContent(
                    child: FormUbahPassword(
                        cubitContext: cubitDataPribadiContext,
                        data: null,
                        onDismiss: onDismiss)),
          ],
        );
      }),
    );
  }
}

class FormUbahPassword extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;
  final ValueChanged<bool>? onDismiss;

  FormUbahPassword({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormUbahPassword createState() => _FormUbahPassword(data: data);
}

class _FormUbahPassword extends State<FormUbahPassword> {
  PayloadResponseProfile? data;
  String existingPasswordField = "";
  String newPasswordField = "";
  String rePasswordField = "";
  bool showButtonSave = false;
  String existingPasswordFieldError = "";
  String newPasswordFieldError = "";
  String rePasswordFieldError = "";
  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  _FormUbahPassword({this.data});

  @override
  Widget build(BuildContext context) {
    cubitContext = widget.cubitContext;
    if (data != null) {
      // if (!existingPasswordChange) {
      //   existingPasswordField = data!.fullName;
      // }
      // if (!newPasswordChange) {
      //   newPasswordField = data!.profile.phoneNumber!;
      // }
      // if (!addressChange) {
      //   addressField = data!.profile.address!;
      // }
    }

    // print(existingPasswordField);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                WidgetTextField(
                    // initialValue: existingPasswordField,
                    title: "Password Lama",
                    obSecure: true,
                    icon: Icons.person,
                    messageError: existingPasswordFieldError.isNotEmpty
                        ? existingPasswordFieldError
                        : "Silahkan Masukan Password Lama Anda",
                    isError: existingPasswordField.isEmpty ||
                        existingPasswordFieldError.isNotEmpty,
                    // isError: existingPasswordField.isEmpty,
                    onChanged: (String? value) {
                      setState(() {
                        existingPasswordField = value!;
                        existingPasswordFieldError = "";
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        existingPasswordField = value!;
                      });
                    },
                    keyboardtype: TextInputType.text),
                SizedBox(
                  height: 1.h,
                ),
                WidgetTextField(
                    // initialValue: newPasswordField,
                    title: "Password Baru",
                    obSecure: true,
                    icon: Icons.person,
                    messageError: newPasswordFieldError.isNotEmpty
                        ? rePasswordFieldError
                        : "Silahkan Masukan Password Baru",
                    isError: newPasswordField.isEmpty ||
                        newPasswordFieldError.isNotEmpty,
                    // isError: existingPasswordField.isEmpty,
                    onChanged: (String? value) {
                      setState(() {
                        newPasswordField = value!;
                        if (newPasswordField != rePasswordField) {
                          showButtonSave = false;
                        } else {
                          showButtonSave = true;
                        }
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        newPasswordField = value!;
                        // if(newPasswordField!=rePasswordField){
                        //   newPasswordChange = false;
                        // }
                        // newPasswordChange = true;
                      });
                    },
                    keyboardtype: TextInputType.text),
                SizedBox(
                  height: 1.h,
                ),
                WidgetTextField(
                    initialValue: rePasswordField,
                    title: "Korfirmasi Ulang Password Baru",
                    obSecure: true,
                    icon: Icons.person,
                    messageError: rePasswordFieldError.isNotEmpty
                        ? rePasswordFieldError
                        : "Silahkan Korfirmasi Ulang Password Baru",
                    isError: rePasswordField.isEmpty ||
                        rePasswordField != newPasswordField ||
                        rePasswordFieldError.isNotEmpty,
                    // isError: existingPasswordField.isEmpty,
                    onChanged: (String? value) {
                      setState(() {
                        rePasswordField = value!;
                        if (newPasswordField != rePasswordField) {
                          showButtonSave = false;
                        } else {
                          showButtonSave = true;
                        }
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        rePasswordField = value!;
                        // rePasswordChange = true;
                      });
                    },
                    keyboardtype: TextInputType.text),
                SizedBox(
                  height: 1.h,
                ),
                showButtonSave
                    ? Align(
                        alignment: Alignment.topRight,
                        child: NeumorphicButton(
                          padding: EdgeInsets.only(
                              top: 6.sp,
                              bottom: 6.sp,
                              left: 12.sp,
                              right: 12.sp),
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              color: Colors.transparent,
                              boxShape: NeumorphicBoxShape.stadium(),
                              depth: .2.h,
                              surfaceIntensity: .3,
                              intensity: .9),
                          child: Wrap(children: [
                            Text(
                              "Simpan",
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ]),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var token = await SecureStorage().getToken();
                              var getDataProfile = await ProfileRepository()
                                  .myProfileDashboard(token!);
                              PayloadResponseMyProfileDashboard
                                  dataProfileDashboard;
                              if (getDataProfile != null) {
                                var dataProfile = getDataProfile.data;
                                if (dataProfile != null) {
                                  dataProfileDashboard = dataProfile;

                                  List<Map<String, dynamic>> idAccount = [];
                                  idAccount.add({
                                    "id": dataProfileDashboard.idUser,
                                    "userOrStore": 'user'
                                  });
                                  if (dataProfileDashboard.myOutlets != null) {
                                    dataProfileDashboard.myOutlets!
                                        .forEach((element) {
                                      idAccount.add({
                                        "id": element.storeId,
                                        "userOrStore": 'store'
                                      });
                                    });
                                  }
                                  List<String> subscribeTopics = [];
                                  idAccount.forEach((element) async {
                                    subscribeTopics.add(
                                        '${element['userOrStore']}-${element['id']}');
                                  });
                                }
                              }
                              var param = PayloadRequestUpdatePassword(
                                  existingPassword: existingPasswordField,
                                  newPassword: newPasswordField,
                                  rePassword: rePasswordField);
                              BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                      context)
                                  .updatePassword(param: param)
                                  .then((value) {
                                if (value) {
                                  existingPasswordFieldError = "";
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Silahkan Login Kembali Dengan Password Baru Anda'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            widget.onDismiss!(true);
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  existingPasswordFieldError =
                                      "Anda Salah Memasukan Password Lama";
                                }
                              });
                            }
                          },
                        ))
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
