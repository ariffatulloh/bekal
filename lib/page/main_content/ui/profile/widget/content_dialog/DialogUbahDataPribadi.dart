import 'dart:async';
import 'dart:io';

import 'package:bekal/page/common/input_field.dart';
import 'package:bekal/page/common/master_dropdown.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/payload/request/PayloadRequestUpdatePersonalInformation.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

// class DialogUbahDataPribadi extends StatelessWidget {
//   DialogUbahDataPribadi({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: BlocProvider<ProfileScreenDataPribadiCubit>(
//         create: (context) => ProfileScreenDataPribadiCubit(),
//         child: BlocBuilder<ProfileScreenDataPribadiCubit,
//             ProfileScreenDataPribadiCubitState>(
//           builder: (cubitDataPribadiContext, cubitDataPribadiState) {
//             if (cubitDataPribadiState is InitialDataPribadiState) {
//               cubitDataPribadiContext
//                   .read<ProfileScreenDataPribadiCubit>()
//                   .LoadMyProfileDataPribadi();
//             }
//
//             return cubitDataPribadiState is LoadDataPribadiStateSukses
//                 ? FormDataPribadi(
//                     cubitContext: cubitDataPribadiContext,
//                     data: cubitDataPribadiState.data!,
//                   )
//                 : LoadingContent(
//                     child: FormDataPribadi(
//                     cubitContext: cubitDataPribadiContext,
//                     data: null,
//                   ));
//           },
//         ),
//       ),
//     );
//   }
// }

class FormDataPribadi extends StatefulWidget {
  FormDataPribadi();

  @override
  _FormDataPribadi createState() => _FormDataPribadi();
}

class _FormDataPribadi extends State<FormDataPribadi> {
  String fullNameField = "";
  String phoneNumberField = "";
  String addressField = "";
  bool fullNameChange = false;
  bool phoneNumberChange = false;
  bool addressChange = false;
  String provinsi = "";
  String kabupaten = "";
  String kecamatan = "";
  String desa = "";
  String kodepos = "";
  String alamat = "";
  bool isSaving = false;

  final _formKey = GlobalKey<FormState>();

  File? _image;
  late ImageProvider imageProvider;
  String? imageError = "";
  @override
  void initState() {
    getFromApi();
    super.initState();
  }

