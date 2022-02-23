import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DropDownFormField extends FormField<dynamic> {
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final bool enabled;
  final EdgeInsets contentPadding;
  final double borderRadius;
  final bool isLoading;

  DropDownFormField(
      {FormFieldSetter<dynamic>? onSaved,
      FormFieldValidator<dynamic>? validator,
      AutovalidateMode autovalidate = AutovalidateMode.disabled,
      this.hintText = 'Pilih salah satu',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource = const [],
      this.textField = "name",
      this.valueField = "id",
      required this.onChanged,
      this.borderRadius = 25.0,
      this.filled = true,
      this.enabled = true,
      this.isLoading = false,
      this.contentPadding = const EdgeInsets.fromLTRB(0, 3, 6, 3)})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: contentPadding,
                          filled: filled,
                          fillColor: Colors.white70,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius:
                                new BorderRadius.circular(borderRadius),
                            borderSide: BorderSide(
                                color: state.hasError
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: BorderSide(
                                color: Colors.red, style: BorderStyle.solid),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<dynamic>(
                              isExpanded: true,
                              hint: Text(
                                hintText,
                                style: TextStyle(color: Colors.grey),
                              ),
                              value: value == '' ? null : value,
                              onChanged: enabled
                                  ? (dynamic newValue) {
                                      state.didChange(newValue);
                                      onChanged(newValue);
                                    }
                                  : null,
                              items: dataSource.map((item) {
                                if ("${item[valueField]}" == "0") {
                                  print("${item[textField]}");
                                }
                                return DropdownMenuItem<dynamic>(
                                  value: "${item[valueField]}",
                                  child: Text("${item[textField]}",
                                      overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: state.hasError ? 5.0 : 0.0),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          state.hasError ? state.errorText! : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700,
                              fontSize: state.hasError ? 12.0 : 0.0),
                        ),
                      ),
                    ],
                  ),
                  if (isLoading)
                    Positioned(
                      right: 10,
                      child: SpinKitFadingCircle(
                        color: Colors.grey,
                        size: 25.0,
                      ),
                    )
                ],
              ),
            );
          },
        );
}
