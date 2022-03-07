import 'dart:async';
import 'dart:math' as math;

import 'package:bekal/main.dart';
import 'package:bekal/page/main_content/ui/chat/ChatDetailScreen.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/chat_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  var searchOn;
  var selectedIdLoginAs;
  List<PayloadResponseListConversation> listConversation = [];
  late List<PopUpList> popUpList;
  var selectedAccount = StreamController<PopUpList>();
  late PayloadResponseApi<PayloadResponseMyProfileDashboard?> profileDashboard;
  var snapshotListChatInternal = StreamController<
      List<Map<String, List<PayloadResponseListConversation>>>>();
  @override
  void initState() {
    // TODO: implement initState
    searchOn = false;
    selectedIdLoginAs = 0;
    snapshotListChat.stream.listen((event) {
      print("listchat ${event}");
      snapshotListChatInternal.sink.add(event);
    });
    getFromApi();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: selectedAccount.stream,
        builder: (context, AsyncSnapshot<PopUpList> snapshotAccount) {
          if (snapshotAccount.hasData) {
            return Container(
              width: 100.w,
              height: 100.h,
              color: Colors.black12,
              child: Column(
                children: [
                  Neumorphic(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.rect(),
                      color: Colors.white54,
                      depth: .2.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8.w,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                color: Colors.grey,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: .2.h,
                                intensity: 1),
                            child: Image.network(
                              "${snapshotAccount.data!.image}?dummy=${math.Random().nextInt(999)}",
                              errorBuilder: (context, url, error) {
                                return new Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 8.w,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text("Hi, ${snapshotAccount.data!.nameDisplay}"),
                              createPopup()
                            ],
                          ),
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            setState(() {
                              searchOn = true;
                            });
                          },
                          padding: EdgeInsets.all(0.w.h),
                          // margin: EdgeInsets.all(0),
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            color: Colors.white24,
                            depth: 0,
                          ),
                          child: NeumorphicIcon(
                            Icons.search_rounded,
                            style: NeumorphicStyle(
                              depth: .1.h,
                              color: Colors.black45,
                            ),
                            size: 1.w.h,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(
                        children: [
                          searchOn
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: WidgetTextField(
                                      obSecure: false,
                                      icon: Icons.search,
                                      messageError:
                                          "Silahkan Masukan Deskripsi Produk",
                                      isError: false,
                                      onChanged: (String value) {
                                        // _runFilter(value);
                                        // setState(() {
                                        //   searchField = value;
                                        // });
                                      },
                                      onSaved: (String? value) {
                                        // setState(() {
                                        //   searchField = value!;
                                        // });
                                      },
                                      textTitleColor: Colors.black,
                                      keyboardtype: TextInputType.multiline,
                                    )),
                                    NeumorphicButton(
                                      onPressed: () {
                                        setState(() {
                                          searchOn = false;
                                        });
                                      },
                                      padding: EdgeInsets.all(0.w.h),
                                      // margin: EdgeInsets.all(0),
                                      style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: Colors.transparent,
                                        depth: .1.w.h,
                                      ),
                                      child: NeumorphicIcon(
                                        Icons.cancel_rounded,
                                        style: NeumorphicStyle(
                                          depth: .1.h,
                                          color: Colors.black54,
                                        ),
                                        size: 1.w.h,
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 1.h,
                          ),
                          Expanded(
                              child: StreamBuilder(
                            stream: snapshotListChatInternal.stream,
                            builder: (context,
                                AsyncSnapshot<
                                        List<
                                            Map<
                                                String,
                                                List<
                                                    PayloadResponseListConversation>>>>
                                    snapshot) {
                              print('${snapshot.data}');

                              if (snapshot.hasData) {
                                var findIndex = snapshot.data!.indexWhere(
                                    (element) => element.keys.contains(
                                        "${snapshotAccount.data!.userOrStore}-${snapshotAccount.data!.id}"));
                                var listChatAll = snapshot.data!.where(
                                    (element) => element.keys.contains(
                                        "${snapshotAccount.data!.userOrStore}-${snapshotAccount.data!.id}"));
                                print("listChatAll ${findIndex}");
                                var listChat = [];
                                if (findIndex != -1) {
                                  listChat = snapshot.data![findIndex].values
                                      .elementAt(0);
                                  // listChat = listChatAll.elementAt(0);
                                }
                                return ListView.builder(
                                  itemCount: listChat.length,
                                  itemBuilder: (context, index) {
                                    return NeumorphicButton(
                                        onPressed: () {
                                          showMaterialModalBottomSheet(
                                              duration:
                                                  Duration(milliseconds: 1400),
                                              animationCurve: Curves.easeInOut,
                                              enableDrag: true,
                                              backgroundColor: Colors.white,
                                              context: context,
                                              builder: (context) {
                                                return ChatDetailScreen(
                                                  onClosed: () {
                                                    getFromApi();
                                                  },
                                                  accountSelected:
                                                      snapshotAccount.data!,
                                                  withUser:
                                                      listChat[index].chatWith!,
                                                );
                                              });
                                        },
                                        margin: EdgeInsets.symmetric(
                                            vertical: .5.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.5.w, vertical: 1.h),
                                        style: NeumorphicStyle(
                                            color: Colors.transparent,
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
                                                    boxShape: NeumorphicBoxShape
                                                        .circle(),
                                                    depth: .2.h,
                                                    intensity: 1),
                                                child: Container(
                                                  width: 1.2.w.h,
                                                  height: 1.2.w.h,
                                                  // margin: EdgeInsets.symmetric(vertical: 1.h),
                                                  child: AspectRatio(
                                                    aspectRatio: 1.w / 1.w,
                                                    child: listChat[index]
                                                                .chatWith !=
                                                            null
                                                        ? listChat[index]
                                                                    .chatWith !=
                                                                null
                                                            ? Image.network(
                                                                "${listChat[index].chatWith!.image}?dummy=${math.Random().nextInt(999)}",
                                                                errorBuilder:
                                                                    (context,
                                                                        url,
                                                                        error) {
                                                                  return new Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .white,
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    NeumorphicIcon(
                                                                  Icons
                                                                      .camera_alt_outlined,
                                                                  size: 1.w.h,
                                                                  style:
                                                                      NeumorphicStyle(
                                                                    depth:
                                                                        .05.w.h,
                                                                    surfaceIntensity:
                                                                        1,
                                                                    intensity:
                                                                        1,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              )
                                                        : Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                NeumorphicIcon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              size: 1.w.h,
                                                              style:
                                                                  NeumorphicStyle(
                                                                depth: .05.w.h,
                                                                surfaceIntensity:
                                                                    1,
                                                                intensity: 1,
                                                                color: Colors
                                                                    .black54,
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
                                                    listChat[index]
                                                        .chatWith!
                                                        .fullName!,
                                                    style: TextStyle(
                                                        fontFamily: 'ghotic',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '${listChat[index].chatFrom!.id == snapshotAccount.data!.id ? 'Anda: ${listChat[index].lastChat!}' : '${listChat[index].chatFrom!.fullName}: ${listChat[index].lastChat!}'}',
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
                                );
                              }
                              return CircularProgressIndicator(
                                color: Colors.blue,
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
  }

  //
  PopupMenuButton<String> createPopup() {
    return PopupMenuButton<String>(
      padding: EdgeInsets.all(0),
      icon: NeumorphicIcon(
        Icons.arrow_drop_down_circle_sharp,
        style: NeumorphicStyle(
          depth: .2.h,
          color: Colors.black54,
        ),
      ),
      onSelected: (value) {
        var popUpListSelected =
            popUpList.firstWhere((e) => '${e.userOrStore}-${e.id}' == value);
        selectedAccount.sink.add(popUpListSelected);
        // popUpList
        //     .firstWhere((e) => '${e.userOrStore}-${e.id}' == value)
        //     .onTap(value);
      },
      itemBuilder: (context) => popUpList
          .map((item) => PopupMenuItem<String>(
                value: '${item.userOrStore}-${item.id}',
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 8.w,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            color: Colors.grey,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: .2.h,
                            intensity: 1),
                        child: Image.network(
                          "${item.image}?dummy=${math.Random().nextInt(999)}",
                          errorBuilder: (context, url, error) {
                            return new Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 8.w,
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
          .toList(),
    );
  }

  Future<void> getFromApi() async {
    popUpList = [];
    var token = (await SecureStorage().getToken()) ?? "";
    PayloadResponseApi<PayloadResponseMyProfileDashboard?> getDataProfile =
        await ProfileRepository().myProfileDashboard(token);
    PayloadResponseMyProfileDashboard data;
    if (getDataProfile != null) {
      PayloadResponseMyProfileDashboard dataProfile = getDataProfile.data!;

      if (dataProfile != null) {
        data = dataProfile;
        List<Map<String, dynamic>> idAccount = [];
        idUser = data.idUser;
        idAccount.add({"id": idUser, "userOrStore": 'user'});
        if (data.myOutlets != null) {
          data.myOutlets!.forEach((element) {
            idAccount.add({"id": element.storeId, "userOrStore": 'store'});
          });
        }
        List<Map<String, List<PayloadResponseListConversation>>>
            listToSnapShotChat = [];
        List<String> s = [];
        await Future.forEach(idAccount, (Map<String, dynamic> element) async {
          String subscribeTopics = '${element['userOrStore']}-${element['id']}';
          if (element['userOrStore'] == 'user') {
            PayloadResponseApi<List<PayloadResponseListConversation>>
                getListConversation =
                await ChatRepository().getListConversation(token);
            var datalist = getListConversation.data;
            s.add("waw");
            if (datalist != null) {
              listToSnapShotChat.add({'$subscribeTopics': datalist});
            }
          }
          if (element['userOrStore'] == 'store') {
            PayloadResponseApi<List<PayloadResponseListConversation>>
                getListConversation = await ChatRepository()
                    .getListConversationAsStore(token, element['id']);
            var datalist = getListConversation.data;
            s.add("waw");
            if (datalist != null) {
              listToSnapShotChat.add({'$subscribeTopics': datalist});
            }
          }
        });

        // print(
        //     'listchat ${listToSnapShotChat.where((element) => element.keys.toString().toLowerCase().contains("user-91")).map((e) => e.values).toList()}');
        // streamNotifChat.sink.add("have new message");

        var selectedAccountDefault = PopUpList(
          image: data.image!,
          nameDisplay: data.nameUser!,
          id: data.idUser!,
          userOrStore: 'user',
        );
        selectedAccount.sink.add(selectedAccountDefault);
        popUpList.add(selectedAccountDefault);
        if (data.myOutlets != null) {
          data.myOutlets!.forEach(
            (element) {
              popUpList.add(
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
        print('listchat ${listToSnapShotChat.length}');
        snapshotListChat.sink.add(listToSnapShotChat);
      }
    }
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
