import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

Widget WidgetTextField(
    {initialValue,
    String? hint,
    onSaved,
    controller,
    String? title,
    messageError,
    isError,
    onChanged,
    obSecure,
    icon,
    keyboardtype,
    Function()? onDeleteText,
    textTitleColor,
    typeCurrency,
    onValidator}) {
  return Column(
    children: [
      title != null
          ? Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: textTitleColor != null
                            ? textTitleColor
                            : Colors.white),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    child: isError
                        ? Tooltip(
                            preferBelow: false,
                            triggerMode: TooltipTriggerMode.tap,
                            waitDuration: const Duration(seconds: 0),
                            showDuration: const Duration(seconds: 2),
                            textStyle: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10), color: Colors.green),
                            message: messageError,
                            child: Icon(
                              Icons.info,
                              color: Colors.red,
                              size: 3.h,
                            ),
                          )
                        : null,
                  ),
                ],
              ))
          : Container(),
      Row(
        children: [
          Expanded(
            child: Neumorphic(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.sp),
              style: NeumorphicStyle(
                  color: Colors.white,
                  depth: .2.h,
                  intensity: 1,
                  shadowLightColor: Colors.white70,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.all(Radius.circular(20)))),
              child: TextFormField(
                controller: controller != null ? controller : null,
                initialValue: initialValue,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: keyboardtype,
                inputFormatters: typeCurrency != null
                    ? typeCurrency && keyboardtype == TextInputType.number
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter()
                          ]
                        : keyboardtype == TextInputType.number
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : null
                    : keyboardtype == TextInputType.number
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ]
                        : null,
                maxLines: obSecure ? 1 : null,
                style: TextStyle(fontSize: 10.sp),
                onChanged: onChanged,
                obscureText: obSecure,
                decoration: InputDecoration(
                  hintText: hint,
                  errorStyle: const TextStyle(height: 0),
                  contentPadding: EdgeInsets.all(0.h),
                  prefixIcon: Icon(
                    icon,
                    size: 16.sp,
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.4), width: 0.0),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  // validator!(value);
                  if (value!.isNotEmpty) {
                    // print(
                    //     "email ${equalsIgnoreAsciiCase(title.toString(), "email")}");
                    if (equalsIgnoreAsciiCase(title.toString(), "email")) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        print("email valid");
                        return null;
                      } else {
                        // print("valid");
                        // onSaved(null);
                        return "password error";
                      }
                    }
                    return null;
                  }
                  return "password error";
                },
                onSaved: (value) {
                  onSaved(value);
                  // this._name = value!;
                },
              ),
            ),
          ),
          onDeleteText != null
              ? NeumorphicButton(
                  onPressed: onDeleteText,
                  // margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.transparent,
                    depth: 1,
                  ),

                  child: NeumorphicIcon(
                    Icons.cancel_rounded,
                    style: NeumorphicStyle(
                      depth: .1.h,
                      color: Colors.black87,
                    ),
                    size: 7.w,
                  ),
                )
              : Container(),
        ],
      )
    ],
  );
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    int value = int.parse(newValue.text);

    final formatter =
        NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 0);

    String newText = formatter.format(value).replaceAll(',', '');
    print("$newText $value");
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
