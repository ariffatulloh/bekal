import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/main_content/cubit/home_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/ViewProduct.dart';
import 'package:bekal/page/main_content/ui/my_store/widget_create_product/BodyListProduct.dart';
import 'package:bekal/page/main_content/ui/profile/profile_screen.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var _index = 0;

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
            itemBottomNavBar(
              countNotif: 0,
              icon: Icons.chat,
            ),
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
          onTap: (index) {
            setState(() {
              _index = index;
            });
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
            size: 3.h,
            color: Color(0xfff39200),
          ),
          // top: 2,
        ),
        countNotif > 1
            ? Positioned(
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
                                            onClick: () {
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
                                                    return FutureBuilder(
                                                        future: HomeScreenCubit()
                                                            .getHomeSeeDetailProduct(
                                                                idProduct: object
                                                                    .storeProdId,
                                                                idStore: object
                                                                    .store
                                                                    .storeID),
                                                        builder: (context,
                                                            snapshot) {
                                                          PayloadResponseStoreProduct?
                                                              dataDetailProduct;
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            PayloadResponseApi
                                                                dataApiDetailProduct =
                                                                snapshot.data
                                                                    as PayloadResponseApi;
                                                            if (dataApiDetailProduct
                                                                .errorMessage
                                                                .isEmpty) {
                                                              dataDetailProduct =
                                                                  dataApiDetailProduct
                                                                      .data;
                                                            }
                                                          }
                                                          return ViewProduct(
                                                              dataDetailProduct:
                                                                  dataDetailProduct,
                                                              idProduct: object
                                                                  .storeProdId);
                                                        });
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
                                            onClick: () {
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
                                                    return FutureBuilder(
                                                        future: HomeScreenCubit()
                                                            .getHomeSeeDetailProduct(
                                                                idProduct: object
                                                                    .storeProdId,
                                                                idStore: object
                                                                    .store
                                                                    .storeID),
                                                        builder: (context,
                                                            snapshot) {
                                                          PayloadResponseStoreProduct?
                                                              dataDetailProduct;
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            PayloadResponseApi
                                                                dataApiDetailProduct =
                                                                snapshot.data
                                                                    as PayloadResponseApi;
                                                            if (dataApiDetailProduct
                                                                .errorMessage
                                                                .isEmpty) {
                                                              dataDetailProduct =
                                                                  dataApiDetailProduct
                                                                      .data;
                                                            }
                                                          }
                                                          return ViewProduct(
                                                              dataDetailProduct:
                                                                  dataDetailProduct,
                                                              idProduct: object
                                                                  .storeProdId);
                                                        });
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
