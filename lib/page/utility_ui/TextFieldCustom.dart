import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class TextFieldCustom extends StatefulWidget {
  final String label;
  final String hint;
  Key? keys;
  final Color? fieldColor;
  TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final bool? obscureText;
  TextFieldCustom(
      {required this.label,
      required this.hint,
      required this.onChanged,
      this.fieldColor,
      this.keys,
      this.obscureText,
      this.controller});

  @override
  TextFieldCustomState createState() => TextFieldCustomState();
}

class TextFieldCustomState extends State<TextFieldCustom> {
  late TextEditingController _controller;
  bool obSecureText = false;
  bool showError = false;
  String messageError = "";
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    obSecureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            children: [
              Text(
                this.widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Visibility(
                  visible: showError,
                  child: Tooltip(
                    message: messageError,
                    showDuration: Duration(seconds: 2),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration(milliseconds: 2),
                    child: Icon(
                      Icons.circle_notifications,
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            color: widget.fieldColor,
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: widget.keys,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      setState(() {
                        messageError = value?.isEmpty ?? true
                            ? "Lengkapi ${widget.label}"
                            : "";
                        showError = value?.isEmpty ?? true;
                      });
                      return value?.isEmpty ?? true ? "" : null;
                    },
                    controller: _controller,
                    obscureText: obSecureText,
                    onChanged: (value) {
                      widget.onChanged(value);
                    },
                    decoration: InputDecoration(
                        hintText: widget.hint,
                        errorStyle: TextStyle(height: 0),
                        border: InputBorder.none,
                        isCollapsed: true),
                  ),
                ),
              ),
              widget.obscureText != null
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          obSecureText = !obSecureText;
                        });
                      },
                      child: Icon(
                        obSecureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                    )
                  : Container()
            ],
          ),
        )
      ],
    );
  }
}

class ListDropDownFieldCustom {
  String _value = "";
  String _label = "";

  ListDropDownFieldCustom({String? value, String? label}) {
    _value = value ?? "";
    _label = label ?? "";
  }
  String get value => _value;

  set value(String value) {
    _value = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }
}

class DropDownFieldCustom extends StatefulWidget {
  final String label;
  final String hint;
  final Color? fieldColor;
  TextEditingController? controller;
  Key? keys;
  List<ListDropDownFieldCustom> listDropdown;
  DropDownFieldCustom(
      {required this.label,
      required this.hint,
      required this.listDropdown,
      this.keys,
      this.fieldColor,
      this.controller});

  @override
  DropDownFieldCustomState createState() => DropDownFieldCustomState();
}

class DropDownFieldCustomState extends State<DropDownFieldCustom> {
  late TextEditingController _controller;
  bool showError = false;
  String messageError = "";
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            children: [
              Text(
                this.widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Visibility(
                  visible: showError,
                  child: Tooltip(
                    message: messageError,
                    showDuration: Duration(seconds: 2),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration(milliseconds: 2),
                    child: Icon(
                      Icons.circle_notifications,
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            color: widget.fieldColor,
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: widget.keys,
                  child: TextFormField(
                    onTap: () {
                      showDialogDropDown();
                    },
                    validator: (value) {
                      setState(() {
                        messageError = value?.isEmpty ?? true
                            ? "Lengkapi ${widget.label}"
                            : "";
                        showError = value?.isEmpty ?? true;
                      });
                      return value?.isEmpty ?? true ? "" : null;
                    },
                    controller: _controller,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: widget.hint,
                        errorStyle: TextStyle(height: 0),
                        border: InputBorder.none,
                        isCollapsed: true),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialogDropDown();
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void showDialogDropDown() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            constraints: BoxConstraints(maxHeight: 30.h),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text("Pilih ${widget.label}"),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: widget.listDropdown
                            .map((e) => Container(
                                  width: 98.w,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      setState(() {
                                        _controller.text = e.value;
                                      });
                                      Navigator.pop(context);
                                    },
                                    style: NeumorphicStyle(
                                        depth: 1, color: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(e.value),
                                        ),
                                        Icon(Icons.arrow_right)
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class DateFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final Color? fieldColor;
  final Function(DateTime dateTimeValue, String stringValue) onChanged;
  Key? keys;
  // final ValueChanged<String> onChanged;

  DateFieldCustom(
      {required this.label,
      required this.hint,
      required this.onChanged,
      this.controller,
      this.keys,
      this.fieldColor});

  @override
  DateFieldCustomState createState() => DateFieldCustomState();
}

class DateFieldCustomState extends State<DateFieldCustom> {
  late TextEditingController _controller;
  DateTime? selectedDOB;
  bool showError = false;
  String messageError = "";
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            children: [
              Text(
                this.widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Visibility(
                  visible: showError,
                  child: Tooltip(
                    message: messageError,
                    showDuration: Duration(seconds: 2),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration(milliseconds: 2),
                    child: Icon(
                      Icons.circle_notifications,
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
        ),
        Neumorphic(
            margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
            style: NeumorphicStyle(
              color: widget.fieldColor,
              depth: NeumorphicTheme.embossDepth(context),
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Form(
              key: widget.keys,
              child: TextFormField(
                onTap: () async {
                  DateTime? newSelectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1945),
                    lastDate: DateTime.now(),
                  );
                  if (newSelectedDate != null) {
                    selectedDOB = newSelectedDate;
                    setState(() {
                      _controller
                        ..text = DateFormat("dd MMM y")
                            .format(selectedDOB ?? DateTime.now())
                        ..selection = TextSelection.fromPosition(TextPosition(
                            offset: _controller.text.length,
                            affinity: TextAffinity.upstream));
                      widget.onChanged(
                          selectedDOB ?? DateTime.now(), _controller.text);
                    });

                    // widget.onChanged(
                    //     selectedDOB ?? DateTime.now(), _controller.text);
                  }
                  // showDialogDropDown();
                },
                validator: (value) {
                  setState(() {
                    messageError = value?.isEmpty ?? true
                        ? "Lengkapi ${widget.label}"
                        : "";
                    showError = value?.isEmpty ?? true;
                  });
                  return value?.isEmpty ?? true ? "" : null;
                },
                controller: _controller,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: widget.hint,
                    errorStyle: TextStyle(height: 0),
                    border: InputBorder.none,
                    isCollapsed: true),
              ),
            ))
      ],
    );
  }
}

class SwitchFormCustom extends StatelessWidget {
  String label;
  bool value;
  final ValueChanged<bool>? onChanged;
  Icon? leftIcon;
  Icon? rightIcon;
  SwitchFormCustom(
      {required this.label,
      required this.value,
      this.onChanged,
      this.leftIcon,
      this.rightIcon});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          child: Row(
            children: [
              leftIcon ?? Container(),
              NeumorphicSwitch(
                value: value,
                onChanged: onChanged,
                style: NeumorphicSwitchStyle(
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.pinkAccent,
                    activeTrackColor: Colors.blue),
              ),
              rightIcon ?? Container(),
            ],
          ),
        )
      ],
    );
  }
}
