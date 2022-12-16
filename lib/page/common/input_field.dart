import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

class TextInput extends StatefulWidget {
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final bool validate;
  final bool isBorder;
  final bool isCurrency;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final String value;
  final double borderRadius;
  final bool enabled;

  final List<TextInputFormatter>? inputFormatter;

  final regEx = RegExp(TextInput.pattern);
  static const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  TextInput(
      {Key? key,
      this.hintText,
      this.labelText,
      this.style,
      this.keyboardType,
      this.textInputAction,
      this.maxLines,
      this.maxLength,
      this.prefixIcon,
      this.contentPadding,
      this.obscureText = false,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.validate = true,
      this.inputFormatter,
      this.textAlign,
      this.isBorder = true,
      this.borderRadius = 25.0,
      this.isCurrency = false,
      this.enabled = true,
      this.value = ""})
      : super(key: key);

  @override
  _TextInputState createState() => _TextInputState(value);
}

class _TextInputState extends State<TextInput> {
  final _controller;
  bool touched;

  _TextInputState(value)
      : _controller = isBlank(value)
            ? TextEditingController()
            : TextEditingController.fromValue(TextEditingValue(text: value)),
        touched = isNotEmpty(value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: "in").currencySymbol;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType ??
          (widget.maxLines == 1 ? TextInputType.text : TextInputType.multiline),
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      cursorColor: Colors.red,
      textInputAction: widget.textInputAction,
      style: widget.style,
      inputFormatters: widget.inputFormatter,
      validator: widget.validator ??
          (value) {
            String? res;
            if (widget.validate) {
              res = _validateValue(value);
            }

            if (!isEmpty(value) && isBlank(res)) {
              if (widget.keyboardType == TextInputType.emailAddress) {
                return _validateEmail(value!);
              } else if (widget.keyboardType == TextInputType.phone) {
                return _validatePhone(value!);
              }
            }

            return res;
          },
      onChanged: (String value) => {
        if (widget.onChanged != null) {widget.onChanged!(value)},
        setState(() {
          this.touched = isNotEmpty(value);
        })
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: widget.onSaved,
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon:
              widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
          contentPadding: widget.contentPadding,
          prefixText: widget.isCurrency ? currency : "",
          suffixIcon: touched
              ? widget.enabled
                  ? InkWell(
                      child: Icon(Icons.clear, color: Colors.grey),
                      onTap: () => {
                        _clearInput(),
                        if (widget.onChanged != null) {widget.onChanged!("")},
                      },
                    )
                  : null
              : null,
          focusColor: Colors.red,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: Colors.white, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: Colors.red, style: BorderStyle.solid),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: Colors.black54, style: BorderStyle.solid),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[600]),
          hintText: widget.hintText,
          fillColor:
              !widget.enabled ? Colors.grey.withOpacity(.1) : Colors.white70),
    );
  }

  void _clearInput() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _controller.clear());
    // setState(() {
    //   touched = false;
    // });
  }

  String? _validateValue(String? value) {
    if (isEmpty(value)) return "Isian tidak boleh kosong";
    return null;
  }

  String? _validateEmail(String email) {
    if (!widget.regEx.hasMatch(email.trim()))
      return "Isian salah. Contoh 'email@provider.domain' ";
    else
      return null;
  }

  String? _validatePhone(String phone) {
    if (!RegExp(r'^(0)8[1-9][0-9]{7,10}$').hasMatch(phone.trim()))
      return "Isian salah. Contoh '081234563456' ";
    else
      return null;
  }
}
