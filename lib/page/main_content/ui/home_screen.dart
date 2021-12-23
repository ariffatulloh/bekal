import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
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
          color: const Color.fromRGBO(243, 146, 0, .8),
          buttonBackgroundColor: const Color.fromRGBO(243, 146, 0, .8),
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
            size: 4.h,
            color: Colors.white,
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
        return ProfileWidget(context);
    }
  }

  HomeWidget() {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Colors.black12,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 7.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produk Terpopuler",
              style: TextStyle(
                  fontFamily: 'ghotic',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 3.w,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Row(
                children: [
                  ItemHome(
                    imageProduk: AssetImage('assets/1.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: false,
                    nameProduk: "singal kaltara",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/1.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "singal kaltara",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/4.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "batik kaltara",
                    priceProduk: 3000000,
                    counterSell: 9999,
                    counterViews: 3000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/5.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "baju batik kaltara v1",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/3.jpg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: false,
                    nameProduk: "singal kaltara versi new 2021 ",
                    priceProduk: 500000,
                    counterSell: 99,
                    counterViews: 200,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/6.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "baju batik kaltara versi original pengantin",
                    priceProduk: 500000,
                    counterSell: 99,
                    counterViews: 200,
                  ),
                ],
              ),
            ),
            Text(
              "Produk Terlaris",
              style: TextStyle(
                  fontFamily: 'ghotic',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 3.w,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ItemHome(
                    imageProduk: AssetImage('assets/1.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "singal kaltara",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/4.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: false,
                    nameProduk: "batik kaltara",
                    priceProduk: 3000000,
                    counterSell: 9999,
                    counterViews: 3000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/6.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "baju batik kaltara versi original pengantin",
                    priceProduk: 500000,
                    counterSell: 99,
                    counterViews: 200,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/5.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "baju batik kaltara v1",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/1.jpeg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "singal kaltara",
                    priceProduk: 300000,
                    counterSell: 999,
                    counterViews: 2000,
                  ),
                  ItemHome(
                    imageProduk: AssetImage('assets/3.jpg'),
                    logoToko: AssetImage('assets/hectic_logo.png'),
                    available: true,
                    nameProduk: "singal kaltara versi new 2021 ",
                    priceProduk: 500000,
                    counterSell: 99,
                    counterViews: 200,
                  ),
                ],
              ),
            ),
            Text(
              "Semua Produk",
              style: TextStyle(
                  fontFamily: 'ghotic',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 3.w,
            ),
            Wrap(
              children: [
                ItemHome(
                  imageProduk: AssetImage('assets/1.jpeg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: false,
                  nameProduk: "singal kaltara",
                  priceProduk: 300000,
                  counterSell: 999,
                  counterViews: 2000,
                ),
                ItemHome(
                  imageProduk: AssetImage('assets/4.jpeg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: true,
                  nameProduk: "batik kaltara",
                  priceProduk: 3000000,
                  counterSell: 9999,
                  counterViews: 3000,
                ),
                ItemHome(
                  imageProduk: AssetImage('assets/6.jpeg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: true,
                  nameProduk: "baju batik kaltara versi original pengantin",
                  priceProduk: 500000,
                  counterSell: 99,
                  counterViews: 200,
                ),
                ItemHome(
                  imageProduk: AssetImage('assets/5.jpeg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: false,
                  nameProduk: "baju batik kaltara v1",
                  priceProduk: 300000,
                  counterSell: 999,
                  counterViews: 2000,
                ),
                ItemHome(
                  imageProduk: AssetImage('assets/1.jpeg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: true,
                  nameProduk: "singal kaltara",
                  priceProduk: 300000,
                  counterSell: 999,
                  counterViews: 2000,
                ),
                ItemHome(
                  imageProduk: AssetImage('assets/3.jpg'),
                  logoToko: AssetImage('assets/hectic_logo.png'),
                  available: true,
                  nameProduk: "singal kaltara versi new 2021 ",
                  priceProduk: 500000,
                  counterSell: 99,
                  counterViews: 200,
                ),
              ],
            )
          ],
        ),
      ),
    );
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
