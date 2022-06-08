import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:bekal/main.dart';
import 'package:bekal/page/main_content/cubit/profile/profile_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/profile/widget/CardStoreMyProfile.dart';
import 'package:bekal/page/main_content/ui/profile/widget/ListMenuMyProfile.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State createState() {
    return _ProfileScreen();
  }

  final _ProfileScreen myAppState = new _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  Widget? notifikasi;
  var streamProfileScreen = StreamController<
      PayloadResponseApi<PayloadResponseMyProfileDashboard?>>.broadcast();

  PayloadResponseMyProfileDashboard? dataEvent;
  Future<void> getFromApi() async {
    // streamProfileScreen.sink
    //     .add(await ProfileRepository().myProfileDashboard("authorization"));
    var event = await ProfileRepository().myProfileDashboard("authorization");
    List<String> dataSubsFirebase = [];
    if (event.data != null) {
      dataSubsFirebase.add('user-${event.data?.idUser}');
      var myOutlets = event.data?.myOutlets;
      if (myOutlets != null) {
        myOutlets.forEach((element) {
          dataSubsFirebase.add('store-${element.storeId}');
        });
      }
      await SecureStorage().saveSubscribeFirebase(jsonEncode(dataSubsFirebase));
      streamSubsUnSubs.sink.add("subscribe");
      setState(() {
        dataEvent = event.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFromApi();
    _askPermission();
  } // ProfileScreen();

  @override
  void dispose() {
    // TODO: implement dispose
    streamProfileScreen.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileScreenCubit>(
      create: (context) => ProfileScreenCubit(),
      child: Scaffold(
          backgroundColor: const Color(0x26000000),
          body: dataEvent != null
              ? ProfileContent(
                  data: dataEvent!,
                  context: context,
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
          // StreamBuilder(
          //   stream: streamProfileScreen.stream,
          //   builder: (context,
          //       AsyncSnapshot<
          //               PayloadResponseApi<PayloadResponseMyProfileDashboard?>>
          //           snapshot) {
          //     print('profile ${snapshot.data}');
          //     if (snapshot.hasData) {
          //       if (snapshot.data != null) {
          //         if (snapshot.data!.data != null) {
          //           return ProfileContent(
          //             data: snapshot.data!.data!,
          //             context: context,
          //           );
          //         }
          //       }
          //     }
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // ),

          ///////////////////////////////////
          // body: BlocBuilder<ProfileScreenCubit, ProfileScreenCubitState>(
          //   builder: (cubitContext, cubitState) {
          //     var container = Container(
          //       child: null,
          //     );
          //     if (cubitState is InitialStateProfileScreenCubitState) {
          //       cubitContext.read<ProfileScreenCubit>().LoadMyProfileDashboard();
          //       return LoadingContent(
          //         child: ProfileContent(
          //           null,
          //           cubitState: cubitState,
          //           cubitContext: cubitContext,
          //         ),
          //       );
          //     } else {
          //       return Stack(
          //         children: <Widget>[
          //           Pinned.fromPins(
          //             Pin(size: 207.0, end: 0.0),
          //             Pin(size: 212.0, start: 0.0),
          //             child: Stack(
          //               children: <Widget>[
          //                 Pinned.fromPins(
          //                   Pin(size: 103.0, end: 0.0),
          //                   Pin(size: 134.0, start: 0.0),
          //                   child: SvgPicture.string(
          //                     _svg_dh7r5a,
          //                     allowDrawingOutsideViewBox: true,
          //                     fit: BoxFit.fill,
          //                   ),
          //                 ),
          //                 Pinned.fromPins(
          //                   Pin(size: 77.0, middle: 0.3),
          //                   Pin(size: 77.0, middle: 0.7111),
          //                   child: Container(
          //                     decoration: const BoxDecoration(
          //                       borderRadius: BorderRadius.all(
          //                           Radius.elliptical(9999.0, 9999.0)),
          //                       color: Color(0xfff39200),
          //                       boxShadow: [
          //                         BoxShadow(
          //                           color: Color(0x29000000),
          //                           offset: Offset(0, 3),
          //                           blurRadius: 6,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 Pinned.fromPins(
          //                   Pin(size: 39.0, start: 0.0),
          //                   Pin(size: 39.0, end: 0.0),
          //                   child: Container(
          //                     decoration: const BoxDecoration(
          //                       borderRadius: BorderRadius.all(
          //                           Radius.elliptical(9999.0, 9999.0)),
          //                       color: Color(0xfff39200),
          //                       boxShadow: [
          //                         BoxShadow(
          //                           color: Color(0x29000000),
          //                           offset: Offset(0, 3),
          //                           blurRadius: 6,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             color: Colors.blue,
          //             width: 100.w,
          //             height: 100.h,
          //             child: cubitState is LoadProfileSukses
          //                 ? ProfileContent(cubitState.data,
          //                     cubitState: cubitState, cubitContext: cubitContext)
          //                 : Container(
          //                     color: Colors.red,
          //                     height: 100.h,
          //                     width: 100.w,
          //                   ),
          //           ),
          //           // Container(
          //           //   child: cubitState is LoadProfileSukses
          //           //       ? ProfileContent(cubitState.data,
          //           //       cubitState: cubitState, cubitContext: cubitContext)
          //           //       : LoadingContent(
          //           //     child: ProfileContent(
          //           //       null,
          //           //       cubitState: cubitState,
          //           //       cubitContext: cubitContext,
          //           //     ),
          //           //   ),
          //           // ),
          //
          //           // Container(
          //           //   child: notifikasi != null ? notifikasi : Container(),
          //           // )
          //         ],
          //       );
          //     }
          //   },
          // ),
          ),
    );
  }

  Widget ProfileContent({
    required PayloadResponseMyProfileDashboard data,
    required BuildContext context,
  }) {
    return Center(
      child: Container(
        width: 100.w,
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Neumorphic(
              padding: EdgeInsets.all(.8.h),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              style: NeumorphicStyle(
                  color: Color((265 * 0xFFFFFF * 100).toInt()).withOpacity(1),
                  shape: NeumorphicShape.concave,
                  depth: .2.h,
                  intensity: 1),
              child: Column(
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
                        width: 20.w,
                        height: 20.w,
                        child: CachedNetworkImage(
                          imageUrl:
                              '${data.image ?? ""}?dummy=${math.Random().nextInt(999)}',
                          errorWidget: (context, url, error) {
                            return Icon(
                              Icons.person,
                              color: Colors.black,
                            );
                          },
                          progressIndicatorBuilder: (context, widget, error) {
                            return CircularProgressIndicator(
                              color: Colors.blue,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    height: .8.h,
                  ),
                  Text(
                    "Hallo, ${data != null ? data.nameUser : "No Connection Internet"}",
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
                    "${data != null ? data.emailUser : "No Connection Internet"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ghotic',
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: .8.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 30.h,
              child: CardStoreMyProfile(
                  data: data.myOutlets!,
                  callbackOnRefresh: () {
                    getFromApi();
                  }),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListMenuMyProfile(
                cubitContext: context,
                onPressedBack: (bool) {
                  if (bool) {
                    getFromApi();
                  }
                },
                data: data,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _askPermission() async {
    final Permission location_permission = await Permission.photos;
    bool location_status = false;

    bool ispermanetelydenied =
        await location_permission.request().isPermanentlyDenied;
    if (ispermanetelydenied) {
      print("denied");
      await openAppSettings();
    }
    // else{
    //
    //   location_status=location_statu.isGranted;
    //
    //   print(await location_statu.name);
    // }
    // // if(!camerarequest.isGranted){
    // //   await Permission.camera.shouldShowRequestRationale;
    // //
    // // }
  }

  // Container ProfileContent(PayloadResponseMyProfileDashboard? data,
  //     {ProfileScreenCubitState? cubitState, BuildContext? cubitContext}) {
  //   if (data != null) {
  //     print("call content");
  //   }
  //
  //   return Container(
  //     // color: Colors.black38,
  //     width: 100.w,
  //     height: 100.h,
  //     padding: EdgeInsets.all(0),
  //     color: Colors.blue,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 3.h,
  //           ),
  //           Neumorphic(
  //             padding: EdgeInsets.all(.8.h),
  //             style: NeumorphicStyle(
  //                 color: Color((265 * 0xFFFFFF * 100).toInt()).withOpacity(1),
  //                 shape: NeumorphicShape.concave,
  //                 depth: .2.h,
  //                 intensity: 1),
  //             child: Container(
  //               width: 90.w,
  //               padding: EdgeInsets.all(1.h),
  //               child: Column(
  //                 children: [
  //                   Neumorphic(
  //                       padding: EdgeInsets.all(0),
  //                       style: NeumorphicStyle(
  //                           color: Colors.white,
  //                           shape: NeumorphicShape.concave,
  //                           boxShape: NeumorphicBoxShape.circle(),
  //                           depth: .2.h,
  //                           intensity: 1),
  //                       child: Container(
  //                         width: 3.w.h,
  //                         height: 3.w.h,
  //                         child: AspectRatio(
  //                           aspectRatio: 1.w / 1.w,
  //                           child: data != null
  //                               ? data.image != null
  //                                   ? Image.network(
  //                                       "${data.image}?dummy=${math.Random().nextInt(999)}",
  //                                       fit: BoxFit.cover,
  //                                     )
  //                                   : Align(
  //                                       alignment: Alignment.center,
  //                                       child: NeumorphicIcon(
  //                                         Icons.camera_alt_outlined,
  //                                         size: 1.w.h,
  //                                         style: NeumorphicStyle(
  //                                           depth: .05.w.h,
  //                                           surfaceIntensity: 1,
  //                                           intensity: 1,
  //                                           color: Colors.black54,
  //                                         ),
  //                                       ),
  //                                     )
  //                               : Align(
  //                                   alignment: Alignment.center,
  //                                   child: NeumorphicIcon(
  //                                     Icons.camera_alt_outlined,
  //                                     size: 1.w.h,
  //                                     style: NeumorphicStyle(
  //                                       depth: .05.w.h,
  //                                       surfaceIntensity: 1,
  //                                       intensity: 1,
  //                                       color: Colors.black54,
  //                                     ),
  //                                   ),
  //                                 ),
  //                         ),
  //                       )),
  //                   SizedBox(
  //                     height: .8.h,
  //                   ),
  //                   Text(
  //                     "Hallo, ${data != null ? data.nameUser : "No Connection Internet"}",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontFamily: 'ghotic',
  //                       fontSize: 14.sp,
  //                       fontWeight: FontWeight.w900,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: .8.h,
  //                   ),
  //                   Text(
  //                     "${data != null ? data.emailUser : "No Connection Internet"}",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontFamily: 'ghotic',
  //                       fontSize: 12.sp,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: .8.h,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 3.h,
  //           ),
  //           data != null
  //               ? CardStoreMyProfile(
  //                   data: data.myOutlets!,
  //                 )
  //               : Container(),
  //
  //           // SizedBox(
  //           //   height: 3.h,
  //           // ),
  //           // SizedBox(
  //           //   width: 90.w,
  //           //   child: ListMenuMyProfile(
  //           //     cubitContext: cubitContext,
  //           //     onPressed: () {},
  //           //     data: data ?? PayloadResponseMyProfileDashboard(),
  //           //   ),
  //           // ),
  //           // SizedBox(
  //           //   height: 3.h,
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// Widget listMenuItemProfile(
//     {required int index,
//     required ProfileScreenCubitState cubitState,
//     required BuildContext cubitContext,
//     Onpressed}) {
//   return ListMenuItemMyProfile();
// }

// class ListMenuItemMyProfile extends StatelessWidget {
//   final BuildContext cubitContext;
//   final ProfileScreenCubitState cubitState;
//   final int index;
//   final Function() onPressed;
//   const ListMenuItemMyProfile({
//     Key? key,
//     required this.index,
//     required this.cubitState,
//     required this.cubitContext,
//     required this.onPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }

const String _svg_dh7r5a =
    '<svg viewBox="272.0 0.0 103.0 134.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(265.0, -18.0)" d="M 7.000200271606445 75.99960327148438 C 7.000200271606445 52.75083923339844 17.43889617919922 31.94074630737305 33.88558197021484 18 L 109.9998016357422 18 L 109.9998016357422 147.0644226074219 C 101.609245300293 150.2543182373047 92.50958251953125 152.0001068115234 82.99980163574219 152.0001068115234 C 41.0265007019043 152.0001068115234 7.000200271606445 117.9738006591797 7.000200271606445 75.99960327148438 Z" fill="#f39200" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_srjxy =
    '<svg viewBox="0.0 0.0 11.6 11.6" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="1"/></filter></defs><path  d="M 11.58839988708496 5.79419994354248 C 11.58839988708496 8.994250297546387 8.994248390197754 11.58839988708496 5.79419994354248 11.58839988708496 C 2.594151496887207 11.58839988708496 0 8.994248390197754 0 5.79419994354248 C 0 2.594151496887207 2.594151973724365 0 5.79419994354248 0 C 8.994250297546387 0 11.58839988708496 2.594151973724365 11.58839988708496 5.79419994354248 Z M 5.537968158721924 7.710793018341064 C 5.396366596221924 7.852396011352539 5.396366596221924 8.081978797912598 5.537968635559082 8.223581314086914 C 5.67957067489624 8.365182876586914 5.909153461456299 8.365182876586914 6.050755977630615 8.223580360412598 L 8.223580360412598 6.050755023956299 C 8.291691780090332 5.982814311981201 8.329970359802246 5.890565395355225 8.329970359802246 5.794361114501953 C 8.329970359802246 5.698158264160156 8.291691780090332 5.605907917022705 8.223580360412598 5.537968158721924 L 6.050755023956299 3.365143060684204 C 5.909153461456299 3.223540782928467 5.67957067489624 3.223540782928467 5.537968158721924 3.365143060684204 C 5.396366596221924 3.506745338439941 5.396366596221924 3.736327886581421 5.537968635559082 3.877929925918579 L 7.092745304107666 5.43206262588501 L 3.621375560760498 5.43206262588501 C 3.421371936798096 5.43206262588501 3.259238004684448 5.594197273254395 3.259238004684448 5.79419994354248 C 3.259238004684448 5.994203567504883 3.421371936798096 6.156337738037109 3.621375560760498 6.156337738037109 L 7.092745304107666 6.156337738037109 L 5.537646293640137 7.710793018341064 Z" fill="#000000" stroke="none" stroke-width="0.4166666567325592" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_e9i5 =
    '<svg viewBox="0.0 0.0 14.0 14.1" ><path transform="translate(-1.16, -1.16)" d="M 8.152422904968262 1.158839821815491 C 4.29010009765625 1.158839821815491 1.158840656280518 4.31195068359375 1.158840656280518 8.201226234436035 C 1.158840656280518 12.09050178527832 4.29010009765625 15.24361228942871 8.152422904968262 15.24361228942871 C 12.01474475860596 15.24361228942871 15.14600372314453 12.09050178527832 15.14600372314453 8.201226234436035 C 15.14600372314453 4.31195068359375 12.01520919799805 1.158839821815491 8.152422904968262 1.158839821815491 Z M 11.64921092987061 8.905466079711914 L 8.851780891418457 8.905466079711914 L 8.851780891418457 11.72241878509521 L 7.453064441680908 11.72241878509521 L 7.453064441680908 8.905466079711914 L 4.655632019042969 8.905466079711914 L 4.655632019042969 7.496987819671631 L 7.453064441680908 7.496987819671631 L 7.453064441680908 4.680033683776855 L 8.851780891418457 4.680033683776855 L 8.851780891418457 7.496987819671631 L 11.64921092987061 7.496987819671631 L 11.64921092987061 8.905466079711914 Z" fill="#000000" stroke="none" stroke-width="0.38628000020980835" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
