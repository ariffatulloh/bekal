import 'dart:convert';
import 'dart:math' as math;

import 'package:bekal/main.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/main_content/cubit/home_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/cart/cart_screen.dart';
import 'package:bekal/page/main_content/ui/chat/ChatScreen.dart';
import 'package:bekal/page/main_content/ui/home/HomeView.dart';
import 'package:bekal/page/main_content/ui/profile/profile_screen.dart';
import 'package:bekal/page/main_content/ui/search/SearchProductAndStore.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
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
    super.initState();
    _getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: SecureStorage().getToken(),
        builder: (context, snapshot) {
          if (snapshot.data != null || (snapshot.data?.isNotEmpty ?? false) == true) {
            return Scaffold(
                extendBody: true,
                bottomNavigationBar: CurvedNavigationBar(
                  height: 50,
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
          } else if (snapshot.data == null || (snapshot.data?.isEmpty ?? false) == true) {
            return Scaffold(
              body: showBody(_index, context),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
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
        return HomeView();
      case 1:
        return SearchProductAndStore();
      case 2:
        return ProfileScreen();
      case 3:
        return const ChatScreen();
      case 4:
        return const CartScreen();
    }
  }

  HomeWidget() {
    var dummyImageVersion = '?dummy=${math.Random().nextInt(999)}';
    _getAllProduct();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      width: 100.w,
      height: 100.h,
      color: Colors.white,
      alignment: Alignment.center,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Container(
              height: 100.h,
              // color: Colors.black12,
              alignment: Alignment.center,
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: listDataHome.length,
                  itemBuilder: (context, index) {
                    var dataObject = listDataHome.elementAt(index);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dataObject.titleTab}",
                          style: TextStyle(fontFamily: 'ghotic', fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black45),
                        ),
                        SizedBox(
                          height: 3.w,
                        ),
                        SingleChildScrollView(
                          scrollDirection: dataObject.titleTab.toLowerCase().contains("semua") ? Axis.vertical : Axis.horizontal,
                          child: Wrap(
                              children: dataObject.viewListStoreProductResponse.map((e) {
                            return Visibility(
                                visible: e.stockProduct != '0' || listMyOutlets.contains(e.store.storeID),
                                child: NeumorphicButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                  style: NeumorphicStyle(color: Colors.blue.withOpacity(.25), depth: 2, intensity: 1, surfaceIntensity: 1),
                                  child: Container(
                                    width: dataObject.titleTab.toLowerCase().contains("semua") ? 45.w : 40.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color(0xfff39200).withOpacity(.1), Color(0xfff39200).withOpacity(.4)],
                                        stops: [.1, .8],
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                                    child: Column(
                                      children: [
                                        Visibility(
                                          visible: !dataObject.titleTab.toLowerCase().contains("semua"),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                            child: NeumorphicText(
                                              e.nameProduct.length > 17 ? e.nameProduct.substring(0, 15) + "..." : e.nameProduct,
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
                                          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: dataObject.titleTab.toLowerCase().contains("semua") ? 0 : 2.w),
                                          child: Neumorphic(
                                            style: NeumorphicStyle(boxShape: dataObject.titleTab.toLowerCase().contains("semua") ? NeumorphicBoxShape.rect() : NeumorphicBoxShape.circle(), depth: 2, intensity: 1, surfaceIntensity: 1),
                                            child: Container(
                                              width: 100.w,
                                              height: dataObject.titleTab.toLowerCase().contains("semua") ? 40.w : 40.w,
                                              child: CachedNetworkImage(
                                                imageUrl: e.uriThumbnail,
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
                                          visible: dataObject.titleTab.toLowerCase().contains("semua"),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                                            child: NeumorphicText(
                                              e.nameProduct.length > 17 ? e.nameProduct.substring(0, 15) + "..." : e.nameProduct,
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
                                            style: NeumorphicStyle(color: e.stockProduct == '0' ? Colors.red : Colors.greenAccent, boxShape: NeumorphicBoxShape.stadium(), depth: -1, intensity: 1, surfaceIntensity: 1),
                                            child: Text(
                                              e.stockProduct == '0' ? "HABIS" : "Tersedia",
                                              style: TextStyle(fontSize: 8.sp, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                                          child: NeumorphicText(
                                            NumberFormat.currency(locale: 'ID').format(double.tryParse(e.priceProduct) ?? 0).length > 17
                                                ? NumberFormat.currency(locale: 'ID').format(double.tryParse(e.priceProduct) ?? 0).substring(0, 15) + "..."
                                                : NumberFormat.currency(locale: 'ID').format(double.tryParse(e.priceProduct) ?? 0),
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
                                                style: NeumorphicStyle(
                                                  depth: 1.5,
                                                  intensity: 1,
                                                  surfaceIntensity: 1,
                                                  boxShape: NeumorphicBoxShape.circle(),
                                                ),
                                                child: Container(
                                                  width: 7.w,
                                                  height: 7.w,
                                                  child: CachedNetworkImage(
                                                    imageUrl: e.store.uriStoreImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                                child: NeumorphicText(
                                                  e.store.storeName.length > 17 ? e.store.storeName.substring(0, 15) + "..." : e.store.storeName,
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
                                ));
                          }).toList()),
                        )
                      ],
                    );
                  }),
            ),
    );
  }

  ProfileWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: NeumorphicButton(
        onPressed: () async {
          // context.read<Verif>();
          await SecureStorage().deleteStorageToken();
          var token = await SecureStorage().getToken();
          if (token == null) {
            context.read<ControllerPageCubit>().goto("LOGIN");
          } else {}
        },
        child: Text("Logout"),
      ),
    );
  }

  bool isLoading = true;
  List<PayloadResponseHomeSeeAllProduct> listDataHome = [];
  List<int> listMyOutlets = [];

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
    List<String> dataSubsFirebase = [];
    PayloadResponseApi<PayloadResponseMyProfileDashboard?> myProfile = await ProfileRepository().myProfileDashboard("token");
    var dataMyProfile = myProfile.data;
    if (dataMyProfile != null) {
      dataSubsFirebase.add('user-${dataMyProfile.idUser}');
      var myOutlets = dataMyProfile.myOutlets;
      if (myOutlets != null) {
        myOutlets.forEach((element) {
          dataSubsFirebase.add('store-${element.storeId}');
          listMyOutletLocal.add(element.storeId ?? 0);
        });
      }
    }
    await SecureStorage().saveSubscribeFirebase(jsonEncode(dataSubsFirebase));
    streamSubsUnSubs.sink.add("subscribe");

    setState(() {
      listDataHome = list;
      isLoading = false;
      listMyOutlets = listMyOutletLocal;
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
            const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
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
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: .5.h,
                    right: .5.w,
                    child: Neumorphic(
                      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                      style: NeumorphicStyle(depth: .2.h, intensity: .6, color: available ? Colors.greenAccent : Colors.redAccent),
                      child: Center(
                        child: Text(
                          available ? "Tersedia" : "Habis",
                          style: TextStyle(color: Colors.white, fontSize: 10.sp),
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
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 8.sp, fontWeight: FontWeight.normal, color: Colors.black38),
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
                          style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${currencyFormatter.format(priceProduk)}",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 8.sp, fontWeight: FontWeight.normal, color: Colors.red),
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
                          style: TextStyle(fontFamily: 'ghotic', fontSize: 8.sp, fontWeight: FontWeight.normal, color: Colors.black38),
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
