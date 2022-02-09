import 'dart:io';
import 'dart:math' as math;

import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/LoadingContent.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePersonalInformation.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class DialogUbahDataPribadi extends StatelessWidget {
  const DialogUbahDataPribadi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider<ProfileScreenDataPribadiCubit>(
        create: (context) => ProfileScreenDataPribadiCubit(),
        child: BlocBuilder<ProfileScreenDataPribadiCubit,
            ProfileScreenDataPribadiCubitState>(
          builder: (cubitDataPribadiContext, cubitDataPribadiState) {
            if (cubitDataPribadiState is InitialDataPribadiState) {
              cubitDataPribadiContext
                  .read<ProfileScreenDataPribadiCubit>()
                  .LoadMyProfileDataPribadi();
            }

            return cubitDataPribadiState is LoadDataPribadiStateSukses
                ? FormDataPribadi(
                    cubitContext: cubitDataPribadiContext,
                    data: cubitDataPribadiState.data!,
                  )
                : LoadingContent(
                    child: FormDataPribadi(
                    cubitContext: cubitDataPribadiContext,
                    data: null,
                  ));
          },
        ),
      ),
    );
  }
}

class FormDataPribadi extends StatefulWidget {
  final BuildContext cubitContext;
  final PayloadResponseProfile? data;

  FormDataPribadi({required this.cubitContext, this.data});

  @override
  _FormDataPribadi createState() => _FormDataPribadi(data: data);
}

class _FormDataPribadi extends State<FormDataPribadi> {
  PayloadResponseProfile? data;
  String fullNameField = "";
  String phoneNumberField = "";
  String addressField = "";
  bool fullNameChange = false;
  bool phoneNumberChange = false;
  bool addressChange = false;
  dynamic cubitContext;

  final _formKey = GlobalKey<FormState>();

  File? _image;

  _FormDataPribadi({this.data});
  String? imageError = "";

  @override
  Widget build(BuildContext context) {
    cubitContext = widget.cubitContext;
    // if (_image == null) {
    //   _image = AssetImage('assets/images/propic_sample.jpg');
    // }
    if (data != null) {
      if (!fullNameChange) {
        fullNameField = data!.fullName;
      }
      if (!phoneNumberChange) {
        phoneNumberField = data!.profile.phoneNumber!;
      }
      if (!addressChange) {
        addressField = data!.profile.address!;
      }
    }

    // print(fullNameField);
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
      child: SingleChildScrollView(
        child: Column(
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
                          waitDuration: const Duration(seconds: 0),
                          showDuration: const Duration(seconds: 2),
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
                          boxShape: NeumorphicBoxShape.circle(),
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
                                  fit: BoxFit.cover, // use this
                                )
                              : data!.profile.image != null
                                  ? Image(
                                      image: NetworkImage(
                                          "${data!.profile.image!}?dummy=${math.Random().nextInt(999)}"),
                                      fit: BoxFit.cover, // use this
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
                              padding: const EdgeInsets.all(5),
                              child: Icon(Icons.store_rounded),
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
                              padding: const EdgeInsets.all(5),
                              child: Icon(Icons.visibility_outlined),
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
                initialValue: fullNameField,
                title: "Nama Lengkap",
                obSecure: false,
                icon: Icons.person,
                messageError: "Silahkan Masukan Nama Lengkap",
                isError: fullNameField.isEmpty,
                // isError: fullNameField.isEmpty,
                onChanged: (String? value) {
                  setState(() {
                    fullNameField = value!;
                    if (data != null) {
                      if (fullNameField != data!.fullName) {
                        fullNameChange = true;
                      } else {
                        fullNameChange = false;
                      }
                    }
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    fullNameField = value!;
                    if (data != null) {
                      if (fullNameField != data!.fullName) {
                        fullNameChange = true;
                      } else {
                        fullNameChange = false;
                      }
                    }
                  });
                },
                keyboardtype: TextInputType.text),
            SizedBox(
              height: 1.h,
            ),
            WidgetTextField(
                initialValue: phoneNumberField,
                title: "Nomor Handphone",
                obSecure: false,
                icon: Icons.person,
                messageError: "Silahkan Masukan Nomor Handphone",
                isError: phoneNumberField.isEmpty,
                // isError: fullNameField.isEmpty,
                onChanged: (String? value) {
                  setState(() {
                    phoneNumberField = value!;
                    if (data != null) {
                      if (phoneNumberField != data!.profile.phoneNumber!) {
                        phoneNumberChange = true;
                      } else {
                        phoneNumberChange = false;
                      }
                    }
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    phoneNumberField = value!;
                    if (data != null) {
                      if (phoneNumberField != data!.profile.phoneNumber!) {
                        phoneNumberChange = true;
                      } else {
                        phoneNumberChange = false;
                      }
                    }
                  });
                },
                keyboardtype: TextInputType.number),
            SizedBox(
              height: 1.h,
            ),
            WidgetTextField(
              initialValue: addressField,
              title: "Alamat",
              obSecure: false,
              icon: Icons.person,
              messageError: "Silahkan Masukan Alamat",
              isError: addressField.isEmpty,
              // isError: fullNameField.isEmpty,
              onChanged: (String? value) {
                setState(() {
                  addressField = value!;
                  if (data != null) {
                    if (addressField != data!.profile.address!) {
                      addressChange = true;
                    } else {
                      addressChange = false;
                    }
                  }
                });
              },
              onSaved: (String? value) {
                setState(() {
                  addressField = value!;
                  if (data != null) {
                    if (addressField != data!.profile.address) {
                      addressChange = true;
                    } else {
                      addressChange = false;
                    }
                  }
                });
              },
              keyboardtype: TextInputType.multiline,
            ),
            SizedBox(
              height: 2.h,
            ),
            fullNameChange ||
                    phoneNumberChange ||
                    addressChange ||
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
                          "Simpan",
                          style:
                              TextStyle(fontSize: 10.sp, color: Colors.white),
                        ),
                      ]),
                      onPressed: () {
                        // _formKey.currentState!.save();
                        // print(
                        //     "$fullNameField $phoneNumberField $addressField ");
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          var param = PayloadRequestUpdatePersonalInformation(
                              fullName: fullNameField,
                              phoneNumber: phoneNumberField,
                              address: addressField);
                          // double sizeInMb = await _image!.length() / (1024 * 1024);
                          // print("images new" + _image.path);
                          BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                  context)
                              .updateDataPribadi(param: param, file: _image);
                        }
                      },
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
