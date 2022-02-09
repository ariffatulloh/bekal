import 'package:bekal/page/main_content/cubit/cubit_my_store/DashboardMyStoreCubit.dart';
import 'package:bekal/page/main_content/ui/my_store/CreateProduct.dart';
import 'package:bekal/page/main_content/ui/my_store/widget_create_product/BodyListProduct.dart';
import 'package:bekal/page/main_content/ui/my_store/widget_create_product/TabHeaderListCategory.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

DashboardMyStore({
  required BuildContext context,
  ValueChanged<bool>? whenClosed,
  required MyDashboardProfileOutlets data,
}) {
  return showMaterialModalBottomSheet(
    duration: Duration(milliseconds: 1400),
    animationCurve: Curves.easeInOut,
    enableDrag: false,
    backgroundColor: Colors.blueGrey,
    context: context,
    builder: (context) {
      return DashboardMyStores(
        data: data,
        whenClosed: whenClosed,
      );
    },
  );
}

class DashboardMyStores extends StatefulWidget {
  ValueChanged<bool>? whenClosed;

  MyDashboardProfileOutlets data;
  DashboardMyStores({
    this.whenClosed,
    required this.data,
  });
  @override
  _DashboardMyStores createState() => _DashboardMyStores();
}

class _DashboardMyStores extends State<DashboardMyStores> {
  String selectedCategoryName = "";
  int selectedIndexHeaderCategory = 0;
  @override
  Widget build(BuildContext context) {
    ValueChanged<bool>? whenClosed = widget.whenClosed;

    MyDashboardProfileOutlets data = widget.data;

    return Neumorphic(
      style: NeumorphicStyle(
          surfaceIntensity: .5,
          color: Colors.transparent,
          depth: .2.h,
          intensity: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: NeumorphicButton(
              padding: EdgeInsets.all(.25.w.h),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  color: Colors.transparent,
                  boxShape: NeumorphicBoxShape.stadium(),
                  depth: .2.h,
                  surfaceIntensity: .5,
                  intensity: 1),
              child: Wrap(children: [
                NeumorphicIcon(
                  Icons.arrow_back_ios_rounded,
                  style: NeumorphicStyle(
                    color: Colors.white70,
                    depth: .2.h,
                    surfaceIntensity: .3,
                    intensity: 1,
                  ),
                  size: (.5.w.h),
                ),
              ]),
              onPressed: () {
                if (whenClosed != null) {
                  whenClosed(true);
                  Future.delayed(Duration(milliseconds: 1), () {
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ),
          FutureBuilder(
            future: DashboardMyStoreCubit().getCategory(idStore: data.storeId!),
            builder: (context, snapshot) {
              PayloadResponseApi snapshotData =
                  snapshot.data as PayloadResponseApi;

              print("$selectedIndexHeaderCategory notimes");
              return TabHeaderListCategory(
                selectedIndex: selectedIndexHeaderCategory.isNaN
                    ? 0
                    : selectedIndexHeaderCategory,
                idStore: data.storeId!,
                listCategory: snapshotData.data,
                // cubitContext:cubitContext,
                selectedCategoryName: (passParameterTabHeaderListCategory) {
                  print(passParameterTabHeaderListCategory.index);
                  setState(() {
                    selectedIndexHeaderCategory =
                        passParameterTabHeaderListCategory.index;
                    selectedCategoryName =
                        passParameterTabHeaderListCategory.value;
                  });
                  // selectedCategoryName
                  // setState(() {
                  //   selectedCategoryName = value;
                  // });
                  // cubitContext
                  //     .read<DashboardMyStoreCubit>()
                  //     .LoadDataProduct();
                },
              );
//here you should check snapshot.connectionState
              return SizedBox();
            },
          ),
          FutureBuilder(
            future: DashboardMyStoreCubit().getProduct(
                storeName: data.nameOutlet!,
                categoryName: selectedCategoryName == null
                    ? "All"
                    : selectedCategoryName.isEmpty
                        ? "All"
                        : selectedCategoryName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                PayloadResponseApi data = snapshot.data as PayloadResponseApi;
                if (data.errorMessage.isEmpty) {
                  var list = data.data as List<PayloadResponseStoreProduct>;
                  return BodyListProduct(data: list);
                }
              }
//here you should check snapshot.connectionState
              return Expanded(child: Container());
            },
          ),
          Neumorphic(
            margin: EdgeInsets.symmetric(horizontal: 0.w),
            style: NeumorphicStyle(
              color: Colors.transparent,
              depth: .2.h,
              shadowLightColorEmboss: Colors.white70,
              shadowDarkColorEmboss: Colors.black87,
              shadowDarkColor: Colors.black87,
              boxShape: NeumorphicBoxShape.rect(),
              surfaceIntensity: 1,
              intensity: .8,
            ),
            child: Container(
                width: 100.w,
                height: 7.h,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: .7.h),
                        padding: EdgeInsets.only(
                            top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            color: Colors.blue,
                            boxShape: NeumorphicBoxShape.stadium(),
                            depth: .2.h,
                            surfaceIntensity: .3,
                            intensity: .9),
                        child: Align(
                            alignment: Alignment.center,
                            child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Buat Product",
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.white),
                                  ),
                                ])),
                        onPressed: () {
                          showMaterialModalBottomSheet(
                              duration: Duration(milliseconds: 1400),
                              animationCurve: Curves.easeInOut,
                              enableDrag: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return CreateProduct();
                              });
                        }),
                    NeumorphicButton(
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: .7.h),
                      padding: EdgeInsets.only(
                          top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          color: Colors.blue,
                          boxShape: NeumorphicBoxShape.stadium(),
                          depth: .2.h,
                          surfaceIntensity: .3,
                          intensity: .9),
                      child: Align(
                          alignment: Alignment.center,
                          child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.search, color: Colors.white),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "Cari Product",
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.white),
                                ),
                              ])),
                      onPressed: () {
                        print("value is $selectedCategoryName");
                      },
                    )
                  ],
                )

