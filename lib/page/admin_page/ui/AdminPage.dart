import 'dart:convert';

import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> {
  // List<StoreAdminPage> listAllStore = [];
  HomeAdmin _responseFromApi = HomeAdmin();
  List<FiturMenuAdmin> listFiturMenuAdmin = [];
  bool isGetDataDone = false;
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
      child: Column(
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
              // height: 100.h,
              // width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: isGetDataDone
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Neumorphic(
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 2.h),
                                      child: Text(
                                        "TOTAL TOKO",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 3.h),
                                      child: Text(
                                        "${_responseFromApi.totalStore}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Neumorphic(
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 2.h),
                                      child: Text(
                                        "TOTAL USER",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 3.h),
                                      child: Text(
                                        "${_responseFromApi.totalUser}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  child: Neumorphic(
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 2.h),
                                      child: Text(
                                        "TOTAL TRANSAKSI",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 3.h),
                                      child: Text(
                                        "${_responseFromApi.totalTransaksiAll}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Neumorphic(
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 2.h),
                                      child: Text(
                                        "TOTAL TRANSAKSI DONE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 3.h),
                                      child: Text(
                                        "${_responseFromApi.totalTransaksiDone}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  child: Neumorphic(
                                style:
                                    NeumorphicStyle(color: Colors.transparent),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 2.h),
                                      child: Text(
                                        "TOTAL TRANSAKSI PENDING",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.w, vertical: 3.h),
                                      child: Text(
                                        "${_responseFromApi.totalTransaksiPending}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(color: Colors.white),
                            child: Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 3.w),
                              child: Wrap(
                                children: getMenuFiturAdmin(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _responseFromApi.listAllStore.length,
                              itemBuilder: (context, index) {
                                var dataStore =
                                    _responseFromApi.listAllStore[index];
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
                                                boxShape: NeumorphicBoxShape
                                                    .circle()),
                                            child: CachedNetworkImage(
                                              imageUrl: dataStore.storeImageUri,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: SizedBox(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  child:
                                                      new CircularProgressIndicator(
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            dataStore.storeName,
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                // fontWeight: FontWeight.semi,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: 'ghotic',
                                                color: Colors.black87),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {},
                                        //   child: NeumorphicIcon(
                                        //     Icons.open_in_new,
                                        //     size: 7.5.w,
                                        //     style: NeumorphicStyle(
                                        //         color: Colors.black87, depth: 3),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 1.5.w,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getFromApi() async {
    List<StoreAdminPage> localListAllStore = [];
    HomeAdmin localResponse = HomeAdmin();
    var getAllStore = await http.get(
        Uri.parse('http://51.79.251.50:3000/api/admin/all/store'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    if (getAllStore.statusCode == 200) {
      var bodyResponse = json.decode(getAllStore.body);
      if (bodyResponse['data'] != null) {
        localResponse = HomeAdmin.fromJson(bodyResponse['data']);
        print(localResponse.totalStore);
      }
    }

    setState(() {
      _responseFromApi = localResponse;
      isGetDataDone = true;
    });
  }

  List<Widget> getMenuFiturAdmin() {
    return [
      NeumorphicButton(
        onPressed: () {},
        style: NeumorphicStyle(color: Colors.blue, depth: 2),
        child: Text("Daftar Semua Toko", style: TextStyle(color: Colors.white)),
      ),
      SizedBox(
        width: 1.w,
      ),
      NeumorphicButton(
        onPressed: () {},
        style: NeumorphicStyle(color: Colors.blue, depth: 2),
        child: Text(
          "Daftar Penarikan Dana",
          style: TextStyle(color: Colors.white),
        ),
      )
    ];
  }
}

class FiturMenuAdmin {
  var string = 0;
  var storeName = "no-name";
  var storeImage = "http://";
}

class HomeAdmin {
  HomeAdmin();
  var totalTransaksiPending = 0;
  var totalTransaksiDone = 0;
  var totalTransaksiAll = 0;
  var totalStore = 0;
  var totalUser = 0;
  var listAllStore = [];
  factory HomeAdmin.fromJson(dynamic json) {
    HomeAdmin FromJson = HomeAdmin();
    FromJson.totalTransaksiPending = json['totalTransaksiPending'] as int;
    FromJson.totalTransaksiDone = json['totalTransaksiDone'] as int;
    FromJson.totalTransaksiAll = json['totalTransaksiAll'] as int;
    FromJson.totalStore = json['totalStore'] as int;
    FromJson.totalUser = json['totalUser'] as int;
    FromJson.listAllStore = (json['listAllStore'] as List<dynamic>)
        .map((e) => StoreAdminPage.fromJson(e as Map<String, dynamic>))
        .toList();

    return FromJson;
  }
}

class StoreAdminPage {
  StoreAdminPage();
  var idStore = 0;
  var storeName = "no-name";
  var storeImageUri = "http://";
  factory StoreAdminPage.fromJson(dynamic json) {
    StoreAdminPage FromJson = StoreAdminPage();
    FromJson.idStore = json['idStore'] as int;
    FromJson.storeName = json['storeName'] as String;
    FromJson.storeImageUri = json['storeImageUri'] as String;

    return FromJson;
  }
}
