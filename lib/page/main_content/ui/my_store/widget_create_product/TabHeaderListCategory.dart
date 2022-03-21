import 'package:bekal/payload/response/PayloadResponseStoreCategory.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class passParameterTabHeaderListCategory {
  int index;
  String value;
  passParameterTabHeaderListCategory(
      {required this.index, required this.value});
}

class TabHeaderListCategory extends StatefulWidget {
  final int selectedIndex;
  final int idStore;
  final List<PayloadResponseStoreCategory> listCategory;
  final ValueChanged<passParameterTabHeaderListCategory> selectedCategoryName;
  const TabHeaderListCategory({
    Key? key,
    required this.idStore,
    required this.listCategory,
    required this.selectedCategoryName,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _TabHeaderListCategory createState() => _TabHeaderListCategory();
}

class _TabHeaderListCategory extends State<TabHeaderListCategory> {
  //
  @override
  Widget build(BuildContext context) {
    List<PayloadResponseStoreCategory> list = [];
    print("${widget.selectedIndex} notime");
    var itemList = PayloadResponseStoreCategory(
        storeName: widget.listCategory.elementAt(0).storeName,
        categoryName: "All",
        categoryId: 0);
    list.add(itemList);
    if (widget.listCategory != null) {
      if (widget.listCategory.isNotEmpty) {
        list.addAll(widget.listCategory);
      }
    }

    print("${widget.selectedIndex} notime");
    return Neumorphic(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.w),
      style: NeumorphicStyle(
        color: Colors.transparent,
        depth: -.2.h,
        shadowLightColorEmboss: Colors.white70,
        shadowDarkColorEmboss: Colors.black54,
        boxShape: NeumorphicBoxShape.rect(),
        surfaceIntensity: 1,
        intensity: .8,
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 7.h,
            padding: EdgeInsets.symmetric(vertical: 1.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: ListView.builder(
// shrinkWrap: true,

              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                print("tabheader ${index == widget.selectedIndex}");
                var object = list.elementAt(index);
                if (index == widget.selectedIndex) {}
                return NeumorphicButton(
                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: .7.h),
                  padding: EdgeInsets.only(
                      top: 2.sp, bottom: 2.sp, left: 12.sp, right: 12.sp),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      color: widget.selectedIndex == index
                          ? Colors.indigo
                          : Colors.blue,
                      boxShape: NeumorphicBoxShape.stadium(),
                      depth: .2.h,
                      surfaceIntensity: .3,
                      intensity: .9),
                  child: Align(
                      alignment: Alignment.center,
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.all_inclusive, color: Colors.white),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "${object.categoryName}",
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ])),
                  onPressed: () {
                    setState(() {
                      // widget.selectedIndex;
                      var param = passParameterTabHeaderListCategory(
                          index: index,
                          value: list.elementAt(index).categoryName);
                      widget.selectedCategoryName(param);
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
