import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:sizer/sizer.dart';

class MasterDropdown extends StatefulWidget {
  final String label;
  final String url;
  final String value;
  final Function(String) onItemSelected;
  final bool validate;
  final bool enabled;
  final double borderRadius;
  const MasterDropdown(
      {required this.url,
      this.label = "",
      this.value = "",
      this.validate = true,
      this.borderRadius = 25.0,
      this.enabled = true,
      required this.onItemSelected,
      Key? key})
      : super(key: key);

  @override
  _MasterDropdownState createState() => _MasterDropdownState();
}

class _MasterDropdownState extends State<MasterDropdown> {
  bool isLoading = true;
  late String selectedData;
  List listData = [];

  late DioClient _dio = new DioClient();

  @override
  void initState() {
    super.initState();
    selectedData = widget.value;

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isEmpty(widget.label)) inputLabel(widget.label, widget.validate),
        DropDownFormField(
          value: selectedData,
          isLoading: isLoading,
          autovalidate: AutovalidateMode.onUserInteraction,
          validator: widget.validate
              ? (value) {
                  if (isEmpty(value))
                    return "Harus dipilih salah satu";
                  else
                    return null;
                }
              : null,
          borderRadius: widget.borderRadius,
          enabled: widget.enabled,
          onChanged: (value) {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (this.mounted) {
              setState(() {
                selectedData = value;
              });
              widget.onItemSelected(value);
            }
          },
          dataSource: listData,
        ),
      ],
    );
  }

  getData() async {
    print("load province data");
    List dataRes = [];
    try {
      DioResponse res = await _dio.getAsync(widget.url);

      if (res.results["code"] == 200) {
        dataRes = res.results["data"];
        print(res.results["data"]);
      }
    } catch (e) {}

    if (this.mounted) {
      setState(() {
        listData = dataRes;
        isLoading = false;
      });
    }
  }

  Widget inputLabel(String text, bool required) => Padding(
        padding: EdgeInsets.only(top: 15, bottom: 8),
        child: RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              if (required)
                TextSpan(
                  text: "*",
                  style: TextStyle(fontSize: 14, color: Colors.red),
                )
            ],
          ),
        ),
      );
}
