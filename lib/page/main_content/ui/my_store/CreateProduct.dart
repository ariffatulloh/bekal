import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/payload/request/PayloadRequestCreateProduct.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class CreateProduct extends StatefulWidget {
  int idStore = -1;

  int? idProduct;
  Function(bool) onDismiss;

  CreateProduct(
      {required this.idStore, this.idProduct, required this.onDismiss});

  @override
  CreateProductState createState() => CreateProductState();
}

class createProductCallApi {
  List<String> listCategory;
  Map<String, dynamic> dataProductExisting;

  createProductCallApi({
    required this.listCategory,
    required this.dataProductExisting,
  });
}

class CreateProductState extends State<CreateProduct> {
  bool isCallFromApiFinish = false;
  List<File> _listImageGallery = [];
  File? imageThumbnail;
  int imageGallerySelected = 0;
  String nameProductField = "";
  bool buttonSaveVisible = false;
  String priceProductField = "";
  String stockProductField = "";
  String descProductField = "";
  String heightProductField = "";
  String weightProductField = "";
  String widthProductField = "";
  String lengthProductField = "";
  String? imageError = "";

  List<String> selectedChoices = [];
  Map<String, dynamic> dataProductExistingState = Map();
  List<String> listCategoryState = [];
  String imageOverSize = "";
  var isArchived = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: 100.w,
          child: Column(
            children: [
              NeumorphicButton(
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 1), () {
                    Navigator.of(context).pop();
                    widget.onDismiss(true);
                  });
                },
                padding: EdgeInsets.all(0.w.h),
                style: NeumorphicStyle(
                  // shape: NeumorphicShape.convex,
                  color: Colors.transparent,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: .0.w.h,
                  // surfaceIntensity: .5,
                  // intensity: 1
                ),
                child: NeumorphicIcon(
                  Icons.cancel_rounded,
                  style: NeumorphicStyle(
                    // color: Colors.white70,
                    depth: .1.h,
                    surfaceIntensity: .3,
                    intensity: 1,
                  ),
                  size: 10.w,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              isCallFromApiFinish
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Form(
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 1.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100.w - 15.w,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Neumorphic(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2),
                                              style: NeumorphicStyle(
                                                  color: Colors.white,
                                                  depth: -2,
                                                  intensity: 1,
                                                  surfaceIntensity: 1),
                                              child: Container(
                                                child:
                                                    _listImageGallery.length > 0
                                                        ? PhotoView(
                                                            imageProvider:
                                                                FileImage(
                                                              _listImageGallery[
                                                                  imageGallerySelected],
                                                            ),
                                                            backgroundDecoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                "Silahkan pilih gambar dan pastikan file kurang dari 10Mb",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                              ),
                                            )),
                                            Column(
                                              children: [
                                                Neumorphic(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 2),
                                                  style: NeumorphicStyle(
                                                      depth: -1.5,
                                                      intensity: 1,
                                                      surfaceIntensity: 1),
                                                  child: Container(
                                                    width: 18.w,
                                                    height: 18.w,
                                                    alignment: Alignment.center,
                                                    child: NeumorphicButton(
                                                      onPressed: () {},
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      style: NeumorphicStyle(
                                                          // shape: NeumorphicShape.convex,
                                                          color: Colors
                                                              .transparent,
                                                          boxShape:
                                                              NeumorphicBoxShape
                                                                  .circle(),
                                                          depth: 1,
                                                          surfaceIntensity: 1,
                                                          intensity: 1),
                                                      child: PopupMenuButton(
                                                          onSelected:
                                                              (String value) {
                                                            if (value ==
                                                                'fromCamera') {
                                                              _imgFromCamera(
                                                                  isGalleryImmage:
                                                                      true);
                                                            } else {
                                                              _imgFromGallery(
                                                                  isGalleryImmage:
                                                                      true);
                                                            }
                                                          },
                                                          child: NeumorphicIcon(
                                                            Icons.add,
                                                            style:
                                                                NeumorphicStyle(
                                                              depth: 1.5,
                                                              surfaceIntensity:
                                                                  1,
                                                              intensity: 1,
                                                            ),
                                                            size: 13.w,
                                                          ),
                                                          itemBuilder:
                                                              (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                value:
                                                                    'fromCamera',
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      child: Icon(
                                                                          Icons
                                                                              .store_rounded),
                                                                    ),
                                                                    Text(
                                                                      "Ambil Dari Camera",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'ghotic',
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              PopupMenuItem(
                                                                value:
                                                                    'fromGallery',
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5),
                                                                      child: Icon(
                                                                          Icons
                                                                              .visibility_outlined),
                                                                    ),
                                                                    Text(
                                                                      "Ambil Dari Gallery",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'ghotic',
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ];
                                                          }),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Expanded(
                                                    child: Neumorphic(
                                                  style: NeumorphicStyle(
                                                      depth: -2,
                                                      intensity: 1,
                                                      surfaceIntensity: 1),
                                                  child: Container(
                                                    width: 18.w,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 2.w,
                                                    ),
                                                    child: ListView.builder(
                                                        itemCount:
                                                            _listImageGallery
                                                                .length,
                                                        itemBuilder:
                                                            (itemBuilder,
                                                                index) {
                                                          return Container(
                                                            height: 18.w,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.w),
                                                            child: Column(
                                                              children: [
                                                                NeumorphicButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _listImageGallery
                                                                          .removeAt(
                                                                              index);
                                                                    });
                                                                  },
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  style:
                                                                      NeumorphicStyle(
                                                                    // shape: NeumorphicShape.convex,
                                                                    color: Colors
                                                                        .transparent,
                                                                    boxShape:
                                                                        NeumorphicBoxShape
                                                                            .circle(),
                                                                    depth: 1,
                                                                    // surfaceIntensity: .5,
                                                                    // intensity: 1
                                                                  ),
                                                                  child:
                                                                      NeumorphicIcon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    style:
                                                                        NeumorphicStyle(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              .5),
                                                                      depth: 1,
                                                                      surfaceIntensity:
                                                                          1,
                                                                      intensity:
                                                                          1,
                                                                    ),
                                                                    size: 5.w,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 1.w,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Neumorphic(
                                                                    style:
                                                                        NeumorphicStyle(
                                                                      depth: -2,
                                                                      surfaceIntensity:
                                                                          1,
                                                                      intensity:
                                                                          1,
                                                                    ),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          imageGallerySelected =
                                                                              index;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .black12,
                                                                        width: 18.w -
                                                                            6.w,
                                                                        child:
                                                                            Image(
                                                                          image:
                                                                              FileImage(_listImageGallery.elementAt(index)),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ))
                                              ],
                                            ),
                                            SizedBox(
                                              width: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
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
                                                  child: imageError!.isNotEmpty
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
                                                              color:
                                                                  Colors.white,
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
                                                        .roundRect(
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    .3.w.h))),
                                                    depth: .04.w.h,
                                                  ),
                                                  child: imageThumbnail != null
                                                      ? Image(
                                                          image: FileImage(
                                                              imageThumbnail!),
                                                          fit: BoxFit.fill,
                                                          // use this
                                                          width: 1.5.w.h,
                                                          height: 1.5.w.h,
                                                        )
                                                      : NeumorphicIcon(
                                                          Icons.add,
                                                          style:
                                                              NeumorphicStyle(
                                                            color:
                                                                Colors.black38,
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
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: Row(children: [
                                          Text(
                                            "Pilih Category",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          selectedChoices.isEmpty
                                              ? Row(children: [
                                                  Tooltip(
                                                    preferBelow: false,
                                                    triggerMode:
                                                        TooltipTriggerMode.tap,
                                                    waitDuration:
                                                        const Duration(
                                                            seconds: 0),
                                                    showDuration:
                                                        const Duration(
                                                            seconds: 2),
                                                    textStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    // decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                                                    message:
                                                        "silahkan pilih kategory atau tambah category",
                                                    child: Icon(
                                                      Icons.info,
                                                      color: Colors.red,
                                                      size: 3.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                ])
                                              : Container(),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          NeumorphicButton(
                                            onPressed: () {
                                              print(selectedChoices);
                                              var _formKeyNew =
                                                  GlobalKey<FormState>();
                                              var addNameCategoryField = "";

                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Form(
                                                        key: _formKeyNew,
                                                        child: Column(
                                                          children: [
                                                            WidgetTextField(
                                                                textTitleColor:
                                                                    Colors
                                                                        .black,
                                                                title:
                                                                    "Nama Category",
                                                                obSecure: false,
                                                                icon: Icons
                                                                    .person,
                                                                messageError:
                                                                    "Silahkan Masukan Nama Produk",
                                                                isError: false,
                                                                // isError: emailField.isEmpty,
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  addNameCategoryField =
                                                                      value!;
                                                                },
                                                                onSaved:
                                                                    (String?
                                                                        value) {
                                                                  addNameCategoryField =
                                                                      value!;
                                                                },
                                                                keyboardtype:
                                                                    TextInputType
                                                                        .text),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        NeumorphicButton(
                                                          onPressed: () {
                                                            print(
                                                                addNameCategoryField);
                                                            setState(() {
                                                              listCategoryState.add(
                                                                  addNameCategoryField);
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                          child: Text('Tambah'),
                                                        ),
                                                        NeumorphicButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                          child: Text('Batal'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            padding: EdgeInsets.symmetric(
                                                vertical: .2.h,
                                                horizontal: 1.w),
                                            style: NeumorphicStyle(
                                              color: Colors.transparent,
                                              depth: 2,
                                              intensity: 1,
                                              surfaceIntensity: 1,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              border: NeumorphicBorder(
                                                  color: Colors.grey,
                                                  isEnabled: true),
                                            ),
                                            child: Icon(Icons.add),
                                          )
                                        ]),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 0),
                                          alignment: Alignment.topLeft,
                                          child: Wrap(
                                              spacing: 1.w,
                                              alignment: WrapAlignment.start,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.start,
                                              children:
                                                  listCategoryState.map((e) {
                                                return ChoiceChip(
                                                  label: Text(e),
                                                  selectedColor:
                                                      Colors.orangeAccent,
                                                  selected: selectedChoices
                                                      .contains(e),
                                                  onSelected: (select) {
                                                    setState(
                                                      () {
                                                        selectedChoices
                                                                .contains(e)
                                                            ? selectedChoices
                                                                .remove(e)
                                                            : selectedChoices
                                                                .add(e);
                                                      },
                                                    );
                                                  },
                                                );
                                              }).toList())),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Nama Produk",
                                            obSecure: false,
                                            icon: Icons.apps_sharp,
                                            initialValue: nameProductField,
                                            messageError:
                                                "Silahkan Masukan Nama Produk",
                                            isError: nameProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                nameProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                nameProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype: TextInputType.text),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Stok Produk",
                                            initialValue: stockProductField,
                                            obSecure: false,
                                            icon: Icons
                                                .production_quantity_limits,
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
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Harga Produk",
                                            obSecure: false,
                                            icon: Icons.price_change_rounded,
                                            initialValue: priceProductField,
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
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Tinggi Produk (cm)",
                                            obSecure: false,
                                            icon: Icons.straighten,
                                            initialValue: heightProductField,
                                            messageError:
                                                "Silahkan Masukan Tinggi Produk",
                                            isError: heightProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                heightProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                heightProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Berat Produk (kg)",
                                            obSecure: false,
                                            icon: Icons.scale_sharp,
                                            initialValue: weightProductField,
                                            messageError:
                                                "Silahkan Masukan Berat Produk",
                                            isError: weightProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                weightProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                weightProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Lebar Produk (cm)",
                                            obSecure: false,
                                            icon: Icons.widgets_rounded,
                                            initialValue: widthProductField,
                                            messageError:
                                                "Silahkan Masukan Lebar Produk",
                                            isError: widthProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                widthProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                widthProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            textTitleColor: Colors.black,
                                            title: "Panjang Produk (cm)",
                                            obSecure: false,
                                            icon: Icons.architecture,
                                            initialValue: lengthProductField,
                                            messageError:
                                                "Silahkan Masukan Panjang Produk",
                                            isError: lengthProductField.isEmpty,
                                            // isError: emailField.isEmpty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                lengthProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            onSaved: (String? value) {
                                              setState(() {
                                                lengthProductField = value!;
                                                buttonSaveVisible = true;
                                              });
                                            },
                                            keyboardtype:
                                                TextInputType.numberWithOptions(
                                                    decimal: false)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.w),
                                        child: WidgetTextField(
                                            title: "Deskripsi Produk",
                                            obSecure: false,
                                            icon: Icons.description,
                                            initialValue: descProductField,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.w),
                            child: nameProductField.isNotEmpty &&
                                    priceProductField.isNotEmpty &&
                                    descProductField.isNotEmpty &&
                                    stockProductField.isNotEmpty &&
                                    _listImageGallery.length > 0 &&
                                    heightProductField.isNotEmpty &&
                                    widthProductField.isNotEmpty &&
                                    weightProductField.isNotEmpty &&
                                    lengthProductField.isNotEmpty &&
                                    selectedChoices.isNotEmpty &&
                                    imageThumbnail != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      widget.idProduct != null
                                          ? NeumorphicButton(
                                              padding: EdgeInsets.only(
                                                  top: 6.sp,
                                                  bottom: 6.sp,
                                                  left: 12.sp,
                                                  right: 12.sp),
                                              style: NeumorphicStyle(
                                                  shape: NeumorphicShape.convex,
                                                  color: Color.fromRGBO(
                                                      243, 174, 0, 1.0),
                                                  boxShape: NeumorphicBoxShape
                                                      .stadium(),
                                                  depth: .2.h,
                                                  surfaceIntensity: .3,
                                                  intensity: .9),
                                              child: Wrap(children: [
                                                Text(
                                                  "${isArchived ? 'Tampilkan' : 'Hapus'}",
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white),
                                                ),
                                              ]),
                                              onPressed: () async {
                                                var getArchiveProduct =
                                                    await http.get(
                                                        Uri.parse(
                                                            "${DioClient.ipServer}/api/my/outlet/${widget.idStore}/archive/${!isArchived}/product/${widget.idProduct}"),
                                                        headers: {
                                                      'Content-Type':
                                                          'application/json',
                                                      'Accept':
                                                          'application/json',
                                                      'Authorization':
                                                          'Bearer ${await SecureStorage().getToken()}'
                                                    });
                                                if (getArchiveProduct
                                                        .statusCode ==
                                                    200) {
                                                  var response = json.decode(
                                                      getArchiveProduct.body);
                                                  if (response['data'] !=
                                                      null) {
                                                    Toaster(context)
                                                        .showSuccessToast(
                                                            "Produk berhasil di ${response['data']['isArchived'] ? 'hapus' : 'tampilkan kembali'}",
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER);
                                                    widget.onDismiss(true);
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              },
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      NeumorphicButton(
                                          padding: EdgeInsets.only(
                                              top: 6.sp,
                                              bottom: 6.sp,
                                              left: 12.sp,
                                              right: 12.sp),
                                          style: NeumorphicStyle(
                                              shape: NeumorphicShape.convex,
                                              color: Color.fromRGBO(
                                                  243, 174, 0, 1.0),
                                              boxShape:
                                                  NeumorphicBoxShape.stadium(),
                                              depth: .2.h,
                                              surfaceIntensity: .3,
                                              intensity: .9),
                                          child: Wrap(children: [
                                            Text(
                                              "${widget.idProduct != null ? "Ubah" : "Buat"}",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white),
                                            ),
                                          ]),
                                          onPressed: () async {
                                            // print(priceProductField
                                            //     .toLowerCase()
                                            //     .replaceAll('rp', '')
                                            //     .replaceAll('.', ''));
                                            // print(descProductField);

                                            var param =
                                                PayloadRequestCreateProduct(
                                                    deskripsiProduct:
                                                        descProductField,
                                                    priceProduct:
                                                        priceProductField
                                                            .toLowerCase()
                                                            .replaceAll(
                                                                'rp', '')
                                                            .replaceAll(
                                                                '.', ''),
                                                    stockProduct:
                                                        stockProductField,
                                                    nameProduct:
                                                        nameProductField,
                                                    storeCatProd:
                                                        selectedChoices);

                                            // CreateProductMyStoreCubit()
                                            //     .createProduct(
                                            //         imgThumbnail: imageThumbnail!,
                                            //         files: _listImageGallery,
                                            //         idStore: widget.idStore,
                                            //         payloadRequestCreateProduct:
                                            //             param);
                                            // Future.delayed(
                                            //     Duration(milliseconds: 1), () {
                                            //   Navigator.of(context).pop();
                                            // });
                                            try {
                                              var formData = FormData.fromMap({
                                                'deskripsiProduct':
                                                    descProductField,
                                                'priceProduct':
                                                    priceProductField
                                                        .toLowerCase()
                                                        .replaceAll('rp', '')
                                                        .replaceAll('.', ''),
                                                'stockProduct':
                                                    stockProductField,
                                                'nameProduct': nameProductField,
                                                'heightProduct': int.tryParse(
                                                        heightProductField) ??
                                                    0,
                                                'weightProduct': int.tryParse(
                                                        weightProductField) ??
                                                    0,
                                                'widthProduct': int.tryParse(
                                                        widthProductField) ??
                                                    0,
                                                'lengthProduct': int.tryParse(
                                                        lengthProductField) ??
                                                    0,
                                                'storeCatProd': selectedChoices,
                                              });
                                              if (imageThumbnail != null) {
                                                formData.files.add(MapEntry(
                                                    'imgThumbnail',
                                                    MultipartFile.fromFileSync(
                                                        imageThumbnail!.path,
                                                        filename: imageThumbnail!
                                                            .path
                                                            .split(Platform
                                                                .pathSeparator)
                                                            .last)));
                                              }
                                              if (_listImageGallery != null) {
                                                formData.files.addAll(
                                                    _listImageGallery.map((i) =>
                                                        MapEntry(
                                                            'files',
                                                            MultipartFile
                                                                .fromFileSync(
                                                              i.path,
                                                              filename: i.path
                                                                  .split(Platform
                                                                      .pathSeparator)
                                                                  .last,
                                                            ))));
                                              }
                                              DioClient _dio = new DioClient();
                                              DioResponse res =
                                                  await _dio.postAsync(
                                                      "/api/my/outlet/${widget.idStore}/create/product${widget.idProduct != null ? '/${widget.idProduct}' : ""}",
                                                      formData);
                                              if (res.results["code"] == 200) {
                                                widget.onDismiss(true);
                                                Toaster(context).showSuccessToast(
                                                    "Produk berhasil di perbaharui",
                                                    gravity:
                                                        ToastGravity.CENTER);
                                                Navigator.of(context).pop();
                                              }
                                            } catch (e) {
                                              Toaster(context).showErrorToast(
                                                  "Terjadi kesalahan saat menyimpan data",
                                                  gravity: ToastGravity.CENTER);
                                            }
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
                                          })
                                    ],
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 50.w,
                          child: NeumorphicProgressIndeterminate(
                            style: ProgressStyle(
                              depth: -2,
                              accent: Colors.blue,
                            ),
                            duration: Duration(seconds: 1),
                            reverse: true,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getDataApi() async {
    setState(() {
      isCallFromApiFinish = false;
    });
    var getCategory = await ProfileRepository().getCategory("", widget.idStore);
    List<String> listCategory = [];
    Map<String, dynamic> bodyProductExisting = new Map();
    File? imageThumbnailConvert;
    List<File> imageGalleryProductConvert = [];
    List<String> selectedChoicesConvert = [];
    if (widget.idProduct != null) {
      var dataProduct = await getDataProduct(
          storeId: widget.idStore, productId: widget.idProduct ?? 0);
      bodyProductExisting = json.decode(dataProduct.body);
      if (bodyProductExisting['data'] != null) {
        if (bodyProductExisting['data']['thumbnailData'] != null) {
          imageThumbnailConvert = await bytesTofile(
              base64.decode(bodyProductExisting['data']['thumbnailData']),
              bodyProductExisting['data']['thumbnailName']);
        }
        if (bodyProductExisting['data']['storeProductImages'] != null) {
          if ((bodyProductExisting['data']['storeProductImages'] as List)
              .isNotEmpty) {
            await Future.forEach(
                (bodyProductExisting['data']['storeProductImages'] as List),
                (element) async {
              element as Map<String, dynamic>;
              var bytesFile = await bytesTofile(
                    base64.decode(element['propicData']),
                    element['propicName'],
                  ) ??
                  new File('');
              imageGalleryProductConvert.add(bytesFile);
            });
          }
        }
        if (bodyProductExisting['data']['storeCategorys'] != null) {
          if ((bodyProductExisting['data']['storeCategorys'] as List)
              .isNotEmpty) {
            await Future.forEach(
                (bodyProductExisting['data']['storeCategorys'] as List),
                (element) async {
              element as Map<String, dynamic>;
              selectedChoicesConvert.contains(element['nameCategory'])
                  ? selectedChoices.remove(element['nameCategory'])
                  : selectedChoices.add(element['nameCategory']);
              print('foreach $element}');
            });
          }
        }
      }
    }

    setState(() {
      print('foreach1 ${imageGalleryProductConvert}');
      if (getCategory != null) {
        var getCategoryData = getCategory.data;
        if (getCategoryData != null) {
          listCategoryState =
              getCategoryData.map((e) => e.categoryName).toList();
        }
      }
      if (bodyProductExisting['data'] != null) {
        dataProductExistingState = bodyProductExisting['data'];
        isArchived = dataProductExistingState['isArchived'];
        nameProductField = dataProductExistingState['nameProduct'];
        priceProductField =
            "${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 0).format(int.tryParse(dataProductExistingState['priceProduct'] ?? 0) ?? 0).replaceAll(',', '')}";
        stockProductField = "${dataProductExistingState['stockProduct'] ?? 0}";
        descProductField =
            "${dataProductExistingState['deskripsiProduct'] ?? ""}";
        heightProductField =
            "${dataProductExistingState['heightProduct'] ?? 0}";
        weightProductField =
            "${dataProductExistingState['weightProduct'] ?? 0}";
        widthProductField = "${dataProductExistingState['widthProduct'] ?? 0}";
        lengthProductField =
            "${dataProductExistingState['lengthProduct'] ?? 0}";
        if (dataProductExistingState['thumbnailData'] != null) {
          imageThumbnail = imageThumbnailConvert;
        }
        _listImageGallery.addAll(imageGalleryProductConvert);
        selectedChoices.addAll(selectedChoicesConvert);
        // if (dataProductExistingState['storeProductImages'] != null) {
        //   if ((dataProductExistingState['storeProductImages'] as List)
        //       .isNotEmpty) {
        //     print('non men${dataProductExistingState['storeProductImages']}');
        //     _listImageGallery.addAll(imageGalleryProductConvert);
        //   }
        // }

        print('call data $dataProductExistingState');
      }
      isCallFromApiFinish = true;
    });
  }

  Future<File?> bytesTofile(Uint8List data, String filename) async {
    var result;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage] == PermissionStatus.granted) {
      Directory dir = await getTemporaryDirectory();
      File file = File('${dir.path}/$filename');
      result = await file.writeAsBytes(data);
    }
    return result;
// You can can also directly ask the permission about its status.
  }

  Future<http.Response> getDataProduct({
    required int storeId,
    required int productId,
  }) async {
    return http.get(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/$storeId/create/product/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
  }

  _imgFromCamera(
      {bool isThumbnail = false, bool isGalleryImmage = false}) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    double sizeInMb = await image!.length() / (1024 * 1024);
    print(sizeInMb);
    if (image != null) {
      if (sizeInMb > .5) {
        imageOverSize = "Pastikan file kurang dari 2Mb";
        Toaster(context)
            .showErrorToast(imageOverSize, gravity: ToastGravity.CENTER);
        if (isThumbnail) {
          setState(() {
            imageError =
                "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
          });
        }
      } else {
        // _image = File(image.path);
        setState(() {
          if (isGalleryImmage) {
            imageOverSize = "";
            _listImageGallery.add(File(image.path));
          }
          if (isThumbnail) {
            imageError = "";
            imageThumbnail = File(image.path);
          }
        });
      }
    }
  }

  _imgFromGallery(
      {bool isThumbnail = false, bool isGalleryImmage = false}) async {
    if (isThumbnail) {
      ImagePicker().pickImage(source: ImageSource.gallery).then((xFile) async {
        if (xFile != null) {
          double sizeInMb = await xFile.length() / (1024 * 1024);
          if (sizeInMb > .5) {
            imageOverSize = "Pastikan file kurang dari 2Mb";
            Toaster(context)
                .showErrorToast(imageOverSize, gravity: ToastGravity.CENTER);
            setState(() {
              imageError =
                  "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
            });
          } else {
            setState(() {
              imageError = "";
              imageThumbnail = File(xFile.path);
            });
          }
        }
      });
    } else {
      List<XFile>? image = await ImagePicker().pickMultiImage();
      var imageOverSizeLocal = "";
      List<File> _listImageGalleryLocal = [];
      if (image != null) {
        Future.forEach(image, (XFile element) async {
          double sizeInMb = await element.length() / (1024 * 1024);
          if (sizeInMb > .5) {
            imageOverSize = "Pastikan file kurang dari 2Mb";
            Toaster(context)
                .showErrorToast(imageOverSize, gravity: ToastGravity.CENTER);
            setState(() {
              imageError =
                  "Silahkan pilih gambar dan pastikan file kurang dari 2Mb";
            });
          } else {
            imageOverSizeLocal = "";
            _listImageGalleryLocal.add(File(element.path));
          }
        });
        setState(() {
          imageOverSize = imageOverSizeLocal;
          _listImageGallery = _listImageGalleryLocal;
        });
      }
    }
  }
}
