import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

Widget dropDownButtonCustom<T>(
    {T? value,
    String? title,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title != null
          ? Column(
              children: [
                Text("$title",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 1.h,
                ),
              ],
            )
          : Container(),
      Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.sp),
        style: NeumorphicStyle(
            color: Colors.white,
            depth: .2.h,
            intensity: 1,
            shadowLightColor: Colors.white70,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(20)))),
        child: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              menuMaxHeight: 100.h,
              isExpanded: true,
              iconEnabledColor: Colors.black87,
              iconDisabledColor: Colors.black87,
              hint: Text('Silahkan pilih bank'),
              items: items,

              // listBankCodeDisbursements
              //     .map((Map<String, dynamic> item) =>
              //     DropdownMenuItem(
              //         value: item['code'],
              //         child: Text(item['name'],
              //             overflow: TextOverflow.ellipsis)))
              //     .toList(),
              onChanged: onChanged,
              value: value,
            ),
          ),
        ),
      ),
    ],
  );
}

// class dropdownBasic<T> extends StatefulWidget {
//   dropdownBasic(
//       {required this.value, required this.items, required this.onChanged});
//   T? value;
//   List<DropdownMenuItem<T>> items;
//   Function(T?) onChanged;
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return DropdownBasicState();
//   }
// }
//
// class DropdownBasicState extends State<dropdownBasic> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Column(
//         children: [
//           Text("Pilih Bank",
//               style: TextStyle(
//                 fontSize: 10.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               )),
//           SizedBox(
//             height: 1.h,
//           ),
//           Neumorphic(
//             margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.sp),
//             style: NeumorphicStyle(
//                 color: Colors.white,
//                 depth: .2.h,
//                 intensity: 1,
//                 shadowLightColor: Colors.white70,
//                 shape: NeumorphicShape.flat,
//                 boxShape: NeumorphicBoxShape.roundRect(
//                     BorderRadius.all(Radius.circular(20)))),
//             child: Container(
//               width: 100.w,
//               padding: EdgeInsets.symmetric(horizontal: 3.w),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   menuMaxHeight: 100.h,
//                   isExpanded: true,
//                   iconEnabledColor: Colors.black87,
//                   iconDisabledColor: Colors.black87,
//                   hint: Text('Silahkan pilih bank'),
//                   items: widget.items,
//
//                   // listBankCodeDisbursements
//                   //     .map((Map<String, dynamic> item) =>
//                   //     DropdownMenuItem(
//                   //         value: item['code'],
//                   //         child: Text(item['name'],
//                   //             overflow: TextOverflow.ellipsis)))
//                   //     .toList(),
//                   onChanged: widget.onChanged,
//                   value: widget.value,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
