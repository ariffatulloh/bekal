import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ModelItemListMenuMyProfile {
  String text;
  IconData icon;
  Widget widget;
  Alert? alert;
  ModelItemListMenuMyProfile(
      {required this.text,
      required this.icon,
      required this.widget,
      this.alert});
}
