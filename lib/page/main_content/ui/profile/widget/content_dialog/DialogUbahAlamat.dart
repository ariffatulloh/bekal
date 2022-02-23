import 'package:bekal/page/common/input_field.dart';
import 'package:bekal/page/common/master_dropdown.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePassword.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class DialogUbahAlamat extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogUbahAlamat({Key? key, this.onDismiss}) : super(key: key);

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
                ? FormUbahAlamat(
                    cubitContext: cubitDataPribadiContext,
                    data: cubitDataPribadiState.data!,
                    onDismiss: onDismiss)
                : LoadingContent(
                    child: FormUbahAlamat(
                        cubitContext: cubitDataPribadiContext,
                        data: null,
                        onDismiss: onDismiss)),
          ],
        );
      }),
    );
  }
}

class FormUbahAlamat extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;
  final ValueChanged<bool>? onDismiss;

  FormUbahAlamat({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormUbahAlamat createState() => _FormUbahAlamat(data: data);
}

class _FormUbahAlamat extends State<FormUbahAlamat> {
  PayloadResponseProfile? data;
  String existingPasswordField = "";
  String newPasswordField = "";
  String rePasswordField = "";
  bool showButtonSave = true;
  String existingPasswordFieldError = "";
  String newPasswordFieldError = "";
  String rePasswordFieldError = "";
  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  _FormUbahAlamat({this.data});

  @override
  Widget build(BuildContext context) {
    cubitContext = widget.cubitContext;
    if (data != null) {}

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputLabel("Alamat Pengiriman", required: true),
                TextInput(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  borderRadius: 20.0,
                ),
                SizedBox(
                  height: 1.h,
                ),
                MasterDropdown(
                  url: "DmsMasterData/FollowUpMethods",
                  label: "Provinsi",
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {});
                  },
                ),
                MasterDropdown(
                  url: "DmsMasterData/FollowUpMethods",
                  label: "Kabupaten/Kota",
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {});
                  },
                ),
                MasterDropdown(
                  url: "DmsMasterData/FollowUpMethods",
                  label: "Kecamatan",
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {});
                  },
                ),
                MasterDropdown(
                  url: "DmsMasterData/FollowUpMethods",
                  label: "Desa/Kelurahan",
                  borderRadius: 20.0,
                  onItemSelected: (value) {
                    setState(() {});
                  },
                ),
                inputLabel("Kode Pos", required: true),
                TextInput(
                  keyboardType: TextInputType.number,
                  borderRadius: 20.0,
                ),
                SizedBox(
                  height: 2.h,
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
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
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputLabel(String text, {bool required = false}) => Padding(
        padding: EdgeInsets.only(top: 15, bottom: 8),
        child: RichText(
          text: TextSpan(
              text: text,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                if (required)
                  TextSpan(
                    text: "*",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  )
              ]),
        ),
      );
}
