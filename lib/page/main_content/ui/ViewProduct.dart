import 'dart:math' as math;

import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class ViewProduct extends StatefulWidget {
  int idProduct = -1;
  PayloadResponseStoreProduct? dataDetailProduct;
  ViewProduct({required this.idProduct, this.dataDetailProduct});
  @override
  _ViewProduct createState() => _ViewProduct();
}

class _ViewProduct extends State<ViewProduct> {
  int galleryImageSelected = 0;
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  @override
  Widget build(BuildContext context) {
    PayloadResponseStoreProduct data = widget.dataDetailProduct!;
    // TODO: implement build
    return Column(children: [
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
        child: widget.dataDetailProduct != null
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.w),
                        topRight: Radius.circular(5.w))),
                child: Column(
                  children: [
                    Container(
                      width: 100.w,
                      height: 80.w - 20.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: PhotoView(
                              imageProvider: NetworkImage(
                                "${data.galleryImage[galleryImageSelected].uriImage}?dummy=${math.Random().nextInt(999)}",
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                            child: MasonryGridView.count(
                                crossAxisCount: 1,
                                mainAxisSpacing: 1.h,
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                // crossAxisSpacing: 1.w,
                                itemCount: data.galleryImage.length,
                                itemBuilder: (context, index) {
                                  return NeumorphicButton(
                                    padding: EdgeInsets.all(0.1.w.h),
                                    style: NeumorphicStyle(
                                      // shape: NeumorphicShape.convex,
                                      color: Colors.transparent,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(.2.w.h))),
                                      depth: .04.w.h,
                                    ),
                                    child: Container(
                                      height: 15.w,
                                      // height: 3.h,
                                      child: Image.network(
                                        "${data.galleryImage[index].uriImage}?dummy=${math.Random().nextInt(999)}",
                                        fit: BoxFit.contain, // use this
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        galleryImageSelected = index;
                                      });
                                    },
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(0.3.w.h),
                      style: NeumorphicStyle(
                        // shape: NeumorphicShape.convex,
                        color: Colors.transparent,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.all(Radius.circular(.2.w.h))),
                        depth: .04.w.h,
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10.w,
                                  child: Image.network(
                                    "${data.uriThumbnail}?dummy=${math.Random().nextInt(999)}",
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${data.nameProduct}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  color: HexColor("9E9E9E90"),
                                  height: .1.h,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${currencyFormatter.format(double.parse(data.priceProduct))}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: NeumorphicButton(
                                          // margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.only(
                                              top: 6.sp,
                                              bottom: 6.sp,
                                              left: 12.sp,
                                              right: 12.sp),
                                          style: NeumorphicStyle(
                                              shape: NeumorphicShape.convex,
                                              color: Color.fromRGBO(
                                                  243, 146, 0, 1),
                                              boxShape:
                                                  NeumorphicBoxShape.stadium(),
                                              depth: .2.h,
                                              intensity: .8),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                "Beli Sekarang",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        // height: 3.h,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deskripsi:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${data.deskripsiProduct}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
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
                    "Data Tidak Ditemukan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ],
              ),
      )
    ]);
  }
}