  StreamController<bool> loadData = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
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
            imageProvider = FileImage(_image!);
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
            imageProvider = FileImage(_image!);
          }
        }
      });
    }

    return StreamBuilder(
        stream: loadData.stream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: LoadingOverlay(
                      isLoading: isSaving,
                      child: Form(
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
                                          width: 20.w,
                                          height: 20.w,
                                          child: Image(
                                            image: imageProvider,
                                            errorBuilder:
                                                (context, url, error) {
                                              return new Icon(
                                                Icons.camera_alt_rounded,
                                                color: Colors.white,
                                              );
                                            },
                                            fit: BoxFit.cover,
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
                                      fullNameChange = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      fullNameField = value!;
                                      fullNameChange = true;
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
                                  messageError:
                                      "Silahkan Masukan Nomor Handphone",
                                  isError: phoneNumberField.isEmpty,
                                  // isError: fullNameField.isEmpty,
                                  onChanged: (String? value) {
                                    setState(() {
                                      phoneNumberField = value!;
                                      phoneNumberChange = true;
                                    });
                                  },
                                  onSaved: (String? value) {
                                    setState(() {
                                      phoneNumberField = value!;
                                      phoneNumberChange = true;
                                    });
                                  },
                                  keyboardtype: TextInputType.number),
                              SizedBox(
                                height: 1.h,
                              ),
                              // WidgetTextField(
                              //   initialValue: addressField,
                              //   title: "Alamat",
                              //   obSecure: false,
                              //   icon: Icons.person,
                              //   messageError: "Silahkan Masukan Alamat",
                              //   isError: addressField.isEmpty,
                              //   // isError: fullNameField.isEmpty,
                              //   onChanged: (String? value) {
                              //     setState(() {
                              //       addressField = value!;
                              //       if (data != null) {
                              //         if (addressField != data!.profile.address!) {
                              //           addressChange = true;
                              //         } else {
                              //           addressChange = false;
                              //         }
                              //       }
                              //     });
                              //   },
                              //   onSaved: (String? value) {
                              //     setState(() {
                              //       addressField = value!;
                              //       if (data != null) {
                              //         if (addressField != data!.profile.address) {
                              //           addressChange = true;
                              //         } else {
                              //           addressChange = false;
                              //         }
                              //       }
                              //     });
                              //   },
                              //   keyboardtype: TextInputType.multiline,
                              // ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: NeumorphicButton(
                                  //     padding: EdgeInsets.only(
                                  //         top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
                                  //     style: NeumorphicStyle(
                                  //         shape: NeumorphicShape.convex,
                                  //         color: isSaving
                                  //             ? Colors.grey.withOpacity(.5)
                                  //             : Colors.transparent,
                                  //         boxShape: NeumorphicBoxShape.stadium(),
                                  //         depth: .2.h,
                                  //         surfaceIntensity: .3,
                                  //         intensity: .9),
                                  //     child: Wrap(children: [
                                  //       if (isSaving)
                                  //         Padding(
                                  //           padding: EdgeInsets.only(right: 3.w),
                                  //           child: SizedBox(
                                  //             child: CircularProgressIndicator(
                                  //               color: Colors.orange,
                                  //               strokeWidth: 2,
                                  //             ),
                                  //             height: 2.h,
                                  //             width: 2.h,
                                  //           ),
                                  //         ),
                                  //       Text(
                                  //         isSaving ? "Menyimpan" : "Simpan",
                                  //         style: TextStyle(fontSize: 10.sp, color: Colors.white),
                                  //       ),
                                  //     ]),
                                  //     onPressed: () async {
                                  //       if (_formKey.currentState!.validate() && !isSaving) {
                                  //         _formKey.currentState!.save();
                                  //
                                  //         setState(() {
                                  //           isSaving = true;
                                  //         });
                                  //         // try {
                                  //         //
                                  //         //
                                  //         //   print(jsonEncode(payload));
                                  //
                                  //         //   DioResponse res = await _dio.postAsync(
                                  //         //       "/api/my/profile/address/add", payload);
                                  //         //
                                  //         //   if (res.results["code"] == 200) {
                                  //         //     Toaster(context).showSuccessToast(
                                  //         //         "Alamat berhasil disimpan",
                                  //         //         gravity: ToastGravity.CENTER);
                                  //         //     Navigator.of(context).pop();
                                  //         //   }
                                  //         // } catch (e) {
                                  //         //   Toaster(context).showErrorToast(
                                  //         //       "Terjadi kesalahan saat menyimpan data",
                                  //         //       gravity: ToastGravity.CENTER);
                                  //         // }
                                  //
                                  //         setState(() {
                                  //           isSaving = false;
                                  //         });
                                  //       }
                                  //     },
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: inputLabel("Alamat Pengiriman",
                                    required: true),
                              ),
                              TextInput(
                                  maxLines: 2,
                                  value: alamat,
                                  keyboardType: TextInputType.text,
                                  borderRadius: 20.0,
                                  onChanged: (v) {
                                    setState(() {
                                      alamat = v ?? "";
                                    });
                                  }),
                              SizedBox(
                                height: 1.h,
                              ),
                              MasterDropdown(
                                url: "/location/provinces",
                                label: "Provinsi",
                                borderRadius: 20.0,
                                value: provinsi == "0" ? "" : provinsi,
                                onItemSelected: (value) {
                                  setState(() {
                                    provinsi = value;
                                    kabupaten = "";
                                    kecamatan = "";
                                    desa = "";
                                  });
                                },
                              ),
                              MasterDropdown(
                                key: Key("kabupaten-${provinsi}"),
                                url: "/location/cities/${provinsi}",
                                label: "Kabupaten/Kota",
                                value: kabupaten == "0" ? "" : kabupaten,
                                borderRadius: 20.0,
                                onItemSelected: (value) {
                                  setState(() {
                                    kabupaten = value;
                                    kecamatan = "";
                                    desa = "";
                                  });
                                },
                              ),
                              MasterDropdown(
                                url: "/location/suburbs/${kabupaten}",
                                label: "Kecamatan",
                                key: Key("kecamatan-${kabupaten}"),
                                value: kecamatan == "0" ? "" : kecamatan,
                                borderRadius: 20.0,
                                onItemSelected: (value) {
                                  setState(() {
                                    kecamatan = value;
                                    desa = "";
                                  });
                                },
                              ),
                              MasterDropdown(
                                key: Key("desa-${kecamatan}"),
                                url: "/location/areas/${kecamatan}",
                                label: "Desa/Kelurahan",
                                value: desa == "0" ? "" : desa,
                                borderRadius: 20.0,
                                onItemSelected: (value) {
                                  setState(() {
                                    desa = value;
                                  });
                                },
                              ),
                              inputLabel("Kode Pos", required: true),
                              TextInput(
                                keyboardType: TextInputType.number,
                                borderRadius: 20.0,
                                value: kodepos,
                                onChanged: (v) {
                                  setState(() {
                                    kodepos = v ?? "";
                                  });
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              fullNameChange ||
                                      phoneNumberChange ||
                                      addressChange ||
                                      _image != null ||
                                      alamat.isNotEmpty ||
                                      desa.isNotEmpty ||
                                      kabupaten.isNotEmpty ||
                                      kodepos.isNotEmpty ||
                                      provinsi.isNotEmpty ||
                                      kecamatan.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: NeumorphicButton(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          padding: EdgeInsets.only(
                                              top: 6.sp,
                                              bottom: 6.sp,
                                              left: 12.sp,
                                              right: 12.sp),
                                          style: NeumorphicStyle(
                                              shape: NeumorphicShape.convex,
                                              color: Colors.transparent,
                                              boxShape:
                                                  NeumorphicBoxShape.stadium(),
                                              depth: .2.h,
                                              surfaceIntensity: .3,
                                              intensity: .9),
                                          child: Wrap(children: [
                                            Text(
                                              "Simpan",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white),
                                            ),
                                          ]),
                                          onPressed: () async {
                                            print('save');
                                            // _formKey.currentState!.save();
                                            // print(
                                            //     "$fullNameField $phoneNumberField $addressField ");
                                            var payload = Address(
                                                address: alamat,
                                                area_id:
                                                    int.tryParse(desa) ?? 0,
                                                area_name: "",
                                                city_id:
                                                    int.tryParse(kabupaten) ??
                                                        0,
                                                city_name: "",
                                                country_id: 1,
                                                country_name: "Indonesia",
                                                direction: "",
                                                // lat: "0.0",
                                                // lng: "0.0",
                                                postcode: kodepos,
                                                province_id:
                                                    int.tryParse(provinsi) ?? 0,
                                                province_name: "",
                                                suburb_id:
                                                    int.tryParse(kecamatan) ??
                                                        0,
                                                suburb_name: "");
                                            // // if (_formKey.currentState!.validate()) {
                                            // _formKey.currentState!.save();
                                            var param =
                                                PayloadRequestUpdatePersonalInformation(
                                                    fullName: fullNameField,
                                                    phoneNumber:
                                                        phoneNumberField,
                                                    address: payload);
                                            // // double sizeInMb = await _image!.length() / (1024 * 1024);
                                            // // print("images new" + _image.path);
                                            await ProfileRepository()
                                                .updatePersonalInformation(
                                                    await SecureStorage()
                                                        .getToken(),
                                                    param,
                                                    _image)
                                                .then((value) {
                                              if (value.code == 200) {
                                                Toaster(context)
                                                    .showSuccessToast(
                                                        "Data berhasil disimpan",
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                setState(() {
                                                  isSaving = false;
                                                });
                                              }
                                            });
                                            // .updateDataPribadi(param: param, file: _image);
                                          }
                                          // },
                                          ))
                                  : Container(),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          ),
                        ),
                      )));
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
  }

  // @override
  // Widget builds(BuildContext context) {
  //   cubitContext = widget.cubitContext;
  //
  //   if (data != null) {
  //     if (!fullNameChange) {
  //       fullNameField = data!.fullName;
  //     }
  //     if (!phoneNumberChange) {
  //       phoneNumberField = data!.profile.phoneNumber!;
  //     }
  //   }
  //
  //   // print(fullNameField);
  //   _imgFromCamera() async {
  //     XFile? image = await ImagePicker()
  //         .pickImage(source: ImageSource.camera, imageQuality: 50);
  //     double sizeInMb = await image!.length() / (1024 * 1024);
  //     print(sizeInMb);
  //     setState(() {
  //       if (image != null) {
  //         if (sizeInMb > 2) {
  //           imageError = "Maksimal file 2Mb";
  //         } else {
  //           _image = File(image.path);
  //         }
  //       }
  //     });
  //   }
  //
  //   //
  //   _imgFromGallery() async {
  //     XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     double sizeInMb = await image!.length() / (1024 * 1024);
  //     print(sizeInMb);
  //     setState(() {
  //       if (image != null) {
  //         if (sizeInMb > 2) {
  //           imageError = "Maksimal file 2Mb";
  //         } else {
  //           _image = File(image.path);
  //         }
  //       }
  //     });
  //   }
  //
  //   return Form(
  //     key: _formKey,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 "Poto Profil",
  //                 style: TextStyle(
  //                     fontSize: 10.sp,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white),
  //               ),
  //               SizedBox(
  //                 width: 1.w,
  //               ),
  //               Container(
  //                 child: imageError!.isNotEmpty
  //                     ? Tooltip(
  //                         preferBelow: false,
  //                         triggerMode: TooltipTriggerMode.tap,
  //                         waitDuration: const Duration(seconds: 0),
  //                         showDuration: const Duration(seconds: 2),
  //                         textStyle: TextStyle(
  //                             fontSize: 10.sp,
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.normal),
  //                         // decoration: BoxDecoration(
  //                         //     borderRadius: BorderRadius.circular(10), color: Colors.green),
  //                         message: imageError,
  //                         child: Icon(
  //                           Icons.info,
  //                           color: Colors.red,
  //                           size: 3.h,
  //                         ),
  //                       )
  //                     : null,
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           Align(
  //             alignment: Alignment.center,
  //             child: PopupMenuButton(
  //                 onSelected: (String value) {
  //                   if (value == 'fromCamera') {
  //                     _imgFromCamera();
  //                   } else {
  //                     _imgFromGallery();
  //                   }
  //                 },
  //                 child: Neumorphic(
  //                     padding: EdgeInsets.all(0),
  //                     style: NeumorphicStyle(
  //                         color: Colors.white,
  //                         shape: NeumorphicShape.flat,
  //                         boxShape: NeumorphicBoxShape.circle(),
  //                         depth: -.2.h,
  //                         intensity: 1),
  //                     child: Container(
  //                       width: 3.w.h,
  //                       height: 3.w.h,
  //                       child: AspectRatio(
  //                         aspectRatio: 1.w / 1.w,
  //                         child: _image != null
  //                             ? Image(
  //                                 image: FileImage(_image!),
  //                                 fit: BoxFit.cover, // use this
  //                               )
  //                             : data!.profile.image != null
  //                                 ? Image(
  //                                     image: NetworkImage(
  //                                         "${data!.profile.image!}?dummy=${math.Random().nextInt(999)}"),
  //                                     fit: BoxFit.cover, // use this
  //                                   )
  //                                 : Align(
  //                                     alignment: Alignment.center,
  //                                     child: NeumorphicIcon(
  //                                       Icons.camera_alt_outlined,
  //                                       size: 1.w.h,
  //                                       style: NeumorphicStyle(
  //                                         depth: .05.w.h,
  //                                         surfaceIntensity: 1,
  //                                         intensity: 1,
  //                                         color: Colors.black54,
  //                                       ),
  //                                     ),
  //                                   ),
  //                       ),
  //                     )),
  //                 itemBuilder: (context) {
  //                   return [
  //                     PopupMenuItem(
  //                       value: 'fromCamera',
  //                       child: Row(
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: const EdgeInsets.all(5),
  //                             child: Icon(Icons.store_rounded),
  //                           ),
  //                           Text(
  //                             "Ambil Dari Camera",
  //                             style: TextStyle(
  //                               fontFamily: 'ghotic',
  //                               fontSize: 10.sp,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuItem(
  //                       value: 'fromGallery',
  //                       child: Row(
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: const EdgeInsets.all(5),
  //                             child: Icon(Icons.visibility_outlined),
  //                           ),
  //                           Text(
  //                             "Ambil Dari Gallery",
  //                             style: TextStyle(
  //                               fontFamily: 'ghotic',
  //                               fontSize: 10.sp,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     )
  //                   ];
  //                 }),
  //           ),
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           Align(
  //             alignment: Alignment.center,
  //             child: Text(
  //               " (tekan poto profil untuk ubah)",
  //               style: TextStyle(
  //                   fontSize: 8.sp,
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.black87),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           WidgetTextField(
  //               initialValue: fullNameField,
  //               title: "Nama Lengkap",
  //               obSecure: false,
  //               icon: Icons.person,
  //               messageError: "Silahkan Masukan Nama Lengkap",
  //               isError: fullNameField.isEmpty,
  //               // isError: fullNameField.isEmpty,
  //               onChanged: (String? value) {
  //                 setState(() {
  //                   fullNameField = value!;
  //                   if (data != null) {
  //                     if (fullNameField != data!.fullName) {
  //                       fullNameChange = true;
  //                     } else {
  //                       fullNameChange = false;
  //                     }
  //                   }
  //                 });
  //               },
  //               onSaved: (String? value) {
  //                 setState(() {
  //                   fullNameField = value!;
  //                   if (data != null) {
  //                     if (fullNameField != data!.fullName) {
  //                       fullNameChange = true;
  //                     } else {
  //                       fullNameChange = false;
  //                     }
  //                   }
  //                 });
  //               },
  //               keyboardtype: TextInputType.text),
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           WidgetTextField(
  //               initialValue: phoneNumberField,
  //               title: "Nomor Handphone",
  //               obSecure: false,
  //               icon: Icons.person,
  //               messageError: "Silahkan Masukan Nomor Handphone",
  //               isError: phoneNumberField.isEmpty,
  //               // isError: fullNameField.isEmpty,
  //               onChanged: (String? value) {
  //                 setState(() {
  //                   phoneNumberField = value!;
  //                   if (data != null) {
  //                     if (phoneNumberField != data!.profile.phoneNumber!) {
  //                       phoneNumberChange = true;
  //                     } else {
  //                       phoneNumberChange = false;
  //                     }
  //                   }
  //                 });
  //               },
  //               onSaved: (String? value) {
  //                 setState(() {
  //                   phoneNumberField = value!;
  //                   if (data != null) {
  //                     if (phoneNumberField != data!.profile.phoneNumber!) {
  //                       phoneNumberChange = true;
  //                     } else {
  //                       phoneNumberChange = false;
  //                     }
  //                   }
  //                 });
  //               },
  //               keyboardtype: TextInputType.number),
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           // WidgetTextField(
  //           //   initialValue: addressField,
  //           //   title: "Alamat",
  //           //   obSecure: false,
  //           //   icon: Icons.person,
  //           //   messageError: "Silahkan Masukan Alamat",
  //           //   isError: addressField.isEmpty,
  //           //   // isError: fullNameField.isEmpty,
  //           //   onChanged: (String? value) {
  //           //     setState(() {
  //           //       addressField = value!;
  //           //       if (data != null) {
  //           //         if (addressField != data!.profile.address!) {
  //           //           addressChange = true;
  //           //         } else {
  //           //           addressChange = false;
  //           //         }
  //           //       }
  //           //     });
  //           //   },
  //           //   onSaved: (String? value) {
  //           //     setState(() {
  //           //       addressField = value!;
  //           //       if (data != null) {
  //           //         if (addressField != data!.profile.address) {
  //           //           addressChange = true;
  //           //         } else {
  //           //           addressChange = false;
  //           //         }
  //           //       }
  //           //     });
  //           //   },
  //           //   keyboardtype: TextInputType.multiline,
  //           // ),
  //           SizedBox(
  //             height: 2.h,
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               inputLabel("Alamat Pengiriman", required: true),
  //               TextInput(
  //                   maxLines: 2,
  //                   value: alamat,
  //                   keyboardType: TextInputType.text,
  //                   borderRadius: 20.0,
  //                   onChanged: (v) {
  //                     setState(() {
  //                       alamat = v ?? "";
  //                     });
  //                   }),
  //               SizedBox(
  //                 height: 1.h,
  //               ),
  //               MasterDropdown(
  //                 url: "/location/provinces",
  //                 label: "Provinsi",
  //                 borderRadius: 20.0,
  //                 value: provinsi == "0" ? "" : provinsi,
  //                 onItemSelected: (value) {
  //                   setState(() {
  //                     provinsi = value;
  //                     kabupaten = "";
  //                     kecamatan = "";
  //                     desa = "";
  //                   });
  //                 },
  //               ),
  //               MasterDropdown(
  //                 key: Key("kabupaten-${provinsi}"),
  //                 url: "/location/cities/${provinsi}",
  //                 label: "Kabupaten/Kota",
  //                 value: kabupaten == "0" ? "" : kabupaten,
  //                 borderRadius: 20.0,
  //                 onItemSelected: (value) {
  //                   setState(() {
  //                     kabupaten = value;
  //                     kecamatan = "";
  //                     desa = "";
  //                   });
  //                 },
  //               ),
  //               MasterDropdown(
  //                 url: "/location/suburbs/${kabupaten}",
  //                 label: "Kecamatan",
  //                 key: Key("kecamatan-${kabupaten}"),
  //                 value: kecamatan == "0" ? "" : kecamatan,
  //                 borderRadius: 20.0,
  //                 onItemSelected: (value) {
  //                   setState(() {
  //                     kecamatan = value;
  //                     desa = "";
  //                   });
  //                 },
  //               ),
  //               MasterDropdown(
  //                 key: Key("desa-${kecamatan}"),
  //                 url: "/location/areas/${kecamatan}",
  //                 label: "Desa/Kelurahan",
  //                 value: desa == "0" ? "" : desa,
  //                 borderRadius: 20.0,
  //                 onItemSelected: (value) {
  //                   setState(() {
  //                     desa = value;
  //                   });
  //                 },
  //               ),
  //               inputLabel("Kode Pos", required: true),
  //               TextInput(
  //                 keyboardType: TextInputType.number,
  //                 borderRadius: 20.0,
  //                 value: kodepos,
  //                 onChanged: (v) {
  //                   setState(() {
  //                     kodepos = v ?? "";
  //                   });
  //                 },
  //               ),
  //               SizedBox(
  //                 height: 2.h,
  //               ),
  //               // Align(
  //               //   alignment: Alignment.topRight,
  //               //   child: NeumorphicButton(
  //               //     padding: EdgeInsets.only(
  //               //         top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
  //               //     style: NeumorphicStyle(
  //               //         shape: NeumorphicShape.convex,
  //               //         color: isSaving
  //               //             ? Colors.grey.withOpacity(.5)
  //               //             : Colors.transparent,
  //               //         boxShape: NeumorphicBoxShape.stadium(),
  //               //         depth: .2.h,
  //               //         surfaceIntensity: .3,
  //               //         intensity: .9),
  //               //     child: Wrap(children: [
  //               //       if (isSaving)
  //               //         Padding(
  //               //           padding: EdgeInsets.only(right: 3.w),
  //               //           child: SizedBox(
  //               //             child: CircularProgressIndicator(
  //               //               color: Colors.orange,
  //               //               strokeWidth: 2,
  //               //             ),
  //               //             height: 2.h,
  //               //             width: 2.h,
  //               //           ),
  //               //         ),
  //               //       Text(
  //               //         isSaving ? "Menyimpan" : "Simpan",
  //               //         style: TextStyle(fontSize: 10.sp, color: Colors.white),
  //               //       ),
  //               //     ]),
  //               //     onPressed: () async {
  //               //       if (_formKey.currentState!.validate() && !isSaving) {
  //               //         _formKey.currentState!.save();
  //               //
  //               //         setState(() {
  //               //           isSaving = true;
  //               //         });
  //               //         // try {
  //               //         //
  //               //         //
  //               //         //   print(jsonEncode(payload));
  //               //
  //               //         //   DioResponse res = await _dio.postAsync(
  //               //         //       "/api/my/profile/address/add", payload);
  //               //         //
  //               //         //   if (res.results["code"] == 200) {
  //               //         //     Toaster(context).showSuccessToast(
  //               //         //         "Alamat berhasil disimpan",
  //               //         //         gravity: ToastGravity.CENTER);
  //               //         //     Navigator.of(context).pop();
  //               //         //   }
  //               //         // } catch (e) {
  //               //         //   Toaster(context).showErrorToast(
  //               //         //       "Terjadi kesalahan saat menyimpan data",
  //               //         //       gravity: ToastGravity.CENTER);
  //               //         // }
  //               //
  //               //         setState(() {
  //               //           isSaving = false;
  //               //         });
  //               //       }
  //               //     },
  //               //   ),
  //               // ),
  //               SizedBox(
  //                 height: 2.h,
  //               ),
  //             ],
  //           ),
  //           fullNameChange ||
  //                   phoneNumberChange ||
  //                   addressChange ||
  //                   _image != null ||
  //                   alamat.isNotEmpty ||
  //                   desa.isNotEmpty ||
  //                   kabupaten.isNotEmpty ||
  //                   kodepos.isNotEmpty ||
  //                   provinsi.isNotEmpty ||
  //                   kecamatan.isNotEmpty
  //               ? Align(
  //                   alignment: Alignment.topRight,
  //                   child: NeumorphicButton(
  //                       padding: EdgeInsets.only(
  //                           top: 6.sp, bottom: 6.sp, left: 12.sp, right: 12.sp),
  //                       style: NeumorphicStyle(
  //                           shape: NeumorphicShape.convex,
  //                           color: Colors.transparent,
  //                           boxShape: NeumorphicBoxShape.stadium(),
  //                           depth: .2.h,
  //                           surfaceIntensity: .3,
  //                           intensity: .9),
  //                       child: Wrap(children: [
  //                         Text(
  //                           "Simpan",
  //                           style:
  //                               TextStyle(fontSize: 10.sp, color: Colors.white),
  //                         ),
  //                       ]),
  //                       onPressed: () async {
  //                         print('save');
  //                         // _formKey.currentState!.save();
  //                         // print(
  //                         //     "$fullNameField $phoneNumberField $addressField ");
  //                         var payload = Address(
  //                             address: alamat,
  //                             area_id: int.tryParse(desa) ?? 0,
  //                             area_name: "",
  //                             city_id: int.tryParse(kabupaten) ?? 0,
  //                             city_name: "",
  //                             country_id: 1,
  //                             country_name: "Indonesia",
  //                             direction: "",
  //                             // lat: "0.0",
  //                             // lng: "0.0",
  //                             postcode: kodepos,
  //                             province_id: int.tryParse(provinsi) ?? 0,
  //                             province_name: "",
  //                             suburb_id: int.tryParse(kecamatan) ?? 0,
  //                             suburb_name: "");
  //                         // // if (_formKey.currentState!.validate()) {
  //                         // _formKey.currentState!.save();
  //                         var param = PayloadRequestUpdatePersonalInformation(
  //                             fullName: fullNameField,
  //                             phoneNumber: phoneNumberField,
  //                             address: payload);
  //                         // // double sizeInMb = await _image!.length() / (1024 * 1024);
  //                         // // print("images new" + _image.path);
  //                         await ProfileRepository().updatePersonalInformation(
  //                             await SecureStorage().getToken(), param, _image);
  //                         // .updateDataPribadi(param: param, file: _image);
  //                       }
  //                       // },
  //                       ))
  //               : Container(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

  Future<void> getFromApi() async {
    var dataprofile = await ProfileRepository().getProfile("");
    if (dataprofile != null) {
      PayloadResponseProfile data = dataprofile.data!;
      if (data != null) {
        fullNameField = data.fullName;

        Profile dataProfile = data.profile;
        if (dataProfile != null) {
          phoneNumberField = dataProfile.phoneNumber ?? "";
          if (_image == null) {
            imageProvider = NetworkImage(dataProfile.image ?? "");
          } else {
            imageProvider = FileImage(_image ?? File(""));
          }

          Address? dataAddress = dataProfile.address;
          if (dataAddress != null) {
            print('datapribadi load');
            provinsi = "${dataAddress.province_id}";
            kabupaten = "${dataAddress.city_id}";
            kecamatan = "${dataAddress.suburb_id}";
            desa = "${dataAddress.area_id}";
            kodepos = dataAddress.postcode ?? "";
            alamat = dataAddress.address ?? "";
            loadData.sink.add(true);
          }
        }
      }
    }
  }
}
