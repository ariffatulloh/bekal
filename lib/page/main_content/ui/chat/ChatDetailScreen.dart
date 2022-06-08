import 'dart:async';
import 'dart:math' as math;

import 'package:bekal/main.dart';
import 'package:bekal/page/main_content/ui/chat/ChatScreen.dart';
import 'package:bekal/page/main_content/ui/profile/widget/WidgetTextField.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/request/PayloadRequestSendMessage.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/repository/chat_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class ChatDetailScreen extends StatefulWidget {
  final Function() onClosed;
  final ChatWith withUser;
  final PopUpList accountSelected;
  ChatDetailScreen(
      {Key? key,
      required this.onClosed,
      required this.withUser,
      required this.accountSelected})
      : super(key: key);
  @override
  _ChatDetailScreen createState() => _ChatDetailScreen();
}

class _ChatDetailScreen extends State<ChatDetailScreen> {
  var searchOn = StreamController<bool>.broadcast();
  TextEditingController chatFieldController = TextEditingController();
  final ScrollController _controllerScrollView = ScrollController();

  String chatField = "";

  List<PayloadResponseListConversation> listChat = [];
  @override
  void initState() {
    super.initState();
    snapshotListChat.stream.listen((event) {
      print("listchat ${event}");
      getdataFromSubscribe();
    });
    getdataFromSubscribe();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(children: [
        Neumorphic(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.rect(),
            color: Colors.white54,
            depth: .2.h,
          ),
          child: Row(
            children: [
              NeumorphicButton(
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 100), () {
                    // if (stompClient != null) {
                    //   stompClient!.deactivate();
                    // }
                    widget.onClosed();
                    Navigator.of(context).pop();
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
                  Icons.arrow_back_ios,
                  style: NeumorphicStyle(
                    depth: .1.h,
                    color: Colors.black45,
                  ),
                  size: 1.w.h,
                ),
              ),
              Container(
                width: 10.w,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      color: Colors.grey,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: .2.h,
                      intensity: 1),
                  child: Image.network(
                    "${widget.withUser.image}?dummy=${math.Random().nextInt(999)}",
                    errorBuilder: (context, url, error) {
                      return new Icon(
                        Icons.person,
                        color: Colors.white,
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
                    Text("${widget.withUser.fullName}"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            width: 100.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.w),
                    topRight: Radius.circular(5.w))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: _controllerScrollView,
                        reverse: true,
                        itemCount: listChat == null ? 0 : listChat.length,
                        itemBuilder: (context, index) {
                          var idChatfrom =
                              '${listChat[index].chatFrom!.userOrStore}-${listChat[index].chatFrom!.id}';
                          var idChatWithUser =
                              '${widget.withUser.userOrStore}-${widget.withUser.id}';
                          var idSelectedAccount =
                              '${widget.accountSelected.userOrStore}-${widget.accountSelected.id}';
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 1.w),
                            child: Column(
                              crossAxisAlignment:
                                  idChatfrom == idSelectedAccount
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dari : ${idChatfrom == idSelectedAccount ? 'anda' : listChat[index].chatFrom!.fullName!}',
                                  style: TextStyle(
                                    decorationThickness: 1.h,
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                Neumorphic(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 2.w),
                                  style: NeumorphicStyle(
                                    // shape: NeumorphicShape.convex,
                                    color: idChatfrom == idSelectedAccount
                                        ? Colors.green
                                        : Colors.grey,
                                    // boxShape: NeumorphicBoxShape.,
                                    depth: .0.w.h,
                                    // surfaceIntensity: .5,
                                    // intensity: 1
                                  ),
                                  child: Text(
                                    listChat[index].lastChat!,
                                    style: TextStyle(
                                      decorationThickness: 1.h,
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    // StreamBuilder(
                    //     stream: snapshotListChatWithUser.stream,
                    //     builder: (context,
                    //         AsyncSnapshot<List<PayloadResponseListConversation>>
                    //             snapshot) {
                    //       if (snapshot.hasData) {
                    //         var listChat = snapshot.data!;
                    //         return ListView.builder(
                    //             controller: _controllerScrollView,
                    //             reverse: true,
                    //             itemCount:
                    //                 listChat == null ? 0 : listChat.length,
                    //             itemBuilder: (context, index) {
                    //               var idChatfrom =
                    //                   '${listChat[index].chatFrom!.userOrStore}-${listChat[index].chatFrom!.id}';
                    //               var idChatWithUser =
                    //                   '${widget.withUser.userOrStore}-${widget.withUser.id}';
                    //               var idSelectedAccount =
                    //                   '${widget.accountSelected.userOrStore}-${widget.accountSelected.id}';
                    //               return Container(
                    //                 margin: EdgeInsets.symmetric(
                    //                     vertical: 1.h, horizontal: 1.w),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       idChatfrom == idSelectedAccount
                    //                           ? CrossAxisAlignment.end
                    //                           : CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       'Dari : ${idChatfrom == idSelectedAccount ? 'anda' : listChat[index].chatFrom!.fullName!}',
                    //                       style: TextStyle(
                    //                         decorationThickness: 1.h,
                    //                         color: Colors.grey,
                    //                         fontSize: 12.sp,
                    //                       ),
                    //                     ),
                    //                     SizedBox(
                    //                       height: .5.h,
                    //                     ),
                    //                     Neumorphic(
                    //                       padding: EdgeInsets.symmetric(
                    //                           vertical: 1.h, horizontal: 2.w),
                    //                       style: NeumorphicStyle(
                    //                         // shape: NeumorphicShape.convex,
                    //                         color:
                    //                             idChatfrom == idSelectedAccount
                    //                                 ? Colors.green
                    //                                 : Colors.grey,
                    //                         // boxShape: NeumorphicBoxShape.,
                    //                         depth: .0.w.h,
                    //                         // surfaceIntensity: .5,
                    //                         // intensity: 1
                    //                       ),
                    //                       child: Text(
                    //                         listChat[index].lastChat!,
                    //                         style: TextStyle(
                    //                           decorationThickness: 1.h,
                    //                           color: Colors.white,
                    //                           fontSize: 12.sp,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               );
                    //             });
                    //       }
                    //       return Container(
                    //         alignment: Alignment.center,
                    //         child: CircularProgressIndicator(
                    //           color: Colors.blue,
                    //         ),
                    //       );
                    //     }),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: WidgetTextField(
                          controller: chatFieldController,
                          title: "",
                          obSecure: false,
                          icon: Icons.chat,
                          messageError: "Silahkan Masukan Deskripsi Produk",
                          isError: false,
                          // isError: emailField.isEmpty,
                          onChanged: (String value) {
                            setState(() {
                              chatField = value;
                            });
                          },
                          onSaved: (String? value) {},
                          textTitleColor: Colors.black,
                          keyboardtype: TextInputType.multiline,
                        ),
                      ),
                      chatField.isNotEmpty
                          ? NeumorphicButton(
                              onPressed: () async {
                                var message = chatFieldController.text;
                                PayloadResponseListConversation
                                    fakseSendMessage =
                                    PayloadResponseListConversation(
                                        chatWith: widget.withUser,
                                        chatFrom: ChatWith(
                                            fullName: widget
                                                .accountSelected.nameDisplay,
                                            image: widget.accountSelected.image,
                                            id: widget.accountSelected.id,
                                            userOrStore: widget
                                                .accountSelected.userOrStore),
                                        chatTo: widget.withUser,
                                        lastChat: message,
                                        timeChat: null);
                                setState(() {
                                  chatFieldController.clear();
                                  listChat.insert(0, fakseSendMessage);
                                });
                                var token =
                                    (await SecureStorage().getToken()) ?? "";
                                widget.accountSelected.userOrStore == 'user'
                                    ? ChatRepository()
                                        .sendMessage(
                                            token,
                                            widget.withUser.userOrStore ==
                                                    'user'
                                                ? PayloadRequestSendMessage(
                                                    message: message,
                                                    toUser: widget.withUser.id,
                                                    toStore: -1)
                                                : PayloadRequestSendMessage(
                                                    message: message,
                                                    toUser: -1,
                                                    toStore:
                                                        widget.withUser.id))
                                        .then((value) async {
                                        if (value.errorMessage.isEmpty) {
                                          // await getdataFromSubscribe();
                                          // setState(() {
                                          //   // snapshotListChatWithUser.insert(0, value.data!);
                                          //   // scrollToDown();
                                          //
                                          // });
                                        }
                                      })
                                    : ChatRepository()
                                        .sendMessageAsStore(
                                            token,
                                            widget.withUser.userOrStore ==
                                                    'user'
                                                ? PayloadRequestSendMessage(
                                                    message: message,
                                                    toUser: widget.withUser.id,
                                                    toStore: -1)
                                                : PayloadRequestSendMessage(
                                                    message: message,
                                                    toUser: -1,
                                                    toStore:
                                                        widget.withUser.id),
                                            widget.accountSelected.id)
                                        .then((value) async {
                                        if (value.errorMessage.isEmpty) {
                                          // await getdataFromSubscribe();

                                          // setState(() {
                                          //   // snapshotListChatWithUser.insert(0, value.data!);
                                          //   // scrollToDown();
                                          //
                                          // });
                                        }
                                      });
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.w),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                color: Colors.green,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 2,
                                // surfaceIntensity: .5,
                                // intensity: 1
                              ),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  var snapshotListChatWithUser =
      StreamController<List<PayloadResponseListConversation>>.broadcast();
  Future<void> getdataFromSubscribe() async {
    var token = (await SecureStorage().getToken()) ?? "";
    if (widget.accountSelected.userOrStore == "user") {
      PayloadResponseApi<List<PayloadResponseListConversation>>
          getListConversation = await ChatRepository()
              .getListDetailConversation(token, widget.withUser.id!);
      var datalist = getListConversation.data;
      if (datalist != null) {
        setState(() {
          listChat = datalist;
        });
        // snapshotListChatWithUser.sink.add(datalist);
      }
      // StreamSubscription<String?> streamSubscription =
      //     streamNotifChat.stream.listen((value) async {
      //   PayloadResponseApi<List<PayloadResponseListConversation>>
      //       getListConversation = await ChatRepository()
      //           .getListDetailConversation(token, widget.withUser.id!);
      //   var datalist = getListConversation.data;
      //   if (datalist != null) {
      //     // snapshotListChatWithUser.sink.add(datalist);
      //   }
      // });
    }
    if (widget.accountSelected.userOrStore == "store") {
      PayloadResponseApi<List<PayloadResponseListConversation>>
          getListConversation = await ChatRepository()
              .getListDetailConversationAsStore(
                  token, widget.withUser.id!, widget.accountSelected.id);
      var datalist = getListConversation.data;
      if (datalist != null) {
        setState(() {
          listChat = datalist;
        });
        // snapshotListChatWithUser.sink.add(datalist);
      }
      StreamSubscription<String?> streamSubscription =
          streamNotifChat.stream.listen((value) async {
        PayloadResponseApi<List<PayloadResponseListConversation>>
            getListConversation = await ChatRepository()
                .getListDetailConversationAsStore(
                    token, widget.withUser.id!, widget.accountSelected.id);
        var datalist = getListConversation.data;
        if (datalist != null) {
          snapshotListChatWithUser.sink.add(datalist);
        }
      });
    }
  }
}
