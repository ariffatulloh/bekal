import 'dart:io';

import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestCreateStore.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
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

class DialogBuatToko extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogBuatToko({
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
                  ? FormBuatToko(
                      cubitContext: cubitDataPribadiContext,
                      data: null,
                      onDismiss: (dismiss) {
                        if (dismiss) {
                          print("x");
                          onDismiss!(dismiss);
                          // Navigator.of(context).pop();
                        }
                      })
                  : LoadingContent(
                      child: FormBuatToko(
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

class FormBuatToko extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;
  final ValueChanged<bool>? onDismiss;

  FormBuatToko({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormBuatToko createState() => _FormBuatToko(data: data);
}

class _FormBuatToko extends State<FormBuatToko> {
  PayloadResponseProfile? data;
  String nameStoreField = "";
  String addressStoreField = "";
  String phoneNumberField = "";
  String detailAddressStoreField = "";
  String status = "";

  bool buttonSaveVisible = false;

  bool nameStoreChange = false;
  bool addressStoreChange = false;
  bool phoneNumberChange = false;
  bool detailAddressStoreChange = false;

  String? imageError = "";
  File? _image;

  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  _FormBuatToko({this.data});

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

    // print(emailField);
    _imgFromCamera() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      double sizeInMb = await image!.length() / (1024 * 1024);
      print(sizeInMb);
      setState(() {
        if (image != null) {
          if (sizeInMb > 2) {
            imageError = "Maksimal file 2Mb";
          } else {
            _image = File(image.path);
          }
        }
      });
    }

    //
    _imgFromGallery() async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      double sizeInMb = await image!.length() / (1024 * 1024);
      print(sizeInMb);
      setState(() {
        if (image != null) {
          if (sizeInMb > 2) {
            imageError = "Maksimal file 2Mb";
          } else {
            _image = File(image.path);
          }
        }
      });
    }

    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Poto Profil",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Container(
                                    child: imageError!.isNotEmpty
                                        ? Tooltip(
                                            preferBelow: false,
                                            triggerMode: TooltipTriggerMode.tap,
                                            waitDuration:
                                                const Duration(seconds: 0),
                                            showDuration:
                                                const Duration(seconds: 2),
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            // decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                                            message: imageError,
                                            child: Icon(
                                              Icons.info,
                                              color: Colors.red,
                                              size: 3.h,
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: PopupMenuButton(
                                    onSelected: (String value) {
                                      if (value == 'fromCamera') {
                                        _imgFromCamera();
                                      } else {
                                        _imgFromGallery();
                                      }
                                    },
                                    child: Neumorphic(
                                        padding: EdgeInsets.all(0),
                                        style: NeumorphicStyle(
                                            color: Colors.white,
                                            shape: NeumorphicShape.flat,
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            depth: -.2.h,
                                            intensity: 1),
                                        child: Container(
                                          width: 3.w.h,
                                          height: 3.w.h,
                                          child: AspectRatio(
                                            aspectRatio: 1.w / 1.w,
                                            child: _image != null
                                                ? Image(
                                                    image: FileImage(_image!),
                                                    fit: BoxFit
                                                        .cover, // use this
                                                  )
                                                : Align(
                                                    alignment: Alignment.center,
                                                    child: NeumorphicIcon(
                                                      Icons.camera_alt_outlined,
                                                      size: 1.w.h,
                                                      style: NeumorphicStyle(
                                                        depth: .05.w.h,
                                                        surfaceIntensity: 1,
                                                        intensity: 1,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        )),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'fromCamera',
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child:
                                                    Icon(Icons.store_rounded),
                                              ),
                                              Text(
                                                "Ambil Dari Camera",
                                                style: TextStyle(
                                                  fontFamily: 'ghotic',
                                                  fontSize: 10.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'fromGallery',
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Icon(
                                                    Icons.visibility_outlined),
                                              ),
                                              Text(
                                                "Ambil Dari Gallery",
                                                style: TextStyle(
                                                  fontFamily: 'ghotic',
                                                  fontSize: 10.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ];
                                    }),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " (tekan poto profil untuk ubah)",
                                  style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  title: "Nama Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError: "Silahkan Masukan Nama Toko",
                                  isError: nameStoreField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      nameStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      nameStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  title: "Alamat Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError: "Silahkan Masukan Alamat Toko",
                                  isError: addressStoreField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      addressStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      addressStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              WidgetTextField(
                                  title: "Nomor Handphone Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError:
                                      "Silahkan Masukan Nomor Handphone Toko",
                                  isError: phoneNumberField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      phoneNumberField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      phoneNumberField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  title: "Detail Alamat Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError:
                                      "Silahkan Masukan Detail Alamat Toko",
                                  isError: detailAddressStoreField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      detailAddressStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      detailAddressStoreField = value!;
                                      buttonSaveVisible = true;
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 1.h,
              ),
              nameStoreField.isNotEmpty &&
                      addressStoreField.isNotEmpty &&
                      phoneNumberField.isNotEmpty &&
                      detailAddressStoreField.isNotEmpty &&
                      _image != null
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
                            "Buat",
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.white),
                          ),
                        ]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var param = PayloadRequestCreateStore(
                                nameStore: nameStoreField,
                                addressStore: addressStoreField,
                                phoneNumber: phoneNumberField,
                                detailAddressStore: detailAddressStoreField,
                                status: "true");
                            print("saved true");

                            // var param = PayloadRequestUpdateEmail(
                            //     existingEmail: data!.email,
                            //     newEmail: emailField);

                            // widget.onDismiss!(true);
                            BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                    context)
                                .createStore(param: param, file: _image)
                                .then((value) {
                              if (value) {
                                print("sukses");

                                widget.onDismiss!(true);
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
