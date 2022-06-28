import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import 'package:bekal/page/main_content/ui/ViewProduct.dart';
import 'package:bekal/page/main_content/ui/cart/cart_screen.dart';
import 'package:bekal/page/main_content/ui/chat/ChatDetailScreen.dart';
import 'package:bekal/page/main_content/ui/chat/ChatScreen.dart';
import 'package:bekal/page/main_content/ui/my_store/CreateProduct.dart';
import 'package:bekal/page/main_content/ui/my_store/ListArchivedProductDialog.dart';
import 'package:bekal/page/main_content/ui/my_store/WithdrawlScreen.dart';
import 'package:bekal/page/main_content/ui/my_store/daftar_pesanan.dart';
import 'package:bekal/page/main_content/ui/profile/widget/CardStoreMyProfile.dart';
import 'package:bekal/page/main_content/ui/profile/widget/content_dialog/DialogUbahBasicInformationStore.dart';
import 'package:bekal/page/utility_ui/config_wave_widget.dart';
import 'package:bekal/page/utility_ui/wave_widget.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class DashboardStore extends StatefulWidget {
  int storeId = -1;
  bool? mystore = false;

  DashboardStore({required this.storeId, this.mystore});

  @override
  _DashboardStore createState() => _DashboardStore();
}

Future<http.Response> getDataStore({required int storeId}) async =>
    http.get(Uri.parse('http://demo.rifias.live/api/view-outlet/$storeId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });

Future<http.Response> getDataProduct({required String url}) async =>
    http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await SecureStorage().getToken()}'
    });

