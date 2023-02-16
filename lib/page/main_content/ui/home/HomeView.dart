import 'dart:math' as math;

import 'package:bekal/page/main_content/cubit/home_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/ViewProduct.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  bool isLoading = true;
  List<PayloadResponseHomeSeeAllProduct> listDataHome = [];
  List<int> listMyOutlets = [];
  var dummyImageVersion = '?dummy=${math.Random().nextInt(999)}';

  @override
  void initState() {
    super.initState();
    _getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
    //   width: 100.w,
    //   height: 100.h,
    //   color: Colors.white,
    //   alignment: Alignment.center,
    //   child: isLoading
    //       ? Center(
    //           child: CircularProgressIndicator(
    //             color: Colors.blue,
    //           ),
    //         )
    //       : Container(
    //           height: 100.h,
    //           // color: Colors.black12,
    //           alignment: Alignment.center,
    //           child: ListView.builder(
    //               // scrollDirection: Axis.horizontal,
    //               itemCount: listDataHome.length,
    //               itemBuilder: (context, index) {
    //                 var dataObject = listDataHome.elementAt(index);
    //
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "${dataObject.titleTab}",
    //                       style: TextStyle(
    //                           fontFamily: 'ghotic',
    //                           fontSize: 12.sp,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.black45),
    //                     ),
    //                     SizedBox(
    //                       height: 3.w,
    //                     ),
    //                     SingleChildScrollView(
    //                       scrollDirection: dataObject.titleTab
    //                               .toLowerCase()
    //                               .contains("semua")
    //                           ? Axis.vertical
    //                           : Axis.horizontal,
    //                       child: Wrap(
    //                         children: dataObject.viewListStoreProductResponse
    //                             .map((e) {
    //                           return Visibility(
    //                               visible: e.stockProduct != '0' &&
    //                                   !listMyOutlets.contains(e.store.storeID),
    //                               child: NeumorphicButton(
    //                                 onPressed: () {
    //                                   showMaterialModalBottomSheet(
    //                                     duration: Duration(milliseconds: 1400),
    //                                     animationCurve: Curves.easeInOut,
    //                                     enableDrag: true,
    //                                     isDismissible: false,
    //                                     backgroundColor: Colors.transparent,
    //                                     context: context,
    //                                     builder: (context) {
    //                                       return SafeArea(
    //                                         child: ViewProduct(
    //                                             idStore: e.store.storeID,
    //                                             dataDetailProduct: null,
    //                                             idProduct: e.storeProdId),
    //                                       );
    //                                     },
    //                                   );
    //                                 },
    //                                 padding: EdgeInsets.all(0),
    //                                 margin: EdgeInsets.symmetric(
    //                                     horizontal: 1.w, vertical: 1.h),
    //                                 style: NeumorphicStyle(
    //                                     color: Colors.blue.withOpacity(.25),
    //                                     depth: 2,
    //                                     intensity: 1,
    //                                     surfaceIntensity: 1),
    //                                 child: Container(
    //                                   width: dataObject.titleTab
    //                                           .toLowerCase()
    //                                           .contains("semua")
    //                                       ? 45.w
    //                                       : 40.w,
    //                                   decoration: BoxDecoration(
    //                                     gradient: LinearGradient(
    //                                         begin: Alignment.topLeft,
    //                                         end: Alignment.bottomRight,
    //                                         colors: [
    //                                           Color(0xfff39200).withOpacity(.1),
    //                                           Color(0xfff39200).withOpacity(.4)
    //                                         ],
    //                                         stops: [
    //                                           .1,
    //                                           .8
    //                                         ]),
    //                                   ),
    //                                   padding: EdgeInsets.symmetric(
    //                                       horizontal: 0.w, vertical: 0.h),
    //                                   child: Column(
    //                                     children: [
    //                                       Visibility(
    //                                         visible: !dataObject.titleTab
    //                                             .toLowerCase()
    //                                             .contains("semua"),
    //                                         child: Container(
    //                                           padding: EdgeInsets.symmetric(
    //                                               vertical: .5.h,
    //                                               horizontal: 2.w),
    //                                           child: NeumorphicText(
    //                                             e.nameProduct.length > 17
    //                                                 ? e.nameProduct
    //                                                         .substring(0, 15) +
    //                                                     "..."
    //                                                 : e.nameProduct,
    //                                             style: NeumorphicStyle(
    //                                                 color: Colors.white,
    //                                                 depth: 2,
    //                                                 intensity: 1,
    //                                                 surfaceIntensity: 1),
    //                                             textStyle: NeumorphicTextStyle(
    //                                               fontSize: 12.sp,
    //                                               fontFamily: 'ghotic',
    //                                               fontWeight: FontWeight.bold,
    //                                             ),
    //                                             textAlign: TextAlign.center,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.symmetric(
    //                                             vertical: 0.h,
    //                                             horizontal: dataObject.titleTab
    //                                                     .toLowerCase()
    //                                                     .contains("semua")
    //                                                 ? 0
    //                                                 : 2.w),
    //                                         child: Neumorphic(
    //                                           style: NeumorphicStyle(
    //                                               boxShape: dataObject.titleTab
    //                                                       .toLowerCase()
    //                                                       .contains("semua")
    //                                                   ? NeumorphicBoxShape
    //                                                       .rect()
    //                                                   : NeumorphicBoxShape
    //                                                       .circle(),
    //                                               depth: 2,
    //                                               intensity: 1,
    //                                               surfaceIntensity: 1),
    //                                           child: Container(
    //                                             width: 100.w,
    //                                             height: dataObject.titleTab
    //                                                     .toLowerCase()
    //                                                     .contains("semua")
    //                                                 ? 40.w
    //                                                 : 40.w,
    //                                             child: CachedNetworkImage(
    //                                               imageUrl: e.uriThumbnail +
    //                                                   dummyImageVersion,
    //                                               fit: BoxFit.cover,
    //                                               errorWidget:
    //                                                   (context, url, error) {
    //                                                 return Icon(
    //                                                   Icons.person,
    //                                                   color: Colors.black,
    //                                                 );
    //                                               },
    //                                               placeholder: (context, url) =>
    //                                                   Center(
    //                                                 child: SizedBox(
    //                                                   width: 25,
    //                                                   height: 25,
    //                                                   child:
    //                                                       new CircularProgressIndicator(
    //                                                     strokeWidth: 2,
    //                                                   ),
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Visibility(
    //                                         visible: dataObject.titleTab
    //                                             .toLowerCase()
    //                                             .contains("semua"),
    //                                         child: Container(
    //                                           padding: EdgeInsets.symmetric(
    //                                               vertical: .5.h,
    //                                               horizontal: 2.w),
    //                                           child: NeumorphicText(
    //                                             e.nameProduct.length > 17
    //                                                 ? e.nameProduct
    //                                                         .substring(0, 15) +
    //                                                     "..."
    //                                                 : e.nameProduct,
    //                                             style: NeumorphicStyle(
    //                                                 color: Colors.white,
    //                                                 depth: 2,
    //                                                 intensity: 1,
    //                                                 surfaceIntensity: 1),
    //                                             textStyle: NeumorphicTextStyle(
    //                                               fontSize: 12.sp,
    //                                               fontFamily: 'ghotic',
    //                                               fontWeight: FontWeight.bold,
    //                                             ),
    //                                             textAlign: TextAlign.center,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.symmetric(
    //                                             vertical: .5.h,
    //                                             horizontal: 2.w),
    //                                         child: Neumorphic(
    //                                           padding: EdgeInsets.symmetric(
    //                                               vertical: .5.h,
    //                                               horizontal: 1.h),
    //                                           style: NeumorphicStyle(
    //                                               color: e.stockProduct == '0'
    //                                                   ? Colors.red
    //                                                   : Colors.greenAccent,
    //                                               boxShape: NeumorphicBoxShape
    //                                                   .stadium(),
    //                                               depth: -1,
    //                                               intensity: 1,
    //                                               surfaceIntensity: 1),
    //                                           child: Text(
    //                                             e.stockProduct == '0'
    //                                                 ? "HABIS"
    //                                                 : "Tersedia",
    //                                             style: TextStyle(
    //                                                 fontSize: 8.sp,
    //                                                 color: Colors.white),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.symmetric(
    //                                             horizontal: 2.w,
    //                                             vertical: .5.h),
    //                                         child: NeumorphicText(
    //                                           NumberFormat.currency(locale: 'ID')
    //                                                       .format(
    //                                                           double.tryParse(e.priceProduct) ??
    //                                                               0)
    //                                                       .length >
    //                                                   17
    //                                               ? NumberFormat.currency(locale: 'ID')
    //                                                       .format(double.tryParse(e
    //                                                               .priceProduct) ??
    //                                                           0)
    //                                                       .substring(0, 15) +
    //                                                   "..."
    //                                               : NumberFormat.currency(
    //                                                       locale: 'ID')
    //                                                   .format(double.tryParse(
    //                                                           e.priceProduct) ??
    //                                                       0),
    //                                           style: NeumorphicStyle(
    //                                               color: Colors.red,
    //                                               depth: 1,
    //                                               intensity: 1,
    //                                               surfaceIntensity: 1),
    //                                           textStyle: NeumorphicTextStyle(
    //                                             fontSize: 11.sp,
    //                                             fontFamily: 'ghotic',
    //                                             fontWeight: FontWeight.bold,
    //                                           ),
    //                                           textAlign: TextAlign.center,
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.symmetric(
    //                                             horizontal: 2.w,
    //                                             vertical: .5.h),
    //                                         child: Row(
    //                                           children: [
    //                                             Neumorphic(
    //                                               style: NeumorphicStyle(
    //                                                   depth: 1.5,
    //                                                   intensity: 1,
    //                                                   surfaceIntensity: 1,
    //                                                   boxShape:
    //                                                       NeumorphicBoxShape
    //                                                           .circle()),
    //                                               child: Container(
    //                                                 width: 7.w,
    //                                                 height: 7.w,
    //                                                 child: CachedNetworkImage(
    //                                                   imageUrl: e.store
    //                                                           .uriStoreImage +
    //                                                       dummyImageVersion,
    //                                                   fit: BoxFit.cover,
    //                                                   errorWidget: (context,
    //                                                       url, error) {
    //                                                     return Icon(
    //                                                       Icons.person,
    //                                                       color: Colors.black,
    //                                                     );
    //                                                   },
    //                                                   progressIndicatorBuilder:
    //                                                       (context, url,
    //                                                           error) {
    //                                                     return SizedBox(
    //                                                       height: 50,
    //                                                       width: 50,
    //                                                       child:
    //                                                           CircularProgressIndicator(
    //                                                         strokeWidth: 2,
    //                                                       ),
    //                                                     );
    //                                                   },
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                             Container(
    //                                               padding: EdgeInsets.symmetric(
    //                                                   horizontal: 1.w),
    //                                               child: NeumorphicText(
    //                                                 e.store.storeName.length >
    //                                                         (dataObject.titleTab
    //                                                                 .toLowerCase()
    //                                                                 .contains(
    //                                                                     "semua")
    //                                                             ? 18
    //                                                             : 15)
    //                                                     ? e.store.storeName.substring(
    //                                                             0,
    //                                                             (dataObject
    //                                                                     .titleTab
    //                                                                     .toLowerCase()
    //                                                                     .contains(
    //                                                                         "semua")
    //                                                                 ? 15
    //                                                                 : 13)) +
    //                                                         "..."
    //                                                     : e.store.storeName,
    //                                                 style: NeumorphicStyle(
    //                                                     color: Colors.white,
    //                                                     depth: 1,
    //                                                     intensity: 1,
    //                                                     surfaceIntensity: 1),
    //                                                 textStyle:
    //                                                     NeumorphicTextStyle(
    //                                                   fontSize: 9.sp,
    //                                                   fontFamily: 'ghotic',
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                 ),
    //                                                 textAlign: TextAlign.center,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ));
    //                         }).toList(),
    //                       ),
    //                     )
    //                   ],
    //                 );
    //               }),
    //         ),
    // );
    if (isLoading) {
      return Container(
        width: 100.w,
        height: 100.h,
        color: Colors.white,
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    } else {
      return Container(
        width: 100.w,
        height: 100.h,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listDataHome.length,
          itemBuilder: (context, index) {
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text(
                  "${listDataHome.elementAt(index).titleTab}",
                  style: TextStyle(fontFamily: 'ghotic', fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black45),
                ),
                SizedBox(
                  height: 3.w,
                ),
                if (!listDataHome[index].titleTab.toLowerCase().contains("semua")) ...[
                  Container(
                    height: 37.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listDataHome.singleWhere((element) => !element.titleTab.toLowerCase().contains("semua")).viewListStoreProductResponse.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, indexs) {
                        return NeumorphicButton(
                          onPressed: () {
                            showMaterialModalBottomSheet(
                              duration: Duration(milliseconds: 1400),
                              animationCurve: Curves.easeInOut,
                              enableDrag: true,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: ViewProduct(idStore: listDataHome[index].viewListStoreProductResponse[indexs].store.storeID, dataDetailProduct: null, idProduct: listDataHome[index].viewListStoreProductResponse[indexs].storeProdId),
                                );
                              },
                            );
                          },
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                          style: NeumorphicStyle(color: Colors.blue.withOpacity(.25), depth: 2, intensity: 1, surfaceIntensity: 1),
                          child: Container(
                            width: listDataHome[index].titleTab.toLowerCase().contains("semua") ? null : 40.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xfff39200).withOpacity(.1), Color(0xfff39200).withOpacity(.4)], stops: [.1, .8]),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: !listDataHome[index].titleTab.toLowerCase().contains("semua"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                    child: NeumorphicText(
                                      listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                                      style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                                      textStyle: NeumorphicTextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'ghotic',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 0 : 2.w),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(boxShape: listDataHome[index].titleTab.toLowerCase().contains("semua") ? NeumorphicBoxShape.rect() : NeumorphicBoxShape.circle(), depth: 2, intensity: 1, surfaceIntensity: 1),
                                    child: Container(
                                      width: 100.w,
                                      height: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 40.w : 40.w,
                                      child: CachedNetworkImage(
                                        imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].uriThumbnail + dummyImageVersion,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          );
                                        },
                                        progressIndicatorBuilder: (context, url, error) {
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: listDataHome[index].titleTab.toLowerCase().contains("semua"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                    child: NeumorphicText(
                                      listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                                      style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                                      textStyle: NeumorphicTextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'ghotic',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                  child: Neumorphic(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 1.h),
                                    style: NeumorphicStyle(color: listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? Colors.red : Colors.greenAccent, boxShape: NeumorphicBoxShape.stadium(), depth: -1, intensity: 1, surfaceIntensity: 1),
                                    child: Text(
                                      listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? "HABIS" : "Tersedia",
                                      style: TextStyle(fontSize: 8.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                                  child: NeumorphicText(
                                    NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).length > 17
                                        ? NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).substring(0, 15) + "..."
                                        : NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0),
                                    style: NeumorphicStyle(color: Colors.red, depth: 1, intensity: 1, surfaceIntensity: 1),
                                    textStyle: NeumorphicTextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: 'ghotic',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                                  child: Row(
                                    children: [
                                      Neumorphic(
                                        style: NeumorphicStyle(depth: 1.5, intensity: 1, surfaceIntensity: 1, boxShape: NeumorphicBoxShape.circle()),
                                        child: Container(
                                          width: 7.w,
                                          height: 7.w,
                                          child: CachedNetworkImage(
                                            imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].store.uriStoreImage + dummyImageVersion,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              );
                                            },
                                            progressIndicatorBuilder: (context, url, error) {
                                              return CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                                        child: NeumorphicText(
                                          listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.length > 17
                                              ? listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.substring(0, 15) + "..."
                                              : listDataHome[index].viewListStoreProductResponse[indexs].store.storeName,
                                          style: NeumorphicStyle(color: Colors.white, depth: 1, intensity: 1, surfaceIntensity: 1),
                                          textStyle: NeumorphicTextStyle(
                                            fontSize: 9.sp,
                                            fontFamily: 'ghotic',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                if (listDataHome[index].titleTab.toLowerCase().contains("semua")) ...[
                  Container(
                    height: 100.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listDataHome.singleWhere((element) => element.titleTab.toLowerCase().contains("semua")).viewListStoreProductResponse.length,
                      itemBuilder: (context, indexs) {
                        return NeumorphicButton(
                          onPressed: () {
                            showMaterialModalBottomSheet(
                              duration: Duration(milliseconds: 1400),
                              animationCurve: Curves.easeInOut,
                              enableDrag: true,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: ViewProduct(idStore: listDataHome[index].viewListStoreProductResponse[indexs].store.storeID, dataDetailProduct: null, idProduct: listDataHome[index].viewListStoreProductResponse[indexs].storeProdId),
                                );
                              },
                            );
                          },
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                          style: NeumorphicStyle(color: Colors.blue.withOpacity(.25), depth: 2, intensity: 1, surfaceIntensity: 1),
                          child: Container(
                            width: listDataHome[index].titleTab.toLowerCase().contains("semua") ? null : 40.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xfff39200).withOpacity(.1), Color(0xfff39200).withOpacity(.4)], stops: [.1, .8]),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: !listDataHome[index].titleTab.toLowerCase().contains("semua"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                    child: NeumorphicText(
                                      listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                                      style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                                      textStyle: NeumorphicTextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'ghotic',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 0 : 2.w),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(boxShape: listDataHome[index].titleTab.toLowerCase().contains("semua") ? NeumorphicBoxShape.rect() : NeumorphicBoxShape.circle(), depth: 2, intensity: 1, surfaceIntensity: 1),
                                    child: Container(
                                      width: 100.w,
                                      height: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 40.w : 40.w,
                                      child: CachedNetworkImage(
                                        imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].uriThumbnail + dummyImageVersion,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          );
                                        },
                                        progressIndicatorBuilder: (context, url, error) {
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: listDataHome[index].titleTab.toLowerCase().contains("semua"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                    child: NeumorphicText(
                                      listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                                      style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                                      textStyle: NeumorphicTextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: 'ghotic',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                  child: Neumorphic(
                                    padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 1.h),
                                    style: NeumorphicStyle(color: listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? Colors.red : Colors.greenAccent, boxShape: NeumorphicBoxShape.stadium(), depth: -1, intensity: 1, surfaceIntensity: 1),
                                    child: Text(
                                      listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? "HABIS" : "Tersedia",
                                      style: TextStyle(fontSize: 8.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                                  child: NeumorphicText(
                                    NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).length > 17
                                        ? NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).substring(0, 15) + "..."
                                        : NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0),
                                    style: NeumorphicStyle(color: Colors.red, depth: 1, intensity: 1, surfaceIntensity: 1),
                                    textStyle: NeumorphicTextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: 'ghotic',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                                  child: Row(
                                    children: [
                                      Neumorphic(
                                        style: NeumorphicStyle(depth: 1.5, intensity: 1, surfaceIntensity: 1, boxShape: NeumorphicBoxShape.circle()),
                                        child: Container(
                                          width: 7.w,
                                          height: 7.w,
                                          child: CachedNetworkImage(
                                            imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].store.uriStoreImage + dummyImageVersion,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              );
                                            },
                                            progressIndicatorBuilder: (context, url, error) {
                                              return CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                                        child: NeumorphicText(
                                          listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.length > 17
                                              ? listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.substring(0, 15) + "..."
                                              : listDataHome[index].viewListStoreProductResponse[indexs].store.storeName,
                                          style: NeumorphicStyle(color: Colors.white, depth: 1, intensity: 1, surfaceIntensity: 1),
                                          textStyle: NeumorphicTextStyle(
                                            fontSize: 9.sp,
                                            fontFamily: 'ghotic',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
                // Container(
                //   height: listDataHome[index].titleTab.toLowerCase().contains("semua") ? null : 400,
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: listDataHome[index].titleTab.toLowerCase().contains("semua") ? Axis.vertical : Axis.horizontal,
                //     itemCount: listDataHome[index].viewListStoreProductResponse.length,
                //     itemBuilder: (context, indexs) {
                //       return NeumorphicButton(
                //         onPressed: () {
                //           showMaterialModalBottomSheet(
                //             duration: Duration(milliseconds: 1400),
                //             animationCurve: Curves.easeInOut,
                //             enableDrag: true,
                //             isDismissible: false,
                //             backgroundColor: Colors.transparent,
                //             context: context,
                //             builder: (context) {
                //               return SafeArea(
                //                 child: ViewProduct(idStore: listDataHome[index].viewListStoreProductResponse[indexs].store.storeID, dataDetailProduct: null, idProduct: listDataHome[index].viewListStoreProductResponse[indexs].storeProdId),
                //               );
                //             },
                //           );
                //         },
                //         padding: EdgeInsets.all(0),
                //         margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                //         style: NeumorphicStyle(color: Colors.blue.withOpacity(.25), depth: 2, intensity: 1, surfaceIntensity: 1),
                //         child: Container(
                //           width: listDataHome[index].titleTab.toLowerCase().contains("semua") ? null : 40.w,
                //           decoration: BoxDecoration(
                //             gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xfff39200).withOpacity(.1), Color(0xfff39200).withOpacity(.4)], stops: [.1, .8]),
                //           ),
                //           padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                //           child: Column(
                //             children: [
                //               Visibility(
                //                 visible: !listDataHome[index].titleTab.toLowerCase().contains("semua"),
                //                 child: Container(
                //                   padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                //                   child: NeumorphicText(
                //                     listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                //                     style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                //                     textStyle: NeumorphicTextStyle(
                //                       fontSize: 12.sp,
                //                       fontFamily: 'ghotic',
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                     textAlign: TextAlign.center,
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 0 : 2.w),
                //                 child: Neumorphic(
                //                   style: NeumorphicStyle(boxShape: listDataHome[index].titleTab.toLowerCase().contains("semua") ? NeumorphicBoxShape.rect() : NeumorphicBoxShape.circle(), depth: 2, intensity: 1, surfaceIntensity: 1),
                //                   child: Container(
                //                     width: 100.w,
                //                     height: listDataHome[index].titleTab.toLowerCase().contains("semua") ? 40.w : 40.w,
                //                     child: CachedNetworkImage(
                //                       imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].uriThumbnail + dummyImageVersion,
                //                       fit: BoxFit.cover,
                //                       errorWidget: (context, url, error) {
                //                         return Icon(
                //                           Icons.person,
                //                           color: Colors.black,
                //                         );
                //                       },
                //                       progressIndicatorBuilder: (context, url, error) {
                //                         return CircularProgressIndicator();
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Visibility(
                //                 visible: listDataHome[index].titleTab.toLowerCase().contains("semua"),
                //                 child: Container(
                //                   padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                //                   child: NeumorphicText(
                //                     listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].nameProduct.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].nameProduct,
                //                     style: NeumorphicStyle(color: Colors.white, depth: 2, intensity: 1, surfaceIntensity: 1),
                //                     textStyle: NeumorphicTextStyle(
                //                       fontSize: 12.sp,
                //                       fontFamily: 'ghotic',
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                     textAlign: TextAlign.center,
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                //                 child: Neumorphic(
                //                   padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 1.h),
                //                   style: NeumorphicStyle(color: listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? Colors.red : Colors.greenAccent, boxShape: NeumorphicBoxShape.stadium(), depth: -1, intensity: 1, surfaceIntensity: 1),
                //                   child: Text(
                //                     listDataHome[index].viewListStoreProductResponse[indexs].stockProduct == '0' ? "HABIS" : "Tersedia",
                //                     style: TextStyle(fontSize: 8.sp, color: Colors.white),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                //                 child: NeumorphicText(
                //                   NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).length > 17
                //                       ? NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0).substring(0, 15) + "..."
                //                       : NumberFormat.currency(locale: 'ID').format(double.tryParse(listDataHome[index].viewListStoreProductResponse[indexs].priceProduct) ?? 0),
                //                   style: NeumorphicStyle(color: Colors.red, depth: 1, intensity: 1, surfaceIntensity: 1),
                //                   textStyle: NeumorphicTextStyle(
                //                     fontSize: 11.sp,
                //                     fontFamily: 'ghotic',
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //               Container(
                //                 padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                //                 child: Row(
                //                   children: [
                //                     Neumorphic(
                //                       style: NeumorphicStyle(depth: 1.5, intensity: 1, surfaceIntensity: 1, boxShape: NeumorphicBoxShape.circle()),
                //                       child: Container(
                //                         width: 7.w,
                //                         height: 7.w,
                //                         child: CachedNetworkImage(
                //                           imageUrl: listDataHome[index].viewListStoreProductResponse[indexs].store.uriStoreImage + dummyImageVersion,
                //                           fit: BoxFit.cover,
                //                           errorWidget: (context, url, error) {
                //                             return Icon(
                //                               Icons.person,
                //                               color: Colors.black,
                //                             );
                //                           },
                //                           progressIndicatorBuilder: (context, url, error) {
                //                             return CircularProgressIndicator();
                //                           },
                //                         ),
                //                       ),
                //                     ),
                //                     Container(
                //                       padding: EdgeInsets.symmetric(horizontal: 1.w),
                //                       child: NeumorphicText(
                //                         listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.length > 17 ? listDataHome[index].viewListStoreProductResponse[indexs].store.storeName.substring(0, 15) + "..." : listDataHome[index].viewListStoreProductResponse[indexs].store.storeName,
                //                         style: NeumorphicStyle(color: Colors.white, depth: 1, intensity: 1, surfaceIntensity: 1),
                //                         textStyle: NeumorphicTextStyle(
                //                           fontSize: 9.sp,
                //                           fontFamily: 'ghotic',
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // )
              ],
            );
          },
        ),
      );
    }
  }

  Future<void> _getAllProduct() async {
    setState(() {
      isLoading = true;
    });
    PayloadResponseApi<dynamic> responseApi = await HomeScreenCubit().getHomeSeeAllProduct();
    var itemList;
    List<PayloadResponseHomeSeeAllProduct> list = [];
    if (responseApi.errorMessage.isEmpty) {
      list = responseApi.data;
      // itemList = list
      //     .where((element) => element.titleTab.toLowerCase().contains("semua"))
      //     .single;
    }
    List<int> listMyOutletLocal = [];
    PayloadResponseApi<PayloadResponseMyProfileDashboard?> myProfile = await ProfileRepository().myProfileDashboard("token");
    var dataMyProfile = myProfile.data;
    if (dataMyProfile != null) {
      var myOutlets = dataMyProfile.myOutlets;
      if (myOutlets != null) {
        myOutlets.forEach((element) {
          listMyOutletLocal.add(element.storeId ?? 0);
        });
      }
    }

    setState(() {
      listDataHome = list;
      isLoading = false;
      listMyOutlets = listMyOutletLocal;
    });
  }
}
