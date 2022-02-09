import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestUpdateEmail.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

notifError(
    {required BuildContext context,
    String? description,
    required Color color}) {
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
                description!,
                style: TextStyle(
                  color:
                      color == Colors.greenAccent ? Colors.black : Colors.white,
                  fontSize: 10.sp,
                  fontFamily: 'ghotic',
                ),
              ),
            )
          ],
        ),
      ));
}

class DialogUbahEmail extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogUbahEmail({
    Key? key,
    this.onDismiss,
    // required this.notify,
    // ValueChanged<bool>? closeDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: const Color(0x54000000),
    //   body: Stack(
    //     children: <Widget>[
    //       Pinned.fromPins(
    //         Pin(start: 38.0, end: 38.0),
    //         Pin(size: 119.0, middle: 0.5008),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10.0),
    //             color: const Color(0xffffffff),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return BlocProvider<ProfileScreenDataPribadiCubit>(
      create: (context) => ProfileScreenDataPribadiCubit(),
      child: BlocBuilder<ProfileScreenDataPribadiCubit,
          ProfileScreenDataPribadiCubitState>(
        builder: (cubitDataPribadiContext, cubitDataPribadiState) {
          print(cubitDataPribadiState);
          if (cubitDataPribadiState is InitialDataPribadiState) {
            cubitDataPribadiContext
                .read<ProfileScreenDataPribadiCubit>()
                .LoadMyProfileDataPribadi();
          }

          return Stack(
            children: [
              cubitDataPribadiState is LoadDataPribadiStateSukses
                  ? FormEmail(
                      cubitContext: cubitDataPribadiContext,
                      data: cubitDataPribadiState.data!,
                      onDismiss: onDismiss)
                  : LoadingContent(
                      child: FormEmail(
                          cubitContext: cubitDataPribadiContext,
                          data: null,
                          onDismiss: onDismiss)),
            ],
          );
        },
      ),
    );
  }
}

class FormEmail extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;
  final ValueChanged<bool>? onDismiss;

  FormEmail({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormEmail createState() => _FormEmail(data: data);
}

class _FormEmail extends State<FormEmail> {
  PayloadResponseProfile? data;
  String emailField = "";

  bool emailChange = false;

  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  _FormEmail({this.data});

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar = SnackBar(
      duration: Duration(days: 1),
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    cubitContext = widget.cubitContext;
    if (data != null) {
      if (!emailChange) {
        emailField = data!.email;
      }
    }

    // print(emailField);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              WidgetTextField(
                  initialValue: emailField,
                  title: "Email",
                  obSecure: false,
                  icon: Icons.person,
                  messageError: "Silahkan Masukan Email Baru",
                  isError: emailField.isEmpty,
                  // isError: emailField.isEmpty,
                  onChanged: (String? value) {
                    setState(() {
                      emailField = value!;
                      if (data != null) {
                        if (emailField != data!.email) {
                          emailChange = true;
                        } else {
                          emailChange = false;
                        }
                      }
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      emailField = value!;
                      if (data != null) {
                        if (emailField != data!.fullName) {
                          emailChange = true;
                        } else {
                          emailChange = false;
                        }
                      }
                    });
                  },
                  keyboardtype: TextInputType.text),
              SizedBox(
                height: 1.h,
              ),
              emailChange
                  ? Align(
                      alignment: Alignment.topRight,
                      child: NeumorphicButton(
                        padding: EdgeInsets.only(
                            top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
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
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.white),
                          ),
                        ]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var param = PayloadRequestUpdateEmail(
                                existingEmail: data!.email,
                                newEmail: emailField);
                            BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                    context)
                                .updateEmail(param: param)
                                .then((value) {
                              if (value) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Silahkan Login Kembali Dengan Email Baru Anda'),
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
                              }
                            });
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);

                          }
                        },
                      ))
                  : Container(),
            ],
          ),
        ));
  }
}
