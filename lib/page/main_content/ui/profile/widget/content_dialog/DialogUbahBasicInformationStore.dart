import 'dart:io';
import 'dart:math' as math;

import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_data_pribadi_cubit_state.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/request/PayloadRequestCreateStore.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class DialogUbahBasicInformationStore extends StatelessWidget {
  final ValueChanged<bool>? onDismiss;
  final MyDashboardProfileOutlets? data;
  const DialogUbahBasicInformationStore({
    Key? key,
    this.onDismiss,
    this.data,
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
    print(data!.addressOutlet!);
    return BlocProvider<ProfileScreenDataPribadiCubit>(
        create: (context) => ProfileScreenDataPribadiCubit(),
        child: BlocBuilder<ProfileScreenDataPribadiCubit,
                ProfileScreenDataPribadiCubitState>(
            builder: (cubitDataPribadiContext, cubitDataPribadiState) {
          return FormBuatToko(
              cubitContext: cubitDataPribadiContext,
              data: data,
              onDismiss: onDismiss);
        }));
  }
}

class FormBuatToko extends StatefulWidget {
  final BuildContext cubitContext;
  final MyDashboardProfileOutlets? data;
  final ValueChanged<bool>? onDismiss;

  FormBuatToko({required this.cubitContext, this.data, this.onDismiss});

  @override
  _FormBuatToko createState() => _FormBuatToko(data: data);
}

class _FormBuatToko extends State<FormBuatToko> {
  MyDashboardProfileOutlets? data;
  String nameStoreField = "";
  String addressStoreField = "";
  String phoneNumberField = "";
  String detailAddressStoreField = "";
  String status = "";

  bool buttonSaveVisible = false;

  bool nameStoreChange = false;
  bool imageChange = false;
  bool addressStoreChange = false;
  bool phoneNumberChange = false;
  bool detailAddressStoreChange = false;
  String? imageError = "";
  dynamic cubitContext;
  final _formKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  _FormBuatToko({this.data});
  File? _image;
  @override
  Widget build(BuildContext context) {
    if (data != null) {
      if (!nameStoreChange) {
        nameStoreField = data!.nameOutlet!;
      }
      if (!addressStoreChange) {
        addressStoreField = data!.addressOutlet!;
      }
      if (!phoneNumberChange) {
        phoneNumberField = data!.phoneNumber!;
      }
      if (!detailAddressStoreChange) {
        detailAddressStoreField = data!.detailAddressStore!;
      }
    }
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
            imageChange = true;
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
            imageChange = true;
            _image = File(image.path);
          }
        }
      });
    }
    // print(emailField);

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
                                    "Foto Profil",
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
                                                : data!.image != null
                                                    ? Image(
                                                        image: NetworkImage(
                                                            "${data!.image!}?dummy=${math.Random().nextInt(999)}"),
                                                        fit: BoxFit
                                                            .cover, // use this
                                                      )
                                                    : Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: NeumorphicIcon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 1.w.h,
                                                          style:
                                                              NeumorphicStyle(
                                                            depth: .05.w.h,
                                                            surfaceIntensity: 1,
                                                            intensity: 1,
                                                            color:
                                                                Colors.black54,
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
                                  " (tekan foto profil untuk ubah)",
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
                                  initialValue: data!.nameOutlet,
                                  title: "Nama Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError: "Silahkan Masukan Nama Toko",
                                  isError: nameStoreField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      nameStoreField = value!;
                                      if (data != null) {
                                        if (nameStoreField !=
                                            data!.nameOutlet) {
                                          nameStoreChange = true;
                                        } else {
                                          nameStoreChange = false;
                                        }
                                      }
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      nameStoreField = value!;
                                      if (data != null) {
                                        if (nameStoreField !=
                                            data!.nameOutlet) {
                                          nameStoreChange = true;
                                        } else {
                                          nameStoreChange = false;
                                        }
                                      }
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  initialValue: data!.addressOutlet,
                                  title: "Alamat Toko",
                                  obSecure: false,
                                  icon: Icons.person,
                                  messageError: "Silahkan Masukan Alamat Toko",
                                  isError: addressStoreField.isEmpty,
                                  // isError: emailField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      addressStoreField = value!;
                                      if (data != null) {
                                        if (addressStoreField !=
                                            data!.addressOutlet) {
                                          addressStoreChange = true;
                                        } else {
                                          addressStoreChange = false;
                                        }
                                      }
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      addressStoreField = value!;
                                      if (data != null) {
                                        if (addressStoreField !=
                                            data!.addressOutlet) {
                                          addressStoreChange = true;
                                        } else {
                                          addressStoreChange = false;
                                        }
                                      }
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              WidgetTextField(
                                  initialValue: data!.phoneNumber,
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
                                      if (data != null) {
                                        if (phoneNumberField !=
                                            data!.phoneNumber) {
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
                                        if (phoneNumberField !=
                                            data!.phoneNumber) {
                                          phoneNumberChange = true;
                                        } else {
                                          phoneNumberChange = false;
                                        }
                                      }
                                    });
                                  },
                                  keyboardtype: TextInputType.text),
                              SizedBox(
                                height: 1.h,
                              ),
                              WidgetTextField(
                                  initialValue: data!.detailAddressStore,
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
                                      if (data != null) {
                                        if (detailAddressStoreField !=
                                            data!.detailAddressStore) {
                                          detailAddressStoreChange = true;
                                        } else {
                                          detailAddressStoreChange = false;
                                        }
                                      }
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      detailAddressStoreField = value!;
                                      if (data != null) {
                                        if (detailAddressStoreField !=
                                            data!.detailAddressStore) {
                                          detailAddressStoreChange = true;
                                        } else {
                                          detailAddressStoreChange = false;
                                        }
                                      }
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
              nameStoreChange ||
                      addressStoreChange ||
                      phoneNumberChange ||
                      imageChange ||
                      detailAddressStoreChange
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
                            var param = PayloadRequestCreateStore(
                                nameStore: nameStoreField,
                                addressStore: addressStoreField,
                                phoneNumber: phoneNumberField,
                                detailAddressStore: detailAddressStoreField,
                                idStore: data!.storeId,
                                status: "true");
                            print("saved true");

                            // var param = PayloadRequestUpdateEmail(
                            //     existingEmail: data!.email,
                            //     newEmail: emailField);
                            BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                    cubitContext)
                                .updateStore(param: param, file: _image)
                                .then((value) {
                              if (value) {
                                print("sukses");
                                widget.onDismiss!(true);
                                FocusManager.instance.primaryFocus?.unfocus();
                                // Navigator.of(context).pop();
                                setState(() {
                                  nameStoreChange = false;
                                  addressStoreChange = false;
                                  phoneNumberChange = false;
                                  detailAddressStoreChange = false;
                                  imageChange = false;
                                });
                              } else {
                                print("fail");
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
