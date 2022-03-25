import 'dart:math' as math;

import 'package:bekal/page/main_content/cubit/home_screen_cubit.dart';
import 'package:bekal/page/main_content/ui/ViewProduct.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseHomeSeeAllProduct.dart';
import 'package:bekal/payload/response/PayloadResponseStoreProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class SearchProductAndStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchProductAndStoreState();
  }
}

class SearchProductAndStoreState extends State<SearchProductAndStore> {
  bool isLoading = true;

  late PayloadResponseHomeSeeAllProduct dataAllProduct;
  List<PayloadResponseStoreProduct> renderListDataAllProduct = [];
  bool searchProduk = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllProductAndStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 3.h),
          child: TextField(
            onSubmitted: (value) {
              _searchResult(value: value);
            },
            onChanged: (value) {
              _searchResult(value: value);
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                hintText: "search", prefixIcon: Icon(Icons.search_rounded)),
            style: TextStyle(
                fontFamily: 'ghotic',
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : LoadingOverlay(
              isLoading: isLoading,
              color: Colors.black38,
              opacity: .3,
              child: Container(
                child: searchProduk && renderListDataAllProduct.length < 1
                    ? Center(
                        child: Text(
                          "Produk Tidak Ditemukan",
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : searchProduk && renderListDataAllProduct.length > 0
                        ? ListView.builder(
                            itemCount: renderListDataAllProduct.length,
                            itemBuilder: (context, index) {
                              var dataObject = renderListDataAllProduct[index];
                              return Neumorphic(
                                margin: EdgeInsets.symmetric(vertical: .5.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: .5.h, horizontal: 1.w),
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Neumorphic(
                                            style: NeumorphicStyle(
                                                color: Colors.transparent,
                                                depth: -1,
                                                intensity: 1,
                                                surfaceIntensity: 1,
                                                boxShape: NeumorphicBoxShape
                                                    .circle()),
                                            child: Container(
                                              width: 15.w,
                                              height: 15.w,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${dataObject.uriThumbnail}?dummy=${math.Random().nextInt(999)}',
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Icon(
                                                    Icons.person,
                                                    color: Colors.black,
                                                  );
                                                },
                                                progressIndicatorBuilder:
                                                    (context, widget, error) {
                                                  return CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  );
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "${dataObject.nameProduct} -",
                                                    style: TextStyle(
                                                        color: Colors.black87)),
                                                TextSpan(
                                                    text:
                                                        " ${dataObject.store.storeName} ",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: .6.w,
                                            ),
                                            Neumorphic(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 1.w),
                                              style: NeumorphicStyle(
                                                depth: -1,
                                                intensity: 1,
                                                surfaceIntensity: 1,
                                                color: (int.tryParse(dataObject
                                                                .stockProduct) ??
                                                            0) >
                                                        0
                                                    ? Colors.greenAccent
                                                    : Colors.red,
                                              ),
                                              child: Text(
                                                "${(int.tryParse(dataObject.stockProduct) ?? 0) > 0 ? "Stock Tersedia" : "Stock Habis"}",
                                                style: TextStyle(
                                                    fontFamily: 'ghotic',
                                                    fontSize: 5.5.sp,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                                    GestureDetector(
                                      onTap: () {
                                        showMaterialModalBottomSheet(
                                            duration:
                                                Duration(milliseconds: 1400),
                                            animationCurve: Curves.easeInOut,
                                            enableDrag: true,
                                            isDismissible: false,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return ViewProduct(
                                                  idStore:
                                                      dataObject.store.storeID,
                                                  dataDetailProduct: null,
                                                  idProduct:
                                                      dataObject.storeProdId);
                                            });
                                      },
                                      child: NeumorphicIcon(
                                        Icons.open_in_new,
                                        style: NeumorphicStyle(
                                          depth: 1,
                                          surfaceIntensity: 1,
                                          intensity: 1,
                                          color: Colors.grey,
                                        ),
                                        size: 7.w,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "Cari Produk",
                              style: TextStyle(
                                  fontFamily: 'ghotic',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
              ),
            ),
    );
  }

  Future<void> _getAllProductAndStore() async {
    PayloadResponseApi<dynamic> responseApi =
        await HomeScreenCubit().getHomeSeeAllProduct();
    var itemList;
    if (responseApi.errorMessage.isEmpty) {
      List<PayloadResponseHomeSeeAllProduct> list = responseApi.data;
      itemList = list
          .where((element) => element.titleTab.toLowerCase().contains("semua"))
          .single;
    }
    setState(() {
      dataAllProduct = itemList;
      // renderListDataAllProduct = dataAllProduct.viewListStoreProductResponse;
      isLoading = false;
    });
  }

  void _searchResult({required String value}) {
    List<PayloadResponseStoreProduct> searchResultData = [];
    // searchResultData.clear();
    // dataAllProduct.viewListStoreProductResponse.retainWhere(
    //         (element) => (element.nameProduct.toLowerCase().contains("$value") ||
    //         element.store.storeName.toLowerCase().contains(value)));
    // dataAllProduct.viewListStoreProductResponse.asMap().forEach((key, item) {
    //   if (item.nameProduct.toLowerCase().contains(value.toLowerCase()) ||
    //       item.store.storeName.toLowerCase().contains(value.toLowerCase())) {
    //     searchResultData.add(item);
    //     print(item.nameProduct);
    //   }
    //   ;
    // });
    searchResultData.addAll(dataAllProduct.viewListStoreProductResponse);
    //
    searchResultData.retainWhere((element) =>
        (element.nameProduct.toLowerCase().contains("$value") ||
            element.store.storeName.toLowerCase().contains(value)));
    setState(() {
      searchProduk = true;
      renderListDataAllProduct = searchResultData;
    });
  }
}