class _DashboardStore extends State<DashboardStore>
    with TickerProviderStateMixin {
  var dummyImageVersion = '?dummy=${math.Random().nextInt(999)}';

  // late Animation<double> _animation;
  // late AnimationController _animationController=AnimationController(
  // vsync: this,
  // duration: Duration(milliseconds: 260),
  // );
  // final curvedAnimation =
  // CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
  String uriUrl = "";
  double floatingX = 50.w;
  double floatingY = 83.h;
  int selectedIndexCategory = 0;
  DefaultCacheManager imageManager = new DefaultCacheManager();
  bool isDoneCallFromApi = false;
  Map<String, dynamic> dataStore = Map<String, dynamic>();
  List<Map<String, dynamic>> dataListProductStore = [];
  MyDashboardProfileOutlets myDashboardProfileOutlets =
      MyDashboardProfileOutlets();
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  bool isRefresh = false;

  Future<void> callFromApi() async {
    http.Response snapshotDataStore =
        await getDataStore(storeId: widget.storeId);
    var bodyStoreResponse = json.decode(snapshotDataStore.body);
    Map<String, dynamic> dataBodyStore = Map<String, dynamic>();
    if (bodyStoreResponse['data'] != null) {
      dataBodyStore = bodyStoreResponse['data'];
    }
    MyDashboardProfileOutlets myDashboardProfileOutletsBodyResponse =
        MyDashboardProfileOutlets();
    if (widget.mystore ?? false) {
      PayloadResponseApi<PayloadResponseMyProfileDashboard?> myProfile =
          await ProfileRepository().myProfileDashboard("authorization");
      if (myProfile.data != null) {
        if (myProfile.data!.myOutlets != null) {
          myProfile.data!.myOutlets!.forEach((element) {
            if (widget.storeId == element.storeId) {
              myDashboardProfileOutletsBodyResponse = element;
            }
          });
        }
      }
    }

    // http.Response snapshotDataProductInStore =
    //     await getDataProduct(url: uriUrl);
    // var bodyProductInStoreResponse =
    //     json.decode(snapshotDataProductInStore.body);
    // List<Map<String, dynamic>> dataBodyListProductStore = [];
    // if (bodyProductInStoreResponse['data'] != null) {
    //   dataBodyListProductStore = bodyProductInStoreResponse['data'];
    // }
    String selectedUriCategory = "";
    bool uriHasSameInList = false;
    (dataBodyStore['storeListCategory'] as List).forEach((element) {
      print('data element $element');
      if (element['productInCategory'].toString().toLowerCase() ==
          uriUrl.toLowerCase()) {
        uriHasSameInList = true;
      }
      if (element['categoryName'].toString().toLowerCase() == "all") {
        selectedUriCategory = element['productInCategory'];
      }
    });
    if (!uriHasSameInList) {
      (dataBodyStore['storeListCategory'] as List).forEach((element) {
        if (element['categoryName'].toString().toLowerCase() == "all") {
          selectedUriCategory = element['productInCategory'];
        }
      });
    }

    setState(() {
      uriUrl = selectedUriCategory;
      isDoneCallFromApi = true;
      dataStore = dataBodyStore;

      if (widget.mystore ?? false) {
        myDashboardProfileOutlets = myDashboardProfileOutletsBodyResponse;
      }
      // dataListProductStore = dataBodyListProductStore;
    });
  }

  @override
  void initState() {
    super.initState();
    callFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return StreamBuilder(
    //   stream: getDataStore(storeId: widget.storeId).asStream(),
    //   builder: (context, AsyncSnapshot<http.Response> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     }
    //
    //     if (snapshot.connectionState != ConnectionState.done) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (snapshot.hasData) {
    //       var bodyResponse = json.decode(snapshot.data!.body);
    //
    //       if (bodyResponse['data'] != null) {
    //         var data = bodyResponse['data'];
    //         print('dashboardstore $data');
    //         if (uriUrl.isEmpty) {
    //           (data['storeListCategory'] as List).forEach((element) {
    //             print('data element $element');
    //             if (element['categoryName'].toString().toLowerCase() == "all") {
    //               uriUrl = element['productInCategory'];
    //             }
    //           });
    //           // setState(() {
    //           //   // (data['storeListCategory'] as List).forEach((element) {
    //           //   //   print(element);
    //           //   // });
    //           // });
    //         }
    //       }
    //     }
    //
    //   },
    // );
    if (isDoneCallFromApi) {
      return Scaffold(
        body: SafeArea(
            child: Neumorphic(
          style: NeumorphicStyle(color: Colors.white70),
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
                      size: 32,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('${dataStore['storeName']}'),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      Future.delayed(Duration(milliseconds: 100), () {
                        // if (stompClient != null) {
                        //   stompClient!.deactivate();
                        // }
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
                    child: GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                            duration: Duration(milliseconds: 1400),
                            animationCurve: Curves.easeInOut,
                            enableDrag: true,
                            isDismissible: false,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Future.delayed(
                                            Duration(milliseconds: 100), () {
                                          // if (stompClient != null) {
                                          //   stompClient!.deactivate();
                                          // }
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      padding: EdgeInsets.all(0.w.h),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 1.5.w),
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
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: CartScreen())
                                ],
                              );
                            });
                      },
                      child: NeumorphicIcon(
                        Icons.shopping_basket,
                        style: NeumorphicStyle(
                          depth: .1.h,
                          color: Colors.orangeAccent,
                        ),
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 30.h,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5.h),
                          alignment: Alignment.bottomCenter,
                          child: WaveWidget(
                            config: CustomConfig(
                              gradients: [
                                [
                                  const Color.fromRGBO(63, 142, 252, .4),
                                  const Color.fromRGBO(63, 142, 252, .1)
                                ],
                                [
                                  const Color.fromRGBO(243, 146, 0, .5),
                                  const Color.fromRGBO(243, 146, 0, .1)
                                ],
                                [
                                  const Color.fromRGBO(233, 78, 27, .5),
                                  const Color.fromRGBO(233, 78, 27, .1)
                                ],
                                [
                                  const Color.fromRGBO(231, 48, 42, .5),
                                  const Color.fromRGBO(231, 48, 42, .1)
                                ]
                              ],
                              durations: [18000, 9440, 10800, 6000],
                              heightPercentages: [-0.20, -0.23, -.1, -.22],
                              blur: const MaskFilter.blur(BlurStyle.solid, 20),
                              gradientBegin: Alignment.bottomLeft,
                              gradientEnd: Alignment.topRight,
                            ),
                            waveAmplitude: 8,
                            waveFrequency: 2,
                            heightPercentange: 2,
                            isLoop: true,
                            size: Size(100.w, 15.h),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Neumorphic(
                                  style: NeumorphicStyle(
                                      color: Colors.white70,
                                      border: NeumorphicBorder(
                                          width: 1.5, color: Colors.white70),
                                      boxShape: NeumorphicBoxShape.circle(),
                                      depth: .2.h,
                                      intensity: 1,
                                      surfaceIntensity: .5),
                                  child: Container(
                                    width: 25.w,
                                    height: 25.w,
                                    child: CachedNetworkImage(
                                      // cacheManager: imageManager,
                                      fit: BoxFit.cover,
                                      imageUrl: dataStore['storeImageUri'] +
                                          '?${math.Random().nextDouble()}',
                                      // imageBuilder: (context, imProvider) {
                                      //   return Image(image: imProvider);
                                      // },

                                      errorWidget: (context, url, error) {
                                        print('error $error}');
                                        return Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        );
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, error) {
                                        print('loadingBuilder$error');
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                  )),
                              SizedBox(
                                height: 16.sp,
                              ),
                              Neumorphic(
                                  style: NeumorphicStyle(
                                      color: Colors.white,
                                      border: NeumorphicBorder(
                                          width: 1.5, color: Colors.white70),
                                      depth: .5.h,
                                      intensity: 1,
                                      surfaceIntensity: .5),
                                  child: Container(
                                    width: 100.w,
                                    // height: 20.h,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var token =
                                                      await SecureStorage()
                                                          .getToken();
                                                  ProfileRepository()
                                                      .myProfileDashboard(
                                                          token!)
                                                      .then((value) async {
                                                    var getDataProfile =
                                                        value.data!;
                                                    showMaterialModalBottomSheet(
                                                        duration: Duration(
                                                            milliseconds: 1400),
                                                        animationCurve:
                                                            Curves.easeInOut,
                                                        enableDrag: true,
                                                        backgroundColor:
                                                            Colors.white,
                                                        context: context,
                                                        builder: (context) {
                                                          return ChatDetailScreen(
                                                            onClosed: () {},
                                                            accountSelected: PopUpList(
                                                                image: getDataProfile
                                                                        .image ??
                                                                    "",
                                                                id: getDataProfile
                                                                        .idUser ??
                                                                    -1,
                                                                userOrStore:
                                                                    "user",
                                                                nameDisplay:
                                                                    getDataProfile
                                                                            .nameUser ??
                                                                        ""),
                                                            withUser: ChatWith(
                                                                fullName: dataStore[
                                                                    'storeName'],
                                                                id: widget
                                                                    .storeId,
                                                                userOrStore:
                                                                    'store'),
                                                          );
                                                        });
                                                  });
                                                },
                                                child: NeumorphicIcon(
                                                  Icons.chat_sharp,
                                                  style: NeumorphicStyle(
                                                    depth: .1.h,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                  size: 32,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Text(
                                                "Chat",
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Icon(
                                                Icons.shopping_cart_sharp,
                                                color: Colors.orangeAccent,
                                                size: 32,
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Text(
                                                "99",
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Icon(
                                                Icons.shopping_bag_sharp,
                                                color: Colors.orangeAccent,
                                                size: 32,
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                              Text(
                                                "99",
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 8.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: dataStore['storeListCategory'] == null
                          ? []
                          : (dataStore['storeListCategory'] as List)
                              .map((e) => NeumorphicButton(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    pressed: true,
                                    onPressed: () {
                                      setState(() {
                                        uriUrl = e['productInCategory'];
                                        selectedIndexCategory = e['categoryId'];
                                      });
                                      // setState(() {
                                      //
                                      // });
                                    },
                                    style: NeumorphicStyle(
                                        color: selectedIndexCategory ==
                                                e['categoryId']
                                            ? Colors.blue
                                            : Colors.orangeAccent,
                                        depth: .2.h,
                                        intensity: .8,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.circular(20)))),
                                    child: Container(
                                      child: Text(
                                        e['categoryName'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ))
                              .toList(),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: getDataProduct(url: uriUrl).asStream(),
                        builder:
                            (context, AsyncSnapshot<http.Response> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            var bodyResponse = json.decode(snapshot.data!.body);
                            return MasonryGridView.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                                shrinkWrap: true,
                                itemCount: bodyResponse['data'] == null
                                    ? 0
                                    : (bodyResponse['data'] as List).length,
                                itemBuilder: (context, index) {
                                  var e = bodyResponse['data'] == null
                                      ? null
                                      : bodyResponse['data'][index];

                                  return NeumorphicButton(
                                    onPressed: () async {
                                      if (widget.mystore ?? false) {
                                        await showMaterialModalBottomSheet(
                                            duration:
                                                Duration(milliseconds: 1400),
                                            animationCurve: Curves.easeInOut,
                                            enableDrag: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return CreateProduct(
                                                onDismiss: (isDismiss) async {
                                                  setState(() {
                                                    isRefresh = true;
                                                  });
                                                  await callFromApi();
                                                },
                                                idStore: widget.storeId,
                                                idProduct: e['storeProdId'],
                                              );
                                            });
                                      } else {
                                        showMaterialModalBottomSheet(
                                            duration:
                                                Duration(milliseconds: 1400),
                                            animationCurve: Curves.easeInOut,
                                            enableDrag: true,
                                            isDismissible: false,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return ViewProduct(
                                                  idStore: widget.storeId,
                                                  dataDetailProduct: null,
                                                  idProduct: e['storeProdId']);
                                            });
                                      }
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 1.h),
                                    margin: EdgeInsets.symmetric(
                                        vertical: .5.h, horizontal: 2.w),
                                    style: NeumorphicStyle(
                                        color: Colors.white, depth: 1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Center(
                                              child: Neumorphic(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 1.w,
                                                      vertical: 1.w),
                                                  style: NeumorphicStyle(
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .circle(),
                                                      depth: 2,
                                                      intensity: 1,
                                                      surfaceIntensity: 1),
                                                  child: Container(
                                                      width: 30.w,
                                                      height: 30.w,
                                                      child: CachedNetworkImage(
                                                        imageUrl: e[
                                                                'uriThumbnail'] +
                                                            dummyImageVersion,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                          );
                                                        },
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                error) {
                                                          return CircularProgressIndicator(
                                                            color: Colors.blue,
                                                          );
                                                        },
                                                      ))),
                                            ),
                                            Positioned(
                                              top: .5.h,
                                              right: .5.w,
                                              child: Neumorphic(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    bottom: 2,
                                                    left: 5,
                                                    right: 5),
                                                style: NeumorphicStyle(
                                                    depth: .2.h,
                                                    intensity: .6,
                                                    color: int.parse(e[
                                                                'stockProduct']) >
                                                            0
                                                        ? Colors.greenAccent
                                                        : Colors.redAccent),
                                                child: Center(
                                                  child: Text(
                                                    int.parse(e['stockProduct']) >
                                                            0
                                                        ? "Tersedia"
                                                        : "Habis",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 8.sp),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e['nameProduct'],
                                                style: TextStyle(
                                                    fontFamily: 'ghotic',
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87),
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Text(
                                                "${currencyFormatter.format(int.parse(e['priceProduct']))}",
                                                style: TextStyle(
                                                    fontFamily: 'ghotic',
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.red),
                                              ),
                                              SizedBox(
                                                height: 2.sp,
                                              ),
                                              Text(
                                                // "TerJual: ${counterSell! > 9999 ? "9999+" : counterSell}",
                                                "",
                                                style: TextStyle(
                                                    fontFamily: 'ghotic',
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black38),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  )
                ],
              ),
            ),
          ]),
        )),
        floatingActionButton: isMyStoreAction(),
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget isMyStoreAction() {
    if (widget.mystore ?? false) {
      var _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 260),
      );

      final curvedAnimation = CurvedAnimation(
          curve: Curves.easeInOut, parent: _animationController);
      var _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
      return FloatingActionBubble(
        items: [
          Bubble(
            title: "Dompet",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.credit_card_rounded,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              showMaterialModalBottomSheet(
                  duration: Duration(milliseconds: 1400),
                  animationCurve: Curves.easeInOut,
                  enableDrag: false,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return WithdrawlScreen(idStore: widget.storeId);
                  });
            },
          ),
          Bubble(
            title: "Daftar Barang Dihapus",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.archive,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              showMaterialModalBottomSheet(
                  duration: Duration(milliseconds: 1400),
                  animationCurve: Curves.easeInOut,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return ListArchivedProductDialog(
                        storeId: widget.storeId,
                        onDismiss: (isDismiss) {
                          setState(() {
                            isRefresh = true;
                          });
                        });
                  });
            },
          ),
          Bubble(
            title: "Informasi Dasar",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.store_rounded,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              DialogBottomSheet(
                  title: "Informasi Dasar Toko",
                  icon: Icons.store_rounded,
                  contentBody: DialogUbahBasicInformationStore(
                    data: myDashboardProfileOutlets,
                    onDismiss: (onDismiss) {
                      if (onDismiss) {}
                    },
                  ),
                  context: context,
                  whenClosed: (whenClosed) {
                    if (whenClosed != null && whenClosed) {
                      setState(() {
                        isDoneCallFromApi = false;
                        callFromApi();
                      });

                      // context
                      //     .read<ProfileScreenCubit>()
                      //     .LoadMyProfileDashboard();
                      // Future.delayed(
                      //     Duration(milliseconds: 1), () {
                      //   // Navigator.of(context).pop();
                      // });
                    }
                  });
            },
          ),
          Bubble(
            title: "Informasi Pesanan",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.production_quantity_limits,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarPesanan(),
                ),
              );
            },
          ),
          Bubble(
            title: "Buat Produk",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.add_circle,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              showMaterialModalBottomSheet(
                  duration: Duration(milliseconds: 1400),
                  animationCurve: Curves.easeInOut,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CreateProduct(
                      idStore: widget.storeId,
                      onDismiss: (isDimiss) async {
                        setState(() {
                          isRefresh = true;
                        });
                        await callFromApi();
                      },
                      // idProduct: e['storeProdId'],
                    );
                  });
            },
          ),
        ],
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.white,

        // Flaoting Action button Icon
        iconData: Icons.format_list_bulleted,
        backGroundColor: Colors.blue,
      );
    }

    return Container();
  }

  CachedImageStore() {
    // imageManager.emptyCache();
    return Image.network(
      dataStore['storeImageUri'],

      // cacheManager: imageManager,
      fit: BoxFit.cover,
      // imageUrl: dataStore['storeImageUri'],
      // imageBuilder: (context, imProvider) {
      //   return Image(image: imProvider);
      // },
      frameBuilder: (context, widget, int, bool) {
        return widget;
      },
      errorBuilder: (context, url, error) {
        return Icon(
          Icons.person,
          color: Colors.black,
        );
      },
      loadingBuilder: (context, url, error) {
        return CircularProgressIndicator();
      },
    );
  }
}
