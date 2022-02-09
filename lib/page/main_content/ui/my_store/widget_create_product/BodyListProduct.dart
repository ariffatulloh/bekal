import 'dart:math' as math;

import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class BodyListProduct extends StatelessWidget {
  final List<PayloadResponseStoreProduct> data;
  const BodyListProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.white,
        // width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
        child: MasonryGridView.count(
            // physics: NeverScrollableScrollPhysics(),

            crossAxisCount: 2,
            mainAxisSpacing: 3.h,
            crossAxisSpacing: 3.w,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var object = data[index];
              return ItemProduct(
                counterViews: 0,
                counterSell: 0,
                available: false,
                priceProduk: double.parse(object.priceProduct),
                nameProduk: object.nameProduct,
                imageProduk: object.uriThumbnail,
                logoToko: object.store.uriStoreImage,
              );
            }),
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  ItemProduct({
    Key? key,
    required this.imageProduk,
    required this.nameProduk,
    required this.priceProduk,
    required this.logoToko,
    required this.available,
    this.counterSell,
    this.counterViews,
  }) : super(key: key);

  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final String imageProduk;
  final String nameProduk;
  final double priceProduk;
  final String logoToko;
  final bool available;
  int? counterSell = 0;
  int? counterViews = 0;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        margin: EdgeInsets.only(bottom: 2.h, top: 1.h),
        style: NeumorphicStyle(
            color: Colors.white,
            depth: .2.h,
            surfaceIntensity: .3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.roundRect(
                const BorderRadius.all(Radius.circular(10)))),
        // margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: SizedBox(
          width: 40.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                      aspectRatio: 1.w / 1.w,
                      child: Image.network(
                        "$imageProduk?dummy=${math.Random().nextInt(999)}",
                        fit: BoxFit.fill,
                      )),
                  Positioned(
                    top: .5.h,
                    right: .5.w,
                    child: Neumorphic(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, left: 5, right: 5),
                      style: NeumorphicStyle(
                          depth: .2.h,
                          intensity: .6,
                          color: available
                              ? Colors.greenAccent
                              : Colors.redAccent),
                      child: Center(
                        child: Text(
                          available ? "Tersedia" : "Habis",
                          style:
                              TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dikunjungi: ${counterViews! > 9999 ? "9999+" : counterViews}/hr",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 22.sp,
                        child: Text(
                          nameProduk.toUpperCase(),
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${currencyFormatter.format(priceProduk)}",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.red),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.network(
                            "$logoToko",
                            height: 3.h,
                            width: 3.h,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "TerJual: ${counterSell! > 9999 ? "9999+" : counterSell}",
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 8.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
