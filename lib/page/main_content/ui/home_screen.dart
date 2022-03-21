import 'dart:convert';

import 'package:bekal/firebase/FireBasePlugin.dart';
import 'package:bekal/firebase/LocalNotification.dart';
import 'package:bekal/main.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/main_content/cubit/home_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/ViewProduct.dart';
import 'package:bekal/page/main_content/ui/cart/cart_screen.dart';
import 'package:bekal/page/main_content/ui/chat/ChatScreen.dart';
import 'package:bekal/page/main_content/ui/my_store/widget_create_product/BodyListProduct.dart';
import 'package:bekal/page/main_content/ui/profile/profile_screen.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  int? selectedIndexMenu = 0;
  HomeScreen({Key? key, this.selectedIndexMenu}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late var _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    // _index = widget.selectedIndexMenu!;
    super.initState();
    setupFirebaseAndStomp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromRGBO(243, 146, 0, .8),
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          // scaleFactor: 1.5,
          // style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white),
          // icons: [
          //   FluidNavBarIcon(
          //     icon: Icons.home,
          //     backgroundColor: Color(0xFFEC4134),
          //   ),
          //   FluidNavBarIcon(icon: Icons.home),
          items: [
            itemBottomNavBar(
              countNotif: 0,
              icon: Icons.home,
            ),
            itemBottomNavBar(
              countNotif: 0,
              icon: Icons.search,
            ),
            itemBottomNavBar(
              countNotif: 0,
              icon: Icons.person,
            ),
            StreamBuilder(
                stream: streamNotifChat.stream,
                builder: (context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.hasData) {
                    return itemBottomNavBar(
                      countNotif: 2,
                      icon: Icons.chat,
                    );
                  }
                  return itemBottomNavBar(
                    countNotif: 0,
                    icon: Icons.chat,
                  );
                }),
            itemBottomNavBar(
              countNotif: 0,
              icon: Icons.shopping_basket,
            ),
          ],
          color: const Color.fromRGBO(255, 255, 255, 1),
          buttonBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOutCirc,
          animationDuration: const Duration(milliseconds: 700),
          index: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
            if (index == 3) {
              streamNotifChat.sink.add(null);
            }
          },
          letIndexChange: (index) => true,
        ),
        body: showBody(_index, context));
  }

  Stack itemBottomNavBar({required int countNotif, required IconData icon}) {
    return Stack(
      children: [
        Positioned(
          child: Icon(
            icon,
            size: 4.h,
            color: Color(0xfff39200),
          ),
          // top: 2,
        ),
        countNotif > 1
            ? icon == Icons.chat
                ? Positioned(
                    child: NeumorphicIcon(
                      Icons.circle_notifications_sharp,
                      style: NeumorphicStyle(color: Colors.red, depth: 1.h),
                      size: 2.h,
                    ),
                  )
                : Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 8,
                      child: Center(
                        child: Text(
                          countNotif > 99 ? "99+" : "$countNotif",
                          style: TextStyle(color: Colors.white, fontSize: 6.sp),
                        ),
                      ),
                    ),
                  )
            : const SizedBox(),
      ],
    );
  }

  showBody(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomeWidget();
      case 2:
        return ProfileScreen();
      case 3:
        return const ChatScreen();
      case 4:
        return const CartScreen();
    }
  }

  HomeWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        width: 100.w,
        height: 100.h,
        color: Colors.black12,
        alignment: Alignment.center,
        child: FutureBuilder(
          future: HomeScreenCubit().getHomeSeeAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              PayloadResponseApi data = snapshot.data as PayloadResponseApi;
              if (data.errorMessage.isEmpty) {
                List<PayloadResponseHomeSeeAllProduct> list = data.data;

                return Container(
                  height: 100.h,
                  // color: Colors.black12,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var dataObject = list.elementAt(index);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${dataObject.titleTab}",
                              style: TextStyle(
                                  fontFamily: 'ghotic',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                            SizedBox(
                              height: 3.w,
                            ),
                            // Expanded(
                            //     child: ),
                            dataObject.titleTab.toLowerCase().contains("semua")
                                ? Container(
                                    // height: 100.h,
                                    child: MasonryGridView.count(
                                        physics: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? NeverScrollableScrollPhysics()
                                            : AlwaysScrollableScrollPhysics(),
                                        scrollDirection: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        shrinkWrap: true,
                                        crossAxisCount: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? 2
                                            : 1,
                                        mainAxisSpacing: 1.h,
                                        crossAxisSpacing: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? 3.w
                                            : 0,
                                        itemCount: dataObject
                                            .viewListStoreProductResponse
                                            .length,
                                        itemBuilder: (context, index) {
                                          var object = dataObject
                                                  .viewListStoreProductResponse[
                                              index];
                                          return ItemProduct(
                                            onClick: () async {
                                              var token = await SecureStorage()
                                                      .getToken() ??
                                                  "";
                                              showMaterialModalBottomSheet(
                                                  duration: Duration(
                                                      milliseconds: 1400),
                                                  animationCurve:
                                                      Curves.easeInOut,
                                                  enableDrag: true,
                                                  isDismissible: false,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewProduct(
                                                        idStore: object
                                                            .store.storeID,
                                                        dataDetailProduct: null,
                                                        idProduct:
                                                            object.storeProdId);
                                                  });
                                              // StreamBuilder(
                                              //     stream: HomeScreenCubit()
                                              //         .getHomeSeeDetailProduct(
                                              //             idProduct: object
                                              //                 .storeProdId,
                                              //             idStore: object
                                              //                 .store.storeID)
                                              //         .asStream(),
                                              //     builder: (context, snapshot) {
                                              //       PayloadResponseStoreProduct?
                                              //           dataDetailProduct;
                                              //       if (snapshot
                                              //               .connectionState ==
                                              //           ConnectionState.done) {
                                              //         PayloadResponseApi
                                              //             dataApiDetailProduct =
                                              //             snapshot.data
                                              //                 as PayloadResponseApi;
                                              //         if (dataApiDetailProduct
                                              //             .errorMessage
                                              //             .isEmpty) {
                                              //           dataDetailProduct =
                                              //               dataApiDetailProduct
                                              //                   .data;
                                              //
                                              //         }
                                              //       }
                                              //       return CircularProgressIndicator(
                                              //         color: Colors.blue,
                                              //       );
                                              //     });
                                            },
                                            counterViews:
                                                int.parse(object.priceProduct),
                                            counterSell:
                                                int.parse(object.stockProduct),
                                            available: double.parse(
                                                        object.stockProduct) >
                                                    0
                                                ? true
                                                : false,
                                            priceProduk: double.parse(
                                                object.priceProduct),
                                            nameProduk: object.nameProduct,
                                            imageProduk: object.uriThumbnail,
                                            logoToko:
                                                object.store.uriStoreImage,
                                          );
                                        }),
                                    // padding: EdgeInsets.symmetric(vertical: 2.h),
                                    // width: 100,
                                  )
                                : Container(
                                    height: 39.h,
                                    child: MasonryGridView.count(
                                        physics: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? NeverScrollableScrollPhysics()
                                            : AlwaysScrollableScrollPhysics(),
                                        scrollDirection: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        shrinkWrap: true,
                                        crossAxisCount: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? 2
                                            : 1,
                                        mainAxisSpacing: 1.h,
                                        crossAxisSpacing: dataObject.titleTab
                                                .toLowerCase()
                                                .contains("semua")
                                            ? 3.w
                                            : 0,
                                        itemCount: dataObject
                                            .viewListStoreProductResponse
                                            .length,
                                        itemBuilder: (context, index) {
                                          var object = dataObject
                                                  .viewListStoreProductResponse[
                                              index];
                                          return ItemProduct(
                                            onClick: () async {
                                              var token = await SecureStorage()
                                                      .getToken() ??
                                                  "";
                                              showMaterialModalBottomSheet(
                                                  duration: Duration(
                                                      milliseconds: 1400),
                                                  animationCurve:
                                                      Curves.easeInOut,
                                                  enableDrag: true,
                                                  isDismissible: false,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewProduct(
                                                        idStore: object
                                                            .store.storeID,
                                                        dataDetailProduct: null,
                                                        idProduct:
                                                            object.storeProdId);
                                                  });
                                            },
                                            counterViews:
                                                int.parse(object.priceProduct),
                                            counterSell:
                                                int.parse(object.stockProduct),
                                            available: double.parse(
                                                        object.stockProduct) >
                                                    0
                                                ? true
                                                : false,
                                            priceProduk: double.parse(
                                                object.priceProduct),
                                            nameProduk: object.nameProduct,
                                            imageProduk: object.uriThumbnail,
                                            logoToko:
                                                object.store.uriStoreImage,
                                          );
                                        }),
                                  )
                          ],
                        );
                      }),
                );
              }
            }
