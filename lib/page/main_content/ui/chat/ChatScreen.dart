import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/main.dart';
import 'package:bekal/page/main_content/ui/chat/ChatDetailScreen.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  bool searchOn = false;
  var selectedIdLoginAs;
  List<PayloadResponseListConversation> listConversation = [];
  List<PopUpList> popUpList = [];
  // var selectedAccount = StreamController<PopUpList>();
  bool isInitializeDone = false;
  late PopUpList snapshotAccount;
  late PayloadResponseApi<PayloadResponseMyProfileDashboard?> profileDashboard;
  var snapshotListChatInternal = StreamController<
      List<Map<String, List<PayloadResponseListConversation>>>>();
  // PopUpList snapshotAccount = null;
  String searchField = "";
  int dummyVersion = math.Random().nextInt(999);
  TextEditingController editingSearchController = TextEditingController();

  List<PayloadResponseListConversation> listChat = [];

  List<PayloadResponseListConversation> listRecentChats = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    searchOn = false;
    selectedIdLoginAs = 0;
    getAccount();
    snapshotListChat.stream.listen((event) {
      print("listchat ${event}");
      getListChatFromApi();
    });
    // getFromApi();

    // selectedAccount.stream.listen((PopUpList event) {
    //   setState(() {});
    // });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // PopUpList snapshotAccount = popUpList;

    if (isInitializeDone) {
      return Container(
          height: 100.h,
          width: 100.w,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: -20.h,
                right: -10.w,
                height: 35.h,
                width: 120.w,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      color: Color(0xfff39200).withOpacity(.8),
                      shadowDarkColorEmboss: Colors.black87,
                      shape: NeumorphicShape.flat,
                      depth: 2,
                      intensity: 1,
                      surfaceIntensity: 1,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                          topLeft: Radius.circular(10.w),
                          topRight: Radius.circular(10.w),
                          bottomRight: Radius.circular(35.w),
                          bottomLeft: Radius.circular(35.w)))),
                  child: Container(
                    color: Colors.transparent,
                    height: 10,
                  ),
                ),
              ),
              Positioned(
                  top: 2.h,
                  width: 100.w,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  color: Colors.white,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  depth: -1,
                                  intensity: 1),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${snapshotAccount.image}?dummy=${dummyVersion}",
                                errorWidget: (context, url, error) {
                                  return new Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  );
                                },
                                progressIndicatorBuilder:
                                    (loadContext, loadWidget, chunkEvent) {
                                  return CircularProgressIndicator(
                                    color: Colors.blue,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          createPopup(),
                          Expanded(
                            child: WidgetTextField(
                              controller: editingSearchController,
                              onDeleteText:
                                  editingSearchController.text.isNotEmpty
                                      ? () {
                                          setState(() {
                                            editingSearchController.clear();
                                          });
                                        }
                                      : null,
                              hint: "History Chat",
                              obSecure: false,
                              icon: Icons.search,
                              messageError: "Silahkan Masukan Deskripsi Produk",
                              isError: false,
                              onChanged: (String? value) {
                                var find = listRecentChats
                                    .where((element) =>
                                        element.chatWith?.fullName
                                            ?.toLowerCase()
                                            .contains(value ?? "") ??
                                        false)
                                    .toList();
                                setState(() {
                                  listChat = find;
                                });
                              },
                              onSaved: (String? value) {
                                // setState(() {
                                //   searchField = value!;
                                // });
                              },
                              textTitleColor: Colors.black,
                              keyboardtype: TextInputType.multiline,
                            ),
                          )
                        ],
                      ))),
              Positioned(
                top: 16.h,
                width: 100.w,
                child: Container(
                    // color: Colors.blue,
                    height: 70.h,
                    child: ListView.builder(
                      itemCount: listChat.length,
                      itemBuilder: (context, index) {
                        return NeumorphicButton(
                            onPressed: () {
                              showMaterialModalBottomSheet(
                                  duration: Duration(seconds: 1),
                                  animationCurve: Curves.easeInOut,
                                  enableDrag: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return SafeArea(
                                        child: ChatDetailScreen(
                                      onClosed: () {
                                        getListChatFromApi();
                                      },
                                      accountSelected: snapshotAccount,
                                      withUser: listChat[index].chatWith!,
                                    ));
                                  });
                            },
                            margin: EdgeInsets.symmetric(
                                vertical: .5.h, horizontal: 1.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5.w, vertical: 1.3.h),
                            style: NeumorphicStyle(
                                color: Colors.white,
                                shape: NeumorphicShape.flat,
                                depth: .1.h,
                                intensity: 1),
                            child: Row(
                              children: [
                                Neumorphic(
                                    padding: EdgeInsets.all(0),
                                    style: NeumorphicStyle(
                                        color: Colors.grey,
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: .2.h,
                                        intensity: 1),
                                    child: Container(
                                      width: 1.2.w.h,
                                      height: 1.2.w.h,
                                      // margin: EdgeInsets.symmetric(vertical: 1.h),
                                      child: AspectRatio(
                                        aspectRatio: 1.w / 1.w,
                                        child: listChat[index].chatWith != null
                                            ? listChat[index].chatWith != null
                                                ? Image.network(
                                                    "${listChat[index].chatWith!.image}?dummy=${math.Random().nextInt(999)}",
                                                    errorBuilder:
                                                        (context, url, error) {
                                                      return new Icon(
                                                        Icons.person,
                                                        color: Colors.white,
                                                      );
                                                    },
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
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        listChat[index].chatWith!.fullName!,
                                        style: TextStyle(
                                            fontFamily: 'ghotic',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${listChat[index].chatFrom!.id == snapshotAccount.id ? 'Anda: ${listChat[index].lastChat!}' : '${listChat[index].chatFrom!.fullName}: ${listChat[index].lastChat!}'}',
                                        style: TextStyle(
                                          fontFamily: 'ghotic',
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ));
                      },
                    )

                    // StreamBuilder(
                    //   stream: snapshotListChatInternal.stream,
                    //   builder: (context,
                    //       AsyncSnapshot<
                    //               List<
                    //                   Map<
                    //                       String,
                    //                       List<
                    //                           PayloadResponseListConversation>>>>
                    //           snapshot) {
                    //     print('${snapshot.data}');
                    //
                    //     if (snapshot.hasData) {
                    //       var findIndex = snapshot.data!.indexWhere((element) =>
                    //           element.keys.contains(
                    //               "${snapshotAccount.userOrStore}-${snapshotAccount.id}"));
                    //       var listChatAll = snapshot.data!.where((element) =>
                    //           element.keys.contains(
                    //               "${snapshotAccount.userOrStore}-${snapshotAccount.id}"));
                    //       print("listChatAll ${findIndex}");
                    //       var listChatGet = [];
                    //       if (findIndex != -1) {
                    //         listChatGet =
                    //             snapshot.data![findIndex].values.elementAt(0);
                    //         // listChat = listChatAll.elementAt(0);
                    //       }
                    //       List<PayloadResponseListConversation> listChat = [];
                    //       listChat.addAll(listChatGet
                    //           as List<PayloadResponseListConversation>);
                    //
                    //       if (searchField.isNotEmpty) {
                    //         listChat.retainWhere((element) =>
                    //             element.chatWith?.fullName
                    //                 .toString()
                    //                 .toLowerCase()
                    //                 .contains(searchField.toLowerCase()) ??
                    //             false);
                    //
                    //         // listChat.retainWhere((element) => element
                    //         //     .chatWith.fullName
                    //         //     .toString()
                    //         //     .toLowerCase()
                    //         //     .contains(searchField.toLowerCase()));
                    //         // print("===========searchList ${listChat}");
                    //       }
                    //       return ListView.builder(
                    //         itemCount: listChat.length,
                    //         itemBuilder: (context, index) {
                    //           return NeumorphicButton(
                    //               onPressed: () {
                    //                 showMaterialModalBottomSheet(
                    //                     duration: Duration(seconds: 1),
                    //                     animationCurve: Curves.easeInOut,
                    //                     enableDrag: true,
                    //                     backgroundColor: Colors.white,
                    //                     context: context,
                    //                     builder: (context) {
                    //                       return SafeArea(
                    //                           child: ChatDetailScreen(
                    //                         onClosed: () {
                    //                           getFromApi();
                    //                         },
                    //                         accountSelected: snapshotAccount,
                    //                         withUser: listChat[index].chatWith!,
                    //                       ));
                    //                     });
                    //               },
                    //               margin: EdgeInsets.symmetric(
                    //                   vertical: .5.h, horizontal: 1.h),
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 1.5.w, vertical: 1.3.h),
                    //               style: NeumorphicStyle(
                    //                   color: Colors.white,
                    //                   shape: NeumorphicShape.flat,
                    //                   depth: .1.h,
                    //                   intensity: 1),
                    //               child: Row(
                    //                 children: [
                    //                   Neumorphic(
                    //                       padding: EdgeInsets.all(0),
                    //                       style: NeumorphicStyle(
                    //                           color: Colors.grey,
                    //                           shape: NeumorphicShape.flat,
                    //                           boxShape:
                    //                               NeumorphicBoxShape.circle(),
                    //                           depth: .2.h,
                    //                           intensity: 1),
                    //                       child: Container(
                    //                         width: 1.2.w.h,
                    //                         height: 1.2.w.h,
                    //                         // margin: EdgeInsets.symmetric(vertical: 1.h),
                    //                         child: AspectRatio(
                    //                           aspectRatio: 1.w / 1.w,
                    //                           child: listChat[index].chatWith !=
                    //                                   null
                    //                               ? listChat[index].chatWith !=
                    //                                       null
                    //                                   ? Image.network(
                    //                                       "${listChat[index].chatWith!.image}?dummy=${math.Random().nextInt(999)}",
                    //                                       errorBuilder:
                    //                                           (context, url,
                    //                                               error) {
                    //                                         return new Icon(
                    //                                           Icons.person,
                    //                                           color:
                    //                                               Colors.white,
                    //                                         );
                    //                                       },
                    //                                       fit: BoxFit.cover,
                    //                                     )
                    //                                   : Align(
                    //                                       alignment:
                    //                                           Alignment.center,
                    //                                       child: NeumorphicIcon(
                    //                                         Icons
                    //                                             .camera_alt_outlined,
                    //                                         size: 1.w.h,
                    //                                         style:
                    //                                             NeumorphicStyle(
                    //                                           depth: .05.w.h,
                    //                                           surfaceIntensity:
                    //                                               1,
                    //                                           intensity: 1,
                    //                                           color: Colors
                    //                                               .black54,
                    //                                         ),
                    //                                       ),
                    //                                     )
                    //                               : Align(
                    //                                   alignment:
                    //                                       Alignment.center,
                    //                                   child: NeumorphicIcon(
                    //                                     Icons
                    //                                         .camera_alt_outlined,
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
                    //                     width: 2.w,
                    //                   ),
                    //                   Expanded(
                    //                     child: Column(
                    //                       children: [
                    //                         Text(
                    //                           listChat[index]
                    //                               .chatWith!
                    //                               .fullName!,
                    //                           style: TextStyle(
                    //                               fontFamily: 'ghotic',
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         Text(
                    //                           '${listChat[index].chatFrom!.id == snapshotAccount.id ? 'Anda: ${listChat[index].lastChat!}' : '${listChat[index].chatFrom!.fullName}: ${listChat[index].lastChat!}'}',
                    //                           style: TextStyle(
                    //                             fontFamily: 'ghotic',
                    //                             fontSize: 14,
                    //                           ),
                    //                         )
                    //                       ],
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                     ),
                    //                   )
                    //                 ],
                    //               ));
                    //         },
                    //       );
                    //     }
                    //     return Center(
                    //         child: CircularProgressIndicator(
                    //       color: Colors.blue,
                    //     ));
                    //   },
                    // )
                    ),
              )
            ],
          ));
    }
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
    // return StreamBuilder(
    //     stream: selectedAccount.stream,
    //     builder: (context, AsyncSnapshot<PopUpList> snapshotAccount) {
    //       if (snapshotAccount.hasData) {
    //
    //
    //
    //       }
    // Container(
    //   width: 100.w,
    //   height: 100.h,
    //   color: Colors.black12,
    //   child: Column(
    //     children: [
    //       Neumorphic(
    //           padding: EdgeInsets.symmetric(
    //               vertical: 1.h, horizontal: 2.w),
    //           style: NeumorphicStyle(
    //               shape: NeumorphicShape.flat,
    //               boxShape: NeumorphicBoxShape.roundRect(
    //                   BorderRadius.only(
    //                       bottomLeft: Radius.circular(3.h),
    //                       bottomRight: Radius.circular(3.h))),
    //               color: Colors.transparent,
    //               depth: 0,
    //               intensity: 1,
    //               surfaceIntensity: 1),
    //           child: Container(
    //             height: 10.h,
    //             child: Row(
    //               children: [
    //                 Container(
    //                   width: 8.w,
    //                   child: Neumorphic(
    //                     style: NeumorphicStyle(
    //                         color: Colors.grey,
    //                         shape: NeumorphicShape.flat,
    //                         boxShape:
    //                         NeumorphicBoxShape.circle(),
    //                         depth: .2.h,
    //                         intensity: 1),
    //                     child: Image.network(
    //                       "${snapshotAccount.data!.image}?dummy=${math.Random().nextInt(999)}",
    //                       errorBuilder: (context, url, error) {
    //                         return new Icon(
    //                           Icons.person,
    //                           color: Colors.white,
    //                           size: 8.w,
    //                         );
    //                       },
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 2.w,
    //                 ),
    //                 Expanded(
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "Hi, ${snapshotAccount.data!.nameDisplay}",
    //                       ),
    //                       createPopup()
    //                     ],
    //                   ),
    //                 ),
    //                 NeumorphicButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       searchOn = true;
    //                     });
    //                   },
    //                   padding: EdgeInsets.all(0.w.h),
    //                   // margin: EdgeInsets.all(0),
    //                   style: NeumorphicStyle(
    //                     boxShape: NeumorphicBoxShape.circle(),
    //                     color: Colors.white24,
    //                     depth: 0,
    //                   ),
    //                   child: NeumorphicIcon(
    //                     Icons.search_rounded,
    //                     style: NeumorphicStyle(
    //                       depth: .1.h,
    //                       color: Colors.black45,
    //                     ),
    //                     size: 1.w.h,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           )),
    //       Expanded(
    //         child: Container(
    //           margin: EdgeInsets.symmetric(horizontal: 2.w),
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               searchOn
    //                   ? Column(
    //                 crossAxisAlignment:
    //                 CrossAxisAlignment.center,
    //                 mainAxisAlignment:
    //                 MainAxisAlignment.center,
    //                 children: [
    //                   NeumorphicButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         searchOn = false;
    //                       });
    //                     },
    //                     padding: EdgeInsets.all(0.w.h),
    //                     // margin: EdgeInsets.all(0),
    //                     style: NeumorphicStyle(
    //                       boxShape:
    //                       NeumorphicBoxShape.circle(),
    //                       color: Colors.transparent,
    //                       depth: .1.w.h,
    //                     ),
    //                     child: NeumorphicIcon(
    //                       Icons.cancel_rounded,
    //                       style: NeumorphicStyle(
    //                         depth: .1.h,
    //                         color: Colors.black54,
    //                       ),
    //                       size: 6.w,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 1.h,
    //                   ),
    //                   Text("Cari History chat"),
    //                   SizedBox(
    //                     height: .4.h,
    //                   ),
    //                   WidgetTextField(
    //                     obSecure: false,
    //                     icon: Icons.search,
    //                     messageError:
    //                     "Silahkan Masukan Deskripsi Produk",
    //                     isError: false,
    //                     onChanged: (String value) {
    //                       setState(() {
    //                         searchField = value;
    //                       });
    //                       // _runFilter(value);
    //                       // setState(() {
    //                       //   searchField = value;
    //                       // });
    //                     },
    //                     onSaved: (String? value) {
    //                       // setState(() {
    //                       //   searchField = value!;
    //                       // });
    //                     },
    //                     textTitleColor: Colors.black,
    //                     keyboardtype:
    //                     TextInputType.multiline,
    //                   )
    //                 ],
    //               )
    //                   : Container(),
    //               SizedBox(
    //                 height: 1.h,
    //               ),
    //               Expanded(
    //                   child: StreamBuilder(
    //                     stream: snapshotListChatInternal.stream,
    //                     builder: (context,
    //                         AsyncSnapshot<
    //                             List<
    //                                 Map<
    //                                     String,
    //                                     List<
    //                                         PayloadResponseListConversation>>>>
    //                         snapshot) {
    //                       print('${snapshot.data}');
    //
    //                       if (snapshot.hasData) {
    //                         var findIndex = snapshot.data!.indexWhere(
    //                                 (element) => element.keys.contains(
    //                                 "${snapshotAccount.data!.userOrStore}-${snapshotAccount.data!.id}"));
    //                         var listChatAll = snapshot.data!.where(
    //                                 (element) => element.keys.contains(
    //                                 "${snapshotAccount.data!.userOrStore}-${snapshotAccount.data!.id}"));
    //                         print("listChatAll ${findIndex}");
    //                         var listChatGet = [];
    //                         if (findIndex != -1) {
    //                           listChatGet = snapshot
    //                               .data![findIndex].values
    //                               .elementAt(0);
    //                           // listChat = listChatAll.elementAt(0);
    //                         }
    //                         List<PayloadResponseListConversation>
    //                         listChat = [];
    //                         listChat.addAll(listChatGet as List<
    //                             PayloadResponseListConversation>);
    //
    //                         if (searchOn) {
    //                           listChat.retainWhere((element) =>
    //                           element.chatWith?.fullName
    //                               .toString()
    //                               .toLowerCase()
    //                               .contains(searchField
    //                               .toLowerCase()) ??
    //                               false);
    //
    //                           // listChat.retainWhere((element) => element
    //                           //     .chatWith.fullName
    //                           //     .toString()
    //                           //     .toLowerCase()
    //                           //     .contains(searchField.toLowerCase()));
    //                           // print("===========searchList ${listChat}");
    //                         }
    //                         return ListView.builder(
    //                           itemCount: listChat.length,
    //                           itemBuilder: (context, index) {
    //                             return NeumorphicButton(
    //                                 onPressed: () {
    //                                   showMaterialModalBottomSheet(
    //                                       duration: Duration(
    //                                           milliseconds: 1400),
    //                                       animationCurve:
    //                                       Curves.easeInOut,
    //                                       enableDrag: true,
    //                                       backgroundColor:
    //                                       Colors.white,
    //                                       context: context,
    //                                       builder: (context) {
    //                                         return ChatDetailScreen(
    //                                           onClosed: () {
    //                                             getFromApi();
    //                                           },
    //                                           accountSelected:
    //                                           snapshotAccount
    //                                               .data!,
    //                                           withUser:
    //                                           listChat[index]
    //                                               .chatWith!,
    //                                         );
    //                                       });
    //                                 },
    //                                 margin: EdgeInsets.symmetric(
    //                                     vertical: .5.h),
    //                                 padding: EdgeInsets.symmetric(
    //                                     horizontal: 1.5.w,
    //                                     vertical: 1.h),
    //                                 style: NeumorphicStyle(
    //                                     color: Colors.transparent,
    //                                     shape: NeumorphicShape.flat,
    //                                     depth: .1.h,
    //                                     intensity: 1),
    //                                 child: Row(
    //                                   children: [
    //                                     Neumorphic(
    //                                         padding:
    //                                         EdgeInsets.all(0),
    //                                         style: NeumorphicStyle(
    //                                             color: Colors.grey,
    //                                             shape:
    //                                             NeumorphicShape
    //                                                 .flat,
    //                                             boxShape:
    //                                             NeumorphicBoxShape
    //                                                 .circle(),
    //                                             depth: .2.h,
    //                                             intensity: 1),
    //                                         child: Container(
    //                                           width: 1.2.w.h,
    //                                           height: 1.2.w.h,
    //                                           // margin: EdgeInsets.symmetric(vertical: 1.h),
    //                                           child: AspectRatio(
    //                                             aspectRatio:
    //                                             1.w / 1.w,
    //                                             child: listChat[index]
    //                                                 .chatWith !=
    //                                                 null
    //                                                 ? listChat[index]
    //                                                 .chatWith !=
    //                                                 null
    //                                                 ? Image
    //                                                 .network(
    //                                               "${listChat[index].chatWith!.image}?dummy=${math.Random().nextInt(999)}",
    //                                               errorBuilder: (context,
    //                                                   url,
    //                                                   error) {
    //                                                 return new Icon(
    //                                                   Icons.person,
    //                                                   color:
    //                                                   Colors.white,
    //                                                 );
    //                                               },
    //                                               fit: BoxFit
    //                                                   .cover,
    //                                             )
    //                                                 : Align(
    //                                               alignment:
    //                                               Alignment.center,
    //                                               child:
    //                                               NeumorphicIcon(
    //                                                 Icons
    //                                                     .camera_alt_outlined,
    //                                                 size: 1
    //                                                     .w
    //                                                     .h,
    //                                                 style:
    //                                                 NeumorphicStyle(
    //                                                   depth:
    //                                                   .05.w.h,
    //                                                   surfaceIntensity:
    //                                                   1,
    //                                                   intensity:
    //                                                   1,
    //                                                   color:
    //                                                   Colors.black54,
    //                                                 ),
    //                                               ),
    //                                             )
    //                                                 : Align(
    //                                               alignment:
    //                                               Alignment
    //                                                   .center,
    //                                               child:
    //                                               NeumorphicIcon(
    //                                                 Icons
    //                                                     .camera_alt_outlined,
    //                                                 size:
    //                                                 1.w.h,
    //                                                 style:
    //                                                 NeumorphicStyle(
    //                                                   depth: .05
    //                                                       .w
    //                                                       .h,
    //                                                   surfaceIntensity:
    //                                                   1,
    //                                                   intensity:
    //                                                   1,
    //                                                   color: Colors
    //                                                       .black54,
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         )),
    //                                     SizedBox(
    //                                       width: 2.w,
    //                                     ),
    //                                     Expanded(
    //                                       child: Column(
    //                                         children: [
    //                                           Text(
    //                                             listChat[index]
    //                                                 .chatWith!
    //                                                 .fullName!,
    //                                             style: TextStyle(
    //                                                 fontFamily:
    //                                                 'ghotic',
    //                                                 fontSize: 14,
    //                                                 fontWeight:
    //                                                 FontWeight
    //                                                     .bold),
    //                                           ),
    //                                           Text(
    //                                             '${listChat[index].chatFrom!.id == snapshotAccount.data!.id ? 'Anda: ${listChat[index].lastChat!}' : '${listChat[index].chatFrom!.fullName}: ${listChat[index].lastChat!}'}',
    //                                             style: TextStyle(
    //                                               fontFamily:
    //                                               'ghotic',
    //                                               fontSize: 14,
    //                                             ),
    //                                           )
    //                                         ],
    //                                         crossAxisAlignment:
    //                                         CrossAxisAlignment
    //                                             .start,
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ));
    //                           },
    //                         );
    //                       }
    //                       return CircularProgressIndicator(
    //                         color: Colors.blue,
    //                       );
    //                     },
    //                   )),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // )

    // });
  }

  //
  PopupMenuButton<String> createPopup() {
    return PopupMenuButton<String>(
        padding: EdgeInsets.all(0),
        icon: NeumorphicIcon(
          Icons.arrow_drop_down_circle_sharp,
          style: NeumorphicStyle(
            depth: .2.h,
            color: Colors.white,
          ),
        ),
        onSelected: (value) async {
          var popUpListSelected =
              popUpList.firstWhere((e) => '${e.userOrStore}-${e.id}' == value);
          setState(() {
            snapshotAccount = popUpListSelected;
          });
          await getListChatFromApi();
          // selectedAccount.sink.add(popUpListSelected);
          // popUpList
          //     .firstWhere((e) => '${e.userOrStore}-${e.id}' == value)
          //     .onTap(value);
        },
        itemBuilder: (context) {
          return popUpList
              .map((item) => PopupMenuItem<String>(
                    value: '${item.userOrStore}-${item.id}',
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 8.w,
                          height: 8.w,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                color: Colors.grey,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: .2.h,
                                intensity: 1),
                            child: CachedNetworkImage(
                              imageUrl: "${item.image}?dummy=${dummyVersion}",
                              errorWidget: (context, url, error) {
                                return new Icon(
                                  Icons.person,
                                  color: Colors.white,
                                );
                              },
                              progressIndicatorBuilder:
                                  (loadContext, loadWidget, chunkEvent) {
                                return CircularProgressIndicator(
                                  color: Colors.blue,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "${item.nameDisplay}",
                          style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 10.sp,
                          ),
                        )
                      ],
                    ),
                  ))
              .toList();
        });
  }

  Future<void> getListChatFromApi() async {
    var responseHttp = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/chat/${snapshotAccount.userOrStore == "user" ? "" : "as-store/${snapshotAccount.id}"}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    List<dynamic> data = jsonDecode(responseHttp.body)['data'];
    if (data != null) {
      List<PayloadResponseListConversation> listRecentChat = [];
      data.forEach((element) {
        PayloadResponseListConversation recentChatObject =
            PayloadResponseListConversation.fromJson(element);
        listRecentChat.add(recentChatObject);
      });
      if (mounted) {
        setState(() {
          listRecentChats = listRecentChat;
          listChat = listRecentChat;
        });
      }

      // listRecentChat=data as >;
    }
    // var token = (await SecureStorage().getToken()) ?? "";
    // PayloadResponseApi<PayloadResponseMyProfileDashboard?> getDataProfile =
    //     await ProfileRepository().myProfileDashboard(token);
    // PayloadResponseMyProfileDashboard data;
    // if (getDataProfile != null) {
    //   PayloadResponseMyProfileDashboard dataProfile = getDataProfile.data!;
    //
    //   if (dataProfile != null) {
    //     data = dataProfile;
    //     List<Map<String, dynamic>> idAccount = [];
    //     idUser = data.idUser;
    //     idAccount.add({"id": idUser, "userOrStore": 'user'});
    //     if (data.myOutlets != null) {
    //       data.myOutlets!.forEach((element) {
    //         idAccount.add({"id": element.storeId, "userOrStore": 'store'});
    //       });
    //     }
    //     List<Map<String, List<PayloadResponseListConversation>>>
    //         listToSnapShotChat = [];
    //     List<String> s = [];
    //     await Future.forEach(idAccount, (Map<String, dynamic> element) async {
    //       String subscribeTopics = '${element['userOrStore']}-${element['id']}';
    //       if (element['userOrStore'] == 'user') {
    //         PayloadResponseApi<List<PayloadResponseListConversation>>
    //             getListConversation =
    //             await ChatRepository().getListConversation(token);
    //         var datalist = getListConversation.data;
    //         s.add("waw");
    //         if (datalist != null) {
    //           listToSnapShotChat.add({'$subscribeTopics': datalist});
    //         }
    //       }
    //       if (element['userOrStore'] == 'store') {
    //         PayloadResponseApi<List<PayloadResponseListConversation>>
    //             getListConversation = await ChatRepository()
    //                 .getListConversationAsStore(token, element['id']);
    //         var datalist = getListConversation.data;
    //         s.add("waw");
    //         if (datalist != null) {
    //           listToSnapShotChat.add({'$subscribeTopics': datalist});
    //         }
    //       }
    //     });
    //     print('listchat ${listToSnapShotChat.length}');
    //     // snapshotListChat.sink.add(listToSnapShotChat);
    //     // print(
    //     //     'listchat ${listToSnapShotChat.where((element) => element.keys.toString().toLowerCase().contains("user-91")).map((e) => e.values).toList()}');
    //     // streamNotifChat.sink.add("have new message");
    //
    //   }
    // }
  }

  Future<void> getAccount() async {
    PayloadResponseApi<PayloadResponseMyProfileDashboard?> getDataProfile =
        await ProfileRepository().myProfileDashboard("");
    List<PopUpList> popupListLocal = [];
    if (getDataProfile.data != null) {
      PayloadResponseMyProfileDashboard data = getDataProfile.data!;
      var selectedAccountDefault = PopUpList(
        image: data.image!,
        nameDisplay: data.nameUser!,
        id: data.idUser!,
        userOrStore: 'user',
      );
      popupListLocal.add(selectedAccountDefault);
      if (data.myOutlets != null) {
        data.myOutlets!.forEach(
          (element) {
            popupListLocal.add(
              PopUpList(
                image: element.image ?? '',
                nameDisplay: element.nameOutlet ?? 'no-name',
                id: element.storeId ?? -1,
                userOrStore: 'store',
              ),
            );
          },
        );
      }
    }
    setState(() {
      popUpList = popupListLocal;
      isInitializeDone = true;
      snapshotAccount = popupListLocal
          .singleWhere((element) => element.userOrStore.contains('user'));
    });
    await getListChatFromApi();
    // var selectedAccountDefault = PopUpList(
    //   image: data.image!,
    //   nameDisplay: data.nameUser!,
    //   id: data.idUser!,
    //   userOrStore: 'user',
    // );
  }
}

class PopUpList {
  String image;
  String nameDisplay;
  int id;
  String userOrStore;

  PopUpList({
    required this.image,
    required this.nameDisplay,
    required this.id,
    required this.userOrStore,
  });
}
