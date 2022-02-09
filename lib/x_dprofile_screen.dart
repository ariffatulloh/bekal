import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDprofile_screen extends StatelessWidget {
  XDprofile_screen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 207.0, end: 0.0),
            Pin(size: 212.0, start: 0.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(104.0, 0.0),
                  child: SizedBox(
                    width: 103.0,
                    height: 134.0,
                    child: SvgPicture.string(
                      _svg_dh7r5a,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(39.0, 96.0),
                  child: Container(
                    width: 77.0,
                    height: 77.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xfff39200),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, 173.0),
                  child: Container(
                    width: 39.0,
                    height: 39.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xfff39200),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
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
          Pinned.fromPins(
            Pin(size: 375.0, start: 0.0),
            Pin(size: 812.0, start: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 75.0, middle: 0.5),
                  Pin(size: 24.0, middle: 0.75),
                  child: Text(
                    'PROFILE',
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontSize: 20,
                      color: const Color(0xfff39200),
                      letterSpacing: 0.21999999999999997,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_dh7r5a =
    '<svg viewBox="272.0 0.0 103.0 134.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(265.0, -18.0)" d="M 7.000200271606445 75.99960327148438 C 7.000200271606445 52.75083923339844 17.43889617919922 31.94074630737305 33.88558197021484 18 L 109.9998016357422 18 L 109.9998016357422 147.0644226074219 C 101.609245300293 150.2543182373047 92.50958251953125 152.0001068115234 82.99980163574219 152.0001068115234 C 41.0265007019043 152.0001068115234 7.000200271606445 117.9738006591797 7.000200271606445 75.99960327148438 Z" fill="#f39200" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
