import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/strings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Toaster {
  final BuildContext context;
  Toaster(this.context);

  void showInfo(
      {String title = "",
      required String message,
      String okText = "",
      Icon? icon,
      VoidCallback? onPressed}) {
    Alert(
        context: context,
        style: AlertStyle(
            buttonAreaPadding: EdgeInsets.only(bottom: 15),
            isCloseButton: false,
            isOverlayTapDismiss: false,
            isButtonVisible: false),
        content: Column(
          children: [
            SizedBox(height: 10),
            icon == null
                ? Icon(Icons.info_outline, size: 56, color: Colors.deepOrange)
                : icon,
            SizedBox(height: 10),
            Text(isEmpty(title) ? "INFORMATION" : title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8)),
            SizedBox(height: 5),
            Text(message, style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Container(
                width: 120,
                child: TextButton(
                    onPressed: onPressed == null
                        ? () => Navigator.of(context).pop()
                        : onPressed,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.red)))),
                    child: Text(
                      isEmpty(okText) ? "OK" : okText,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )))
          ],
        )).show();
  }

  void showToast(
      String message, IconData icon, Color mainColor, ToastGravity gravity) {
    FToast fToast = new FToast().init(context);

    fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: mainColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(
                width: 12.0,
              ),
              Flexible(
                child: Text(message, style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
        toastDuration: Duration(seconds: 3),
        gravity: gravity);
  }

  showErrorToast(String message, {gravity = ToastGravity.CENTER}) {
    showToast(message, Icons.warning_amber_outlined, Colors.redAccent, gravity);
  }

  showSuccessToast(String message, {gravity = ToastGravity.CENTER}) {
    showToast(message, Icons.check_circle_outline, Colors.green, gravity);
  }
}
