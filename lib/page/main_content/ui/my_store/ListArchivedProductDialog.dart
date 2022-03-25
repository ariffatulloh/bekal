import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/my_store/CreateProduct.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class ListArchivedProductDialog extends StatefulWidget {
  var storeId = 0;
  Function(bool) onDismiss;
  ListArchivedProductDialog({required this.storeId, required this.onDismiss});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListArchivedProductDialogState();
  }
}

class ListArchivedProductDialogState extends State<ListArchivedProductDialog> {
  List listProductInArchive = [];
  bool isgetFromApiDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: isgetFromApiDone
            ? Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: NeumorphicIcon(
                      Icons.arrow_drop_down_circle_sharp,
                      style: NeumorphicStyle(
                        depth: .2.h,
                        color: Colors.white,
                      ),
                      size: 10.w,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.4.h),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listProductInArchive.length,
                          itemBuilder: (context, index) {
                            var dataList = listProductInArchive[index];
                            return Neumorphic(
                              margin: EdgeInsets.symmetric(vertical: 1.2.h),
                              style: NeumorphicStyle(
                                depth: 2,
                                color: Colors.white,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xfff39200).withOpacity(.2),
                                        Color(0xfff39200).withOpacity(.4)
                                      ],
                                      stops: [
                                        .2,
                                        .7
                                      ]),
                                ),
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 1.5.w),
                                      height: 10.w,
                                      width: 10.w,
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                            depth: -2,
                                            boxShape:
                                                NeumorphicBoxShape.circle()),
                                        child: CachedNetworkImage(
                                          imageUrl: dataList['uriThumbnail']
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                            child: SizedBox(
                                              width: 40.0,
                                              height: 40.0,
                                              child:
                                                  new CircularProgressIndicator(
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        dataList['productName'],
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            // fontWeight: FontWeight.semi,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'ghotic',
                                            color: Colors.black87),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMaterialModalBottomSheet(
                                            duration:
                                                Duration(milliseconds: 1400),
                                            animationCurve: Curves.easeInOut,
                                            enableDrag: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return CreateProduct(
                                                idStore: widget.storeId,
                                                idProduct:
                                                    dataList['idProduct'],
                                                onDismiss: (isDismiss) {
                                                  widget.onDismiss(true);
                                                },
                                              );
                                            });
                                      },
                                      child: NeumorphicIcon(
                                        Icons.open_in_new,
                                        size: 7.5.w,
                                        style: NeumorphicStyle(
                                            color: Colors.black87, depth: 3),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.5.w,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ));
  }

  Future<void> getFromApi() async {
    var getProducts = await http.get(
        Uri.parse(
            '${DioClient.ipServer}/api/my/outlet/${widget.storeId}/archived-products'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    if (getProducts.statusCode == 200) {
      print(jsonDecode(getProducts.body)['data']);
      var responsseBody = jsonDecode(getProducts.body);
      if (responsseBody['data'] != null) {
        var listDataBody = responsseBody['data'] as List<dynamic>;
        listDataBody.forEach((element) {
          print('${element['productName']}');
        });
        setState(() {
          listProductInArchive = listDataBody;
          isgetFromApiDone = true;
        });
      }
    }
  }
}