// child: SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   physics: const AlwaysScrollableScrollPhysics(),
//   child: Row(
//     children: [
//       NeumorphicButton(
//         margin:
//             EdgeInsets.symmetric(horizontal: 2.w, vertical: .7.h),
//         padding: EdgeInsets.only(
//             top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
//         style: NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//             color: Colors.blue,
//             boxShape: NeumorphicBoxShape.stadium(),
//             depth: .2.h,
//             surfaceIntensity: .3,
//             intensity: .9),
//         child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Icon(Icons.all_inclusive, color: Colors.white),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 "All",
//                 style: TextStyle(
//                     fontSize: 10.sp, color: Colors.white),
//               ),
//             ]),
//         onPressed: () {},
//       ),
//       NeumorphicButton(
//         margin: EdgeInsets.symmetric(horizontal: 2.w),
//         padding: EdgeInsets.only(
//             top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
//         style: NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//             color: Colors.blue,
//             boxShape: NeumorphicBoxShape.stadium(),
//             depth: .2.h,
//             surfaceIntensity: .3,
//             intensity: .9),
//         child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Icon(Icons.all_inclusive, color: Colors.white),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 "All",
//                 style: TextStyle(
//                     fontSize: 10.sp, color: Colors.white),
//               ),
//             ]),
//         onPressed: () {},
//       ),
//       NeumorphicButton(
//         margin: EdgeInsets.symmetric(horizontal: 2.w),
//         padding: EdgeInsets.only(
//             top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
//         style: NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//             color: Colors.blue,
//             boxShape: NeumorphicBoxShape.stadium(),
//             depth: .2.h,
//             surfaceIntensity: .3,
//             intensity: .9),
//         child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Icon(Icons.all_inclusive, color: Colors.white),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 "All",
//                 style: TextStyle(
//                     fontSize: 10.sp, color: Colors.white),
//               ),
//             ]),
//         onPressed: () {},
//       ),
//       NeumorphicButton(
//         margin: EdgeInsets.symmetric(horizontal: 2.w),
//         padding: EdgeInsets.only(
//             top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
//         style: NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//             color: Colors.blue,
//             boxShape: NeumorphicBoxShape.stadium(),
//             depth: .2.h,
//             surfaceIntensity: .3,
//             intensity: .9),
//         child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Icon(Icons.all_inclusive, color: Colors.white),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 "All",
//                 style: TextStyle(
//                     fontSize: 10.sp, color: Colors.white),
//               ),
//             ]),
//         onPressed: () {},
//       ),
//       NeumorphicButton(
//         margin: EdgeInsets.symmetric(horizontal: 2.w),
//         padding: EdgeInsets.only(
//             top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
//         style: NeumorphicStyle(
//             shape: NeumorphicShape.convex,
//             color: Colors.blue,
//             boxShape: NeumorphicBoxShape.stadium(),
//             depth: .2.h,
//             surfaceIntensity: .3,
//             intensity: .9),
//         child: Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               Icon(Icons.all_inclusive, color: Colors.white),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 "All",
//                 style: TextStyle(
//                     fontSize: 10.sp, color: Colors.white),
//               ),
//             ]),
//         onPressed: () {},
//       ),
//     ],
//   ),
// ),
                ),
          ),
        ],
      ),
    );
  }
}
