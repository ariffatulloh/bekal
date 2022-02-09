import 'dart:math' as math;

import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class XDIpro extends StatelessWidget {
  XDIpro({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x26000000),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 207.0, end: 0.0),
            Pin(size: 212.0, start: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 103.0, end: 0.0),
                  Pin(size: 134.0, start: 0.0),
                  child: SvgPicture.string(
                    _svg_dh7r5a,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 77.0, middle: 0.3),
                  Pin(size: 77.0, middle: 0.7111),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: Color(0xfff39200),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 39.0, start: 0.0),
                  Pin(size: 39.0, end: 0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: Color(0xfff39200),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              // color: Colors.black38,
              width: 100.w,
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(.8.h),
                      style: NeumorphicStyle(
                          color: Color((265 * 0xFFFFFF * 100).toInt())
                              .withOpacity(1),
                          shape: NeumorphicShape.concave,
                          depth: .2.h,
                          intensity: 1),
                      child: Container(
                        width: 90.w,
                        padding: EdgeInsets.all(1.h),
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
                                  width: 3.w.h,
                                  height: 3.w.h,
                                  child: AspectRatio(
                                    aspectRatio: 1.w / 1.w,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/propic_sample.jpg'),
                                      fit: BoxFit.cover, // use this
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: .8.h,
                            ),
                            Text(
                              "Hallo, Muhammad Rizki Ariffatulloh",
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
                              "mr.ariffatulloh@gmail.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: .8.h,
                            ),
                            // NeumorphicButton(
                            //   onPressed: () {},
                            //   padding: const EdgeInsets.only(
                            //       top: 5, bottom: 5, left: 15, right: 15),
                            //   style: NeumorphicStyle(
                            //       shape: NeumorphicShape.concave,
                            //       depth: .2.h,
                            //       intensity: 1),
                            //   child: Text(
                            //     "Ubah",
                            //     style: TextStyle(fontSize: 10.sp),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(.8.h),
                      style: NeumorphicStyle(
                          color: Color((100 * 0xFFFFFF * 100).toInt())
                              .withOpacity(.8),
                          shape: NeumorphicShape.concave,
                          depth: .2.h,
                          intensity: 1),
                      child: Container(
                        width: 90.w,
                        padding: EdgeInsets.all(1.h),
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
                                  width: 1.5.w.h,
                                  height: 1.5.w.h,
                                  child: AspectRatio(
                                    aspectRatio: 1.w / 1.w,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/propic_sample.jpg'),
                                      fit: BoxFit.cover, // use this
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: .8.h,
                            ),
                            Text(
                              "Toko Hectic",
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
                              "JL.Pamulang indah blok A.6 No.5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            NeumorphicButton(
                              onPressed: () {},
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15, right: 15),
                              style: NeumorphicStyle(
                                  color: Color((100 * 0xFFFFFF * 103).toInt())
                                      .withOpacity(0),
                                  shape: NeumorphicShape.flat,
                                  depth: .2.h,
                                  intensity: 1),
                              child: Text(
                                "Lihat Toko",
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 90.w,
                      child: MasonryGridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        shrinkWrap: true,
                        itemCount: datatitle.length,
                        itemBuilder: (context, index) {
                          print("grid index $index");
                          return listMenuItemProfile(
                            index: index,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

List<itemMenu> datatitle = [
  itemMenu(
    text: "Ubah Data Pribadi",
    icon: Icons.person,
  ),
  itemMenu(
    text: "Ubah Email",
    icon: Icons.alternate_email_outlined,
  ),
  itemMenu(
    text: "Ubah Password",
    icon: Icons.vpn_key_sharp,
  ),
  itemMenu(
    text: "Histori Transaksi",
    icon: Icons.library_books_rounded,
  ),
  itemMenu(
    text: "Keluar",
    icon: Icons.logout,
  ),
];

class itemMenu {
  String text;
  IconData icon;
  itemMenu({required this.text, required this.icon});
}

class listMenuItemProfile extends StatelessWidget {
  listMenuItemProfile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  int index;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        margin: EdgeInsets.all(.5.h),
        style: NeumorphicStyle(
            color: Color((math.Random().nextDouble() * 0xFFFFFF * 100).toInt()),
            depth: .2.h,
            surfaceIntensity: .3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.roundRect(
                const BorderRadius.all(Radius.circular(10)))),
        child: Container(
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
        ));
  }
}

const String _svg_dh7r5a =
    '<svg viewBox="272.0 0.0 103.0 134.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(265.0, -18.0)" d="M 7.000200271606445 75.99960327148438 C 7.000200271606445 52.75083923339844 17.43889617919922 31.94074630737305 33.88558197021484 18 L 109.9998016357422 18 L 109.9998016357422 147.0644226074219 C 101.609245300293 150.2543182373047 92.50958251953125 152.0001068115234 82.99980163574219 152.0001068115234 C 41.0265007019043 152.0001068115234 7.000200271606445 117.9738006591797 7.000200271606445 75.99960327148438 Z" fill="#f39200" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_srjxy =
    '<svg viewBox="0.0 0.0 11.6 11.6" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="1"/></filter></defs><path  d="M 11.58839988708496 5.79419994354248 C 11.58839988708496 8.994250297546387 8.994248390197754 11.58839988708496 5.79419994354248 11.58839988708496 C 2.594151496887207 11.58839988708496 0 8.994248390197754 0 5.79419994354248 C 0 2.594151496887207 2.594151973724365 0 5.79419994354248 0 C 8.994250297546387 0 11.58839988708496 2.594151973724365 11.58839988708496 5.79419994354248 Z M 5.537968158721924 7.710793018341064 C 5.396366596221924 7.852396011352539 5.396366596221924 8.081978797912598 5.537968635559082 8.223581314086914 C 5.67957067489624 8.365182876586914 5.909153461456299 8.365182876586914 6.050755977630615 8.223580360412598 L 8.223580360412598 6.050755023956299 C 8.291691780090332 5.982814311981201 8.329970359802246 5.890565395355225 8.329970359802246 5.794361114501953 C 8.329970359802246 5.698158264160156 8.291691780090332 5.605907917022705 8.223580360412598 5.537968158721924 L 6.050755023956299 3.365143060684204 C 5.909153461456299 3.223540782928467 5.67957067489624 3.223540782928467 5.537968158721924 3.365143060684204 C 5.396366596221924 3.506745338439941 5.396366596221924 3.736327886581421 5.537968635559082 3.877929925918579 L 7.092745304107666 5.43206262588501 L 3.621375560760498 5.43206262588501 C 3.421371936798096 5.43206262588501 3.259238004684448 5.594197273254395 3.259238004684448 5.79419994354248 C 3.259238004684448 5.994203567504883 3.421371936798096 6.156337738037109 3.621375560760498 6.156337738037109 L 7.092745304107666 6.156337738037109 L 5.537646293640137 7.710793018341064 Z" fill="#000000" stroke="none" stroke-width="0.4166666567325592" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_e9i5 =
    '<svg viewBox="0.0 0.0 14.0 14.1" ><path transform="translate(-1.16, -1.16)" d="M 8.152422904968262 1.158839821815491 C 4.29010009765625 1.158839821815491 1.158840656280518 4.31195068359375 1.158840656280518 8.201226234436035 C 1.158840656280518 12.09050178527832 4.29010009765625 15.24361228942871 8.152422904968262 15.24361228942871 C 12.01474475860596 15.24361228942871 15.14600372314453 12.09050178527832 15.14600372314453 8.201226234436035 C 15.14600372314453 4.31195068359375 12.01520919799805 1.158839821815491 8.152422904968262 1.158839821815491 Z M 11.64921092987061 8.905466079711914 L 8.851780891418457 8.905466079711914 L 8.851780891418457 11.72241878509521 L 7.453064441680908 11.72241878509521 L 7.453064441680908 8.905466079711914 L 4.655632019042969 8.905466079711914 L 4.655632019042969 7.496987819671631 L 7.453064441680908 7.496987819671631 L 7.453064441680908 4.680033683776855 L 8.851780891418457 4.680033683776855 L 8.851780891418457 7.496987819671631 L 11.64921092987061 7.496987819671631 L 11.64921092987061 8.905466079711914 Z" fill="#000000" stroke="none" stroke-width="0.38628000020980835" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
