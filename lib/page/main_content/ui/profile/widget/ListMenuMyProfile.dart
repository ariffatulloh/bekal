import 'dart:math' as math;

import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/profile/model/ModelItemListMenuMyProfile.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahAlamat.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahDataPribadi.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahEmail.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahPassword.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class ListMenuMyProfile extends StatelessWidget {
  final BuildContext cubitContext;
  // final ProfileScreenCubitState cubitState;
  // final int index;
  final ValueChanged<Widget> notify;
  final Function() onPressed;
  const ListMenuMyProfile({
    Key? key,
    // required this.index,
    // required this.cubitState,
    required this.cubitContext,
    required this.onPressed,
    required this.notify,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ModelItemListMenuMyProfile> datatitle = [
      ModelItemListMenuMyProfile(
        text: "Ubah Data Pribadi",
        icon: Icons.person,
        widget: DialogUbahDataPribadi(),
      ),
      ModelItemListMenuMyProfile(
        text: "Ubah Email",
        icon: Icons.alternate_email_outlined,
        widget: DialogUbahEmail(),
      ),
      ModelItemListMenuMyProfile(
        text: "Ubah Password",
        icon: Icons.vpn_key_sharp,
        widget: DialogUbahPassword(),
      ),
      ModelItemListMenuMyProfile(
        text: "Histori Transaksi",
        icon: Icons.library_books_rounded,
        widget: Container(),
      ),
      ModelItemListMenuMyProfile(
        text: "Keluar",
        icon: Icons.logout,
        widget: Container(),
      ),
      ModelItemListMenuMyProfile(
        text: "Alamat\nRumah",
        icon: Icons.maps_home_work,
        widget: DialogUbahAlamat(),
      ),
    ];
    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      shrinkWrap: true,
      itemCount: datatitle.length,
      itemBuilder: (context, index) {
        // print("grid index $index");
        return NeumorphicButton(
            onPressed: () {
              if (datatitle.elementAt(index).text == "Keluar") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Apakah Anda Ingin Keluar?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          SecureStorage().deleteStorageToken();
                          var token = await SecureStorage().getToken();
                          if (token == null) {
                            print("dismiss dialog");
                            cubitContext
                                .read<ControllerPageCubit>()
                                .goto("LOGIN");
                            Navigator.of(context).pop();
                          } else {}
                        },
                        child: const Text('Ya'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tidak'),
                      ),
                    ],
                  ),
                );
              } else {
                DialogBottomSheet(
                  context: context,
                  dataObject: datatitle.elementAt(index),
                  whenClosed: (Closed) {
                    if (Closed != null && Closed) {
                      BlocProvider.of<ProfileScreenCubit>(context)
                          .LoadMyProfileDashboard();
                    }
                  },
                );
              }
            },
            margin: EdgeInsets.all(.6.h),
            style: NeumorphicStyle(
                color: Color(
                    (math.Random().nextDouble() * 0xFFF444 * 120).toInt()),
                shape: NeumorphicShape.concave,
                depth: .2.h,
                intensity: 1),
            child: Stack(
              children: [
                Container(
                  width: 40.w,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NeumorphicIcon(
                        datatitle.elementAt(index).icon,
                        style: NeumorphicStyle(
                          color: Colors.white12,
                          depth: .2.h,
                          surfaceIntensity: .3,
                          intensity: 1,
                        ),
                        size: (1.5.w.h),
                      ),
                      NeumorphicText(
                        datatitle.elementAt(index).text,
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
                // Positioned(
                //   child: Tooltip(
                //     preferBelow: false,
                //     triggerMode: TooltipTriggerMode.tap,
                //     waitDuration: const Duration(seconds: 0),
                //     showDuration: const Duration(seconds: 2),
                //     textStyle: TextStyle(
                //         fontSize: 10.sp,
                //         color: Colors.white,
                //         fontWeight: FontWeight.normal),
                //     // decoration: BoxDecoration(
                //     //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                //     message: "you need change data",
                //     child: Icon(
                //       Icons.info,
                //       color: Colors.red,
                //       size: 3.h,
                //     ),
                //   ),
                //   right: 10,
                //   top: 10,
                // )
              ],
            ));
      },
    );
  }
}

DialogBottomSheet({
  required BuildContext context,
  required ModelItemListMenuMyProfile dataObject,
  ValueChanged<bool>? whenClosed,
}) {
  Widget formWidget = dataObject.widget;
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
                              dataObject.icon,
                              style: NeumorphicStyle(
                                color: Colors.white12,
                                depth: .2.h,
                                surfaceIntensity: .3,
                                intensity: 1,
                              ),
                              size: (1.5.w.h),
                            ),
                            NeumorphicText(
                              dataObject.text,
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
                      Expanded(
                        child: case2(
                          condition: dataObject.widget.toString(),
                          selection: {
                            DialogUbahDataPribadi().toString():
                                DialogUbahDataPribadi(),
                            DialogUbahEmail().toString(): DialogUbahEmail(
                              onDismiss: (dismiss) {
                                print("dismiss dialog");
                                Navigator.of(context).pop();
                                context
                                    .read<ControllerPageCubit>()
                                    .goto("LOGIN");
                              },
                            ),
                            DialogUbahPassword().toString(): DialogUbahPassword(
                              onDismiss: (dismiss) {
                                print("dismiss dialog");
                                Navigator.of(context).pop();
                                context
                                    .read<ControllerPageCubit>()
                                    .goto("LOGIN");
                              },
                            ),
                            DialogUbahAlamat().toString(): DialogUbahAlamat(
                              onDismiss: (dismiss) {
                                print("dismiss dialog");
                                Navigator.of(context).pop();
                                context
                                    .read<ControllerPageCubit>()
                                    .goto("LOGIN");
                              },
                            ),
                          },
                          defaultValue: Container(),
                        ),
                      )
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
