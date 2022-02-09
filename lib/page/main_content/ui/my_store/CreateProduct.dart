import 'dart:io';

import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class CreateProduct extends StatefulWidget {
  CreateProduct();
  @override
  _CreateProduct createState() => _CreateProduct();
}

class _CreateProduct extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  List<File> _listImageGallery = [];
  File? imageThumbnail;
  int imageGallerySelected = 0;
  String nameStoreField = "";
  bool buttonSaveVisible = false;
  String priceProductField = "";
  String stockProductField = "";
  String descProductField = "";
  String? imageError = "";
  @override
  Widget build(BuildContext context) {
    // File? _image;
    if (imageThumbnail == null) {
      imageError = "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
    }
    _imgFromCamera(
        {bool isThumbnail = false, bool isGalleryImmage = false}) async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      double sizeInMb = await image!.length() / (1024 * 1024);
      print(sizeInMb);
      setState(() {
        if (image != null) {
          if (sizeInMb > 2) {
            imageError =
                "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
          } else {
            // _image = File(image.path);
            setState(() {
              if (isGalleryImmage) {
                _listImageGallery.add(File(image.path));
              }
              if (isThumbnail) {
                imageThumbnail = File(image.path);
              }
            });
          }
        }
      });
    }

    //
    _imgFromGallery(
        {bool isThumbnail = false, bool isGalleryImmage = false}) async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      double sizeInMb = await image!.length() / (1024 * 1024);
      print(sizeInMb);
      setState(() {
        if (image != null) {
          if (sizeInMb > 2) {
            imageError =
                "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
          } else {
            // _image = File(image.path);
            setState(() {
              if (isGalleryImmage) {
                _listImageGallery.add(File(image.path));
              }
              if (isThumbnail) {
                imageThumbnail = File(image.path);
              }
            });
          }
        }
      });
    }

    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: NeumorphicButton(
            padding: EdgeInsets.all(0.w.h),
            style: NeumorphicStyle(
              // shape: NeumorphicShape.convex,
              color: Colors.transparent,
              boxShape: NeumorphicBoxShape.circle(),
              depth: .0.w.h,
              // surfaceIntensity: .5,
              // intensity: 1
            ),
            child: Wrap(children: [
              NeumorphicIcon(
                Icons.cancel_rounded,
                style: NeumorphicStyle(
                  // color: Colors.white70,
                  depth: .1.h,
                  surfaceIntensity: .3,
                  intensity: 1,
                ),
                size: 10.w,
              ),
            ]),
            onPressed: () {
              // if (whenClosed != null) {
              //   whenClosed(true);
              Future.delayed(Duration(milliseconds: 1), () {
                Navigator.of(context).pop();
              });
              // }
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            width: 100.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.w),
                    topRight: Radius.circular(5.w))),
            child: Column(
              children: [
                Container(
                  width: 90.w,
                  height: 90.w - 15.w,
                  child: Row(
                    children: [
                      Expanded(
                          child: _listImageGallery.length > 0
                              ? PhotoView(
                                  imageProvider: FileImage(
                                      _listImageGallery[imageGallerySelected]),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: Colors.red,
                                      size: 2.w.h,
                                    ),
                                    Text(
                                      "Silahkan tambah gambar dan pastikan gambar kurang dari 2Mb",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                )),
                      Container(
                        width: 15.w,
                        padding: EdgeInsets.symmetric(horizontal: 0.5.w),

                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PopupMenuButton(
                                onSelected: (String value) {
                                  if (value == 'fromCamera') {
                                    _imgFromCamera(isGalleryImmage: true);
                                  } else {
                                    _imgFromGallery(isGalleryImmage: true);
                                  }
                                },
                                child: Neumorphic(
                                  padding: EdgeInsets.all(0),
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.all(
                                            Radius.circular(.3.w.h))),
                                    depth: .04.w.h,
                                  ),
                                  child: NeumorphicIcon(
                                    Icons.add,
                                    style: NeumorphicStyle(
                                      color: Colors.black38,
                                      depth: .3.h,
                                      surfaceIntensity: .3,
                                      intensity: 1,
                                    ),
                                    size: 1.5.w.h,
                                  ),
                                ),
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
                                            child:
                                                Icon(Icons.visibility_outlined),
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Expanded(
                              child: MasonryGridView.count(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 1.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  // crossAxisSpacing: 1.w,
                                  itemCount: _listImageGallery.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        NeumorphicButton(
                                          padding: EdgeInsets.all(0.w.h),
                                          style: NeumorphicStyle(
                                            // shape: NeumorphicShape.convex,
                                            color: Colors.black12,
                                            boxShape: NeumorphicBoxShape
                                                .roundRect(BorderRadius.all(
                                                    Radius.circular(.3.w.h))),
                                            depth: .04.w.h,
                                            // surfaceIntensity: .5,
                                            // intensity: 1
                                          ),
                                          child: NeumorphicIcon(
                                            Icons.remove_circle,
                                            style: NeumorphicStyle(
                                              color: Colors.red,
                                              depth: .3.h,
                                              surfaceIntensity: .3,
                                              intensity: 1,
                                            ),
                                            size: .7.w.h,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listImageGallery.removeAt(index);
                                            });
                                            // if (whenClosed != null) {
                                            //   whenClosed(true);
                                            // Future.delayed(Duration(milliseconds: 1), () {
                                            //   Navigator.of(context).pop();
                                            // });
                                            // }
                                          },
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        NeumorphicButton(
                                          padding: EdgeInsets.all(0.w.h),
                                          style: NeumorphicStyle(
                                            // shape: NeumorphicShape.convex,
                                            color: Colors.transparent,
                                            boxShape: NeumorphicBoxShape
                                                .roundRect(BorderRadius.all(
                                                    Radius.circular(.3.w.h))),
                                            depth: .04.w.h,
                                            // surfaceIntensity: .5,
                                            // intensity: 1
                                          ),
                                          child: Image(
                                            image: FileImage(_listImageGallery
                                                .elementAt(index)),
                                            fit: BoxFit.fill, // use this
                                            width: 1.5.w.h,
                                            height: 1.5.w.h,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              imageGallerySelected = index;
                                            });
                                            // if (whenClosed != null) {
                                            //   whenClosed(true);
                                            // Future.delayed(Duration(milliseconds: 1), () {
                                            //   Navigator.of(context).pop();
                                            // });
                                            // }
                                          },
                                        )
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Container(
                    width: 90.w,
                    child: Form(
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
                                      Column(children: [
                                        WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Nama Produk",
                                            obSecure: false,
                                            icon: Icons.person,
                                            messageError:
                                                "Silahkan Masukan Nama Produk",
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
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Gambar Thumbnail",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Container(
                                                    child: imageError!
                                                            .isNotEmpty
                                                        ? Tooltip(
                                                            preferBelow: false,
                                                            triggerMode:
                                                                TooltipTriggerMode
                                                                    .tap,
                                                            waitDuration:
                                                                const Duration(
                                                                    seconds: 0),
                                                            showDuration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            textStyle: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
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
                                                height: .5.h,
                                              ),
                                              PopupMenuButton(
                                                  onSelected: (String value) {
                                                    if (value == 'fromCamera') {
                                                      _imgFromCamera(
                                                          isThumbnail: true);
                                                    } else {
                                                      _imgFromGallery(
                                                          isThumbnail: true);
                                                    }
                                                  },
                                                  child: Neumorphic(
                                                    padding: EdgeInsets.all(0),
                                                    style: NeumorphicStyle(
                                                      boxShape: NeumorphicBoxShape
                                                          .roundRect(BorderRadius
                                                              .all(Radius
                                                                  .circular(
                                                                      .3.w.h))),
                                                      depth: .04.w.h,
                                                    ),
                                                    child:
                                                        imageThumbnail != null
                                                            ? Image(
                                                                image: FileImage(
                                                                    imageThumbnail!),
                                                                fit: BoxFit
                                                                    .fill, // use this
                                                                width: 1.5.w.h,
                                                                height: 1.5.w.h,
                                                              )
                                                            : NeumorphicIcon(
                                                                Icons.add,
                                                                style:
                                                                    NeumorphicStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  depth: .3.h,
                                                                  surfaceIntensity:
                                                                      .3,
                                                                  intensity: 1,
                                                                ),
                                                                size: 1.5.w.h,
                                                              ),
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        value: 'fromCamera',
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Icon(Icons
                                                                  .store_rounded),
                                                            ),
                                                            Text(
                                                              "Ambil Dari Camera",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'ghotic',
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
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Icon(Icons
                                                                  .visibility_outlined),
                                                            ),
                                                            Text(
                                                              "Ambil Dari Gallery",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'ghotic',
                                                                fontSize: 10.sp,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ];
                                                  }),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Stok Produk",
                                            obSecure: false,
                                            icon: Icons.person,
                                            messageError:
                                                "Silahkan Masukan Stok Produk",
                                            isError: stockProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                stockProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                stockProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false)),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Harga Produk",
                                            obSecure: false,
                                            icon: Icons.person,
                                            messageError:
                                                "Silahkan Masukan Harga Produk",
                                            isError: priceProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                priceProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                priceProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false),
                                            typeCurrency: true),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        WidgetTextField(
                                            title: "Deskripsi Produk",
                                            obSecure: false,
                                            icon: Icons.person,
                                            messageError:
                                                "Silahkan Masukan Deskripsi Produk",
                                            isError: descProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                descProductField = value!;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                descProductField = value!;
                                              });
                                            },
                                            textTitleColor: Colors.black,
                                            keyboardtype:
                                                TextInputType.multiline),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            nameStoreField.isNotEmpty &&
                                    priceProductField.isNotEmpty &&
                                    descProductField.isNotEmpty &&
                                    stockProductField.isNotEmpty
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
                                          boxShape:
                                              NeumorphicBoxShape.stadium(),
                                          depth: .2.h,
                                          surfaceIntensity: .3,
                                          intensity: .9),
                                      child: Wrap(children: [
                                        Text(
                                          "Buat",
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          print(priceProductField
                                              .toLowerCase()
                                              .replaceAll('rp', '')
                                              .replaceAll('.', ''));
                                          print(descProductField);
                                          // var param = PayloadRequestCreateStore(
                                          //     nameStore: nameStoreField,
                                          //     addressStore: addressStoreField,
                                          //     phoneNumber: phoneNumberField,
                                          //     detailAddressStore: detailAddressStoreField,
                                          //     status: "true");
                                          // print("saved true");
                                          //
                                          // // var param = PayloadRequestUpdateEmail(
                                          // //     existingEmail: data!.email,
                                          // //     newEmail: emailField);
                                          //
                                          // // widget.onDismiss!(true);
                                          // BlocProvider.of<ProfileScreenDataPribadiCubit>(
                                          //     context)
                                          //     .createStore(param: param, file: _image)
                                          //     .then((value) {
                                          //   if (value) {
                                          //     print("sukses");
                                          //
                                          //     widget.onDismiss!(true);
                                          //   }
                                          // });

                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(snackBar);

                                        }
                                      },
                                    ))
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
