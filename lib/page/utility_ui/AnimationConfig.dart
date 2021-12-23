import 'package:flutter/cupertino.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:sizer/sizer.dart';

import 'PropAnimation.dart';

class AnimationConfig {
  TimelineTween<PropsChangeLayoutToRegister> changeLayoutToRegister(
      BuildContext context) {
    return TimelineTween<PropsChangeLayoutToRegister>()
      ..addScene(
              begin: const Duration(microseconds: 0),
              duration: const Duration(microseconds: 100))
          .animate(
            PropsChangeLayoutToRegister.width,
            tween: Tween(begin: 0.w, end: MediaQuery.of(context).size.width),
            curve: Curves.fastOutSlowIn,
          )
          .animate(
            PropsChangeLayoutToRegister.height,
            tween: Tween(begin: 0.h, end: 100.h),
            curve: Curves.fastOutSlowIn,
          )
          .animate(
            PropsChangeLayoutToRegister.radius,
            tween: Tween(begin: 50.h, end: 0.0),
            curve: Curves.fastOutSlowIn,
          );
  }

  TimelineTween<PropsLoadUiRegister> AnimationLoadUiRegister(
      BuildContext context) {
    return TimelineTween<PropsLoadUiRegister>()
      ..addScene(
              begin: const Duration(microseconds: 0),
              duration: const Duration(microseconds: 700))
          .animate(
            PropsLoadUiRegister.positionBackground1HeighWidth,
            tween: Tween(begin: 0.w, end: 40.w),
            curve: Curves.fastOutSlowIn,
          )
          .animate(
            PropsLoadUiRegister.positionSmallBackground1HeighWidth,
            tween: Tween(begin: 0.w, end: 8.w),
            curve: Curves.fastOutSlowIn,
          )
      ..addScene(
              begin: const Duration(microseconds: 200),
              duration: const Duration(microseconds: 700))
          .animate(
            PropsLoadUiRegister.positionBackground2HeighWidth,
            tween: Tween(begin: 0.w, end: 70.w),
            curve: Curves.fastOutSlowIn,
          )
          .animate(
            PropsLoadUiRegister.positionSmallBackground2HeighWidth,
            tween: Tween(begin: 0.w, end: 10.w),
            curve: Curves.fastOutSlowIn,
          )
      ..addScene(
              begin: const Duration(microseconds: 350),
              duration: const Duration(microseconds: 700))
          .animate(
            PropsLoadUiRegister.positionBackground3HeighWidth,
            tween: Tween(begin: 0.w, end: 20.w),
            curve: Curves.fastOutSlowIn,
          )
          .animate(
            PropsLoadUiRegister.positionSmallBackground3HeighWidth,
            tween: Tween(begin: 0.w, end: 10.w),
            curve: Curves.fastOutSlowIn,
          );
  }
}
