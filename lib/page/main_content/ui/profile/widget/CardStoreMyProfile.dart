import 'dart:math' as math;

import 'package:bekal/page/main_content/cubit/profile/profile_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/my_store/DashboardMyStore.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogBuatToko.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahBasicInformationStore.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class CardStoreMyProfile extends StatefulWidget {
  final List<MyDashboardProfileOutlets> data;
  const CardStoreMyProfile({Key? key, required this.data}) : super(key: key);

  @override
  _CardStoreMyProfile createState() => _CardStoreMyProfile();
}

class _CardStoreMyProfile extends State<CardStoreMyProfile> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.data.length > 0) {
      return Container(
        width: 100.w,
        child: PageView.builder(
          itemCount: widget.data != null ? widget.data.length : 0,
          controller: PageController(viewportFraction: 0.025.w.h),
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (_, i) {
            return Transform.scale(
              // scale: 0.3.w,
              scale: i == _index ? 0.034.w.h : 0.027.w.h,
              // child: AspectRatio(
              // aspectRatio: 2.370,
              child: Neumorphic(
                margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                padding: EdgeInsets.all(.2.h),
                style: NeumorphicStyle(
                    color:
                        Color((100 * 0xFFFFFF * 100).toInt()).withOpacity(.8),
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(.5.w.h))),
                    depth: -.2.h,
                    surfaceIntensity: .5,
                    intensity: 1),
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.all(0.5.h),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton(
                            icon: NeumorphicIcon(
                              Icons.settings_rounded,
                              style: NeumorphicStyle(
                                depth: .08.w.h,
                                surfaceIntensity: 1,
                                intensity: 1,
                                color: Colors.black54,
                              ),
                              size: (1.w.h),
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'basicInformation',
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.store_rounded),
                                      ),
                                      Text(
                                        "Informasi Dasar",
                                        style: TextStyle(
                                          fontFamily: 'ghotic',
                                          fontSize: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'customerView',
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.visibility_outlined),
                                      ),
                                      Text(
                                        "Lihat Sebagai Customer",
                                        style: TextStyle(
                                          fontFamily: 'ghotic',
                                          fontSize: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'createProduct',
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.visibility_outlined),
                                      ),
                                      Text(
                                        "Buat Produk",
                                        style: TextStyle(
                                          fontFamily: 'ghotic',
                                          fontSize: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ];
                            },
                            onSelected: (String value) {
                              switch (value) {
                                case 'basicInformation':
                                  DialogBottomSheet(
                                      title: "Informasi Dasar Toko",
                                      icon: Icons.store_rounded,
                                      contentBody:
                                          DialogUbahBasicInformationStore(
                                        data: widget.data.elementAt(i),
                                        onDismiss: (onDismiss) {
                                          if (onDismiss) {}
                                        },
                                      ),
                                      context: context,
                                      whenClosed: (whenClosed) {
                                        if (whenClosed != null && whenClosed) {
                                          context
                                              .read<ProfileScreenCubit>()
                                              .LoadMyProfileDashboard();
                                          Future.delayed(
                                              Duration(milliseconds: 1), () {
                                            // Navigator.of(context).pop();
                                          });
                                        }
                                      });
                                  break;
                                case 'createProduct':
                                  DashboardMyStore(
                                    data: widget.data.elementAt(i),
                                    context: context,
                                    whenClosed: (whenClosed) {
                                      context
                                          .read<ProfileScreenCubit>()
                                          .LoadMyProfileDashboard();
                                    },
                                  );
                              }
                              // if (value == 'basicInformation') {
                              //
                              // }
                            }),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          // NeumorphicButton(
                          //   onPressed: () {
                          //     DialogBottomSheet(
                          //         contentBody: DialogUbahBasicInformationStore(
                          //           onDismiss: (onDismiss) {
                          //             if (onDismiss) {
                          //               BlocProvider.of<ProfileScreenCubit>(
                          //                   context)
                          //                   .LoadMyProfileDashboard();
                          //               Future.delayed(Duration(milliseconds: 1),
                          //                       () {
                          //                     Navigator.of(context).pop();
                          //                   });
                          //             }
                          //           },
                          //         ),
                          //         context: context,
                          //         whenClosed: (whenClosed) {
                          //           if (whenClosed != null && whenClosed) {
                          //             print("waw");
                          //           }
                          //         });
                          //   },
                          //   padding: const EdgeInsets.only(
                          //       top: 5, bottom: 5, left: 15, right: 15),
                          //   style: NeumorphicStyle(
                          //       color: Color((100 * 0xFFFFFF * 103).toInt())
                          //           .withOpacity(0),
                          //       shape: NeumorphicShape.flat,
                          //       depth: .2.h,
                          //       intensity: 1),
                          //   child: Text(
                          //     "Ubah Informasi Dasar",
                          //     style: TextStyle(fontSize: 10.sp),
                          //   ),
                          // ),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Neumorphic(
                                padding: EdgeInsets.all(0),
                                style: NeumorphicStyle(
                                    color: Colors.white,
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    depth: .2.h,
                                    intensity: 1),
                                child: Container(
                                  width: 2.0.w.h,
                                  height: 2.0.w.h,
                                  child: AspectRatio(
                                    aspectRatio: 1.w / 1.w,
                                    child: widget.data != null
                                        ? widget.data.elementAt(i).image != null
                                            ? Image.network(
                                                "${widget.data.elementAt(i).image}?dummy=${math.Random().nextInt(999)}",
                                                fit: BoxFit.cover,
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
                            SizedBox(
                              height: .8.h,
                            ),
                            Text(
                              widget.data.elementAt(i).nameOutlet!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: .8.h,
                            ),
                            Text(
                              widget.data.elementAt(i).addressOutlet!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // ),
            );
          },
        ),
      );
    } else {
      return NeumorphicButton(
        onPressed: () {
          DialogBottomSheet(
              title: "Buat Toko",
              icon: Icons.store_rounded,
              contentBody: DialogBuatToko(
                onDismiss: (onDismiss) {
                  if (onDismiss) {
                    BlocProvider.of<ProfileScreenCubit>(context)
                        .LoadMyProfileDashboard();
                    Future.delayed(Duration(milliseconds: 1), () {
                      Navigator.of(context).pop();
                    });
                  }
                },
              ),
              context: context,
              whenClosed: (whenClosed) {
                if (whenClosed != null && whenClosed) {
                  print("waw");
                }
              });
        },
        margin: EdgeInsets.symmetric(vertical: 1.5.h),
        padding: EdgeInsets.all(.2.h),
        style: NeumorphicStyle(
            color: Color((100 * 0xFFFFFF * 100).toInt()).withOpacity(.98),
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(.5.w.h))),
            depth: -.2.h,
            surfaceIntensity: .5,
            intensity: 1),
        child: Container(
            alignment: Alignment.center,
            width: 90.w,
            padding: EdgeInsets.all(1.w.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicButton(
                  padding: EdgeInsets.all(.25.w.h),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      color: Colors.white,
                      boxShape: NeumorphicBoxShape.stadium(),
                      depth: .2.h,
                      surfaceIntensity: .5,
                      intensity: 1),
                  child: Wrap(children: [
                    NeumorphicIcon(
                      Icons.add_outlined,
                      style: NeumorphicStyle(
                        depth: .03.w.h,
                        surfaceIntensity: 1,
                        intensity: 1,
                        color: Colors.transparent,
                      ),
                      size: (1.w.h),
                    ),
                  ]),
                  onPressed: () {
                    DialogBottomSheet(
                        title: "Buat Toko",
                        icon: Icons.store_rounded,
                        contentBody: DialogBuatToko(
                          onDismiss: (onDismiss) {
                            if (onDismiss) {
                              BlocProvider.of<ProfileScreenCubit>(context)
                                  .LoadMyProfileDashboard();
                              Future.delayed(Duration(milliseconds: 1), () {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                        ),
                        context: context,
                        whenClosed: (whenClosed) {
                          if (whenClosed != null && whenClosed) {
                            print("waw");
                          }
                        });
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                NeumorphicText(
                  "Buat Toko",
                  textAlign: TextAlign.left,
                  textStyle: NeumorphicTextStyle(
                    fontFamily: 'ghotic',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  style: NeumorphicStyle(
                    color: Colors.white,
                    depth: .2.h,
                    surfaceIntensity: 1,
                    intensity: 1,
                  ),
                )
              ],
            )),
      );
    }
  }
}

DialogBottomSheet({
  required BuildContext context,
  ValueChanged<bool>? whenClosed,
  required Widget contentBody,
  required String title,
  required IconData icon,
}) {
  return showMaterialModalBottomSheet(
    duration: Duration(milliseconds: 1400),
    animationCurve: Curves.easeInOut,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Neumorphic(
        margin: EdgeInsets.only(top: 10.h),
        // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        style: NeumorphicStyle(
            surfaceIntensity: .5,
            color: Colors.blueGrey,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.vertical(
                top: Radius.circular(.8.w.h), bottom: Radius.circular(.8.w.h))),
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
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NeumorphicIcon(
                              icon,
                              style: NeumorphicStyle(
                                color: Colors.white12,
                                depth: .2.h,
                                surfaceIntensity: .3,
                                intensity: 1,
                              ),
                              size: (1.5.w.h),
                            ),
                            NeumorphicText(
                              title,
                              textAlign: TextAlign.left,
                              textStyle: NeumorphicTextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              style: NeumorphicStyle(
                                color: Colors.white70,
                                depth: .09.h,
                                surfaceIntensity: 1,
                                intensity: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(child: contentBody)
                    ],
                  )),
            )
          ],
        ),
      );
    },
  );
}

TValue case2<TOptionType, TValue>({
  required TOptionType condition,
  required Map<TOptionType, TValue> selection,
  required TValue defaultValue,
}) {
  return selection.entries.firstWhere((entry) => entry.key == condition).value;
  // if (!selection.containsKey(condition)) {
  //   return defaultValue;
  // }
}