//here you should check snapshot.connectionState
            return Expanded(child: Container());
          },
        ));
  }

  ProfileWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: NeumorphicButton(
        onPressed: () async {
          // context.read<Verif>();
          SecureStorage().deleteStorageToken();
          var token = await SecureStorage().getToken();
          if (token == null) {
            context.read<ControllerPageCubit>().goto("LOGIN");
          } else {}
        },
        child: Text("Logout"),
      ),
    );
  }

  Future<void> setupFirebaseAndStomp() async {
    await getFromApiAndConfigWebsocket();
    await FireBasePlugin()
        .initialIze(backgroundHandler: firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("handling onmessage: ${message.data}");
      await LocalNotificationPlugin().initialIze(
          onSelectedNotification: (String? payload) {
        print("onSelectedNotification $payload");
        actionToPage.sink.add(payload!);
        goto = payload;
      });
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDe2uDuF_iUvCSs30iMcfa96F-onYBF-6Q',
              appId: '1:481453095978:android:315f9e5769b3846a2e1753',
              messagingSenderId: '481453095978',
              projectId: 'bekalku-812da'));
      if (message.data != null) {
        var frameBody = PayloadResponseListConversation.fromJson(
            json.decode(message.data['data']));
        print("framebody ===>>> ${frameBody.lastChat}");
        if (frameBody != null) {
          LocalNotificationPlugin().showNotif(
            id: frameBody.hashCode,
            title: frameBody.chatFrom!.fullName,
            message: frameBody.lastChat,
            // payload: 'chat',
            payload: message.data['actionTo'],
          );
        }
      }
    });
  }
}

class ItemHome extends StatelessWidget {
  ItemHome({
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
  final AssetImage imageProduk;
  final String nameProduk;
  final double priceProduk;
  final AssetImage logoToko;
  final bool available;
  int? counterSell = 0;
  int? counterViews = 0;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        style: NeumorphicStyle(
            color: Colors.white,
            depth: .2.h,
            surfaceIntensity: .3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.roundRect(
                const BorderRadius.all(Radius.circular(10)))),
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: SizedBox(
          width: 40.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.w / 1.w,
                    child: Image(
                      image: imageProduk,
                      fit: BoxFit.fill, // use this
                    ),
                  ),
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
                          Image(
                            image: logoToko,
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
