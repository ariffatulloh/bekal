import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class XDIpro1 extends StatelessWidget {
  XDIpro1({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x54000000),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 38.0, end: 38.0),
            Pin(size: 119.0, middle: 0.5008),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
