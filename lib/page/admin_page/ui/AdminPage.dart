import 'dart:async';
import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/admin_page/ui/ShowDetailStore.dart';
import 'package:bekal/page/main_content/ui/my_store/detail_pesanan.dart';
import 'package:bekal/page/main_content/ui/profile/store/DashboardStore.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  // List<StoreAdminPage> listAllStore = [];
  HomeAdmin _responseFromApi = HomeAdmin();
  List<FiturMenuAdmin> listFiturMenuAdmin = [];
  var listStoreHistoryDisbursement = [];
  bool isGetDataDone = false;
  bool isLoadingGetRequestPayout = true;
  String isTab = "listAll";
  int periodicCheckComplaint = 0;
  var complaintBroadCast = StreamController<dynamic>.broadcast();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFromApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButton: buildFloatingActionBubble(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: SafeArea(
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
                                  style: NeumorphicStyle(color: Colors.transparent),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        color: Color(0xfff39200),
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                                        child: Text(
                                          "TOTAL TOKO",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                                        child: Text(
                                          "${_responseFromApi.totalStore}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                  style: NeumorphicStyle(color: Colors.transparent),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        color: Color(0xfff39200),
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                                        child: Text(
                                          "TOTAL USER",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                                        child: Text(
                                          "${_responseFromApi.totalUser}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                  style: NeumorphicStyle(color: Colors.transparent),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        color: Color(0xfff39200),
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                                        child: Text(
                                          "TOTAL TRANSAKSI",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                                        child: Text(
                                          "${_responseFromApi.totalTransaksiAll}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                  style: NeumorphicStyle(color: Colors.transparent),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        color: Color(0xfff39200),
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                                        child: Text(
                                          "TOTAL TRANSAKSI DONE",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                                        child: Text(
                                          "${_responseFromApi.totalTransaksiDone}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                  style: NeumorphicStyle(color: Colors.transparent),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        color: Color(0xfff39200),
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                                        child: Text(
                                          "TOTAL TRANSAKSI PENDING",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                                        child: Text(
                                          "${_responseFromApi.totalTransaksiPending}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                              style: NeumorphicStyle(depth: 1, color: Colors.transparent),
                              child: Column(
                                children: [
                                  Container(
                                      width: 100.w,
                                      alignment: Alignment.topLeft,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Store yang terdaftar",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showMaterialModalBottomSheet(
                                                  context: context,
                                                  enableDrag: false,
                                                  builder: (builder) {
                                                    return Scaffold(
                                                      body: SafeArea(
                                                          child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(builder);
                                                                  },
                                                                  child: Icon(Icons.arrow_back_ios),
                                                                ),
                                                                Expanded(
                                                                    child: Center(
                                                                  child: Text("Semua Toko Yang Terdaftar"),
                                                                ))
                                                              ],
                                                            ),
                                                            Expanded(
                                                                child: ListView.builder(
                                                                    shrinkWrap: true,
                                                                    itemCount: _responseFromApi.listAllStore.length,
                                                                    itemBuilder: (context, index) {
                                                                      var dataStore = _responseFromApi.listAllStore[index];
                                                                      // print(dataStore);

                                                                      return NeumorphicButton(
                                                                        onPressed: () {
                                                                          showMaterialModalBottomSheet(
                                                                              duration: Duration(milliseconds: 1400),
                                                                              animationCurve: Curves.easeInOut,
                                                                              enableDrag: true,
                                                                              backgroundColor: Colors.transparent,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return ShowDetailStore(idStore: dataStore.idStore);
                                                                              });
                                                                        },
                                                                        padding: EdgeInsets.all(0),
                                                                        margin: EdgeInsets.symmetric(vertical: 1.2.h),
                                                                        style: NeumorphicStyle(
                                                                          depth: 2,
                                                                          color: Colors.white,
                                                                        ),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xfff39200).withOpacity(.2), Color(0xfff39200).withOpacity(.4)], stops: [.2, .7]),
                                                                          ),
                                                                          width: 100.w,
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.w),
                                                                                height: 10.w,
                                                                                width: 10.w,
                                                                                child: Neumorphic(
                                                                                  style: NeumorphicStyle(depth: -2, boxShape: NeumorphicBoxShape.circle()),
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: dataStore.storeImageUri,
                                                                                    fit: BoxFit.cover,
                                                                                    placeholder: (context, url) => Center(
                                                                                      child: SizedBox(
                                                                                        width: 40.0,
                                                                                        height: 40.0,
                                                                                        child: new CircularProgressIndicator(
                                                                                          color: Colors.orange,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                                                    }))
                                                          ],
                                                        ),
                                                      )),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.open_in_full_rounded,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: _responseFromApi.listAllStore.length > 5 ? 5 : _responseFromApi.listAllStore.length,
                                          itemBuilder: (context, index) {
                                            var dataStore = _responseFromApi.listAllStore[index];
                                            // print(dataStore);

                                            return NeumorphicButton(
                                              onPressed: () {
                                                showMaterialModalBottomSheet(
                                                    duration: Duration(milliseconds: 1400),
                                                    animationCurve: Curves.easeInOut,
                                                    enableDrag: true,
                                                    backgroundColor: Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return ShowDetailStore(idStore: dataStore.idStore);
                                                    });
                                              },
                                              padding: EdgeInsets.all(0),
                                              margin: EdgeInsets.symmetric(vertical: .5.h),
                                              style: NeumorphicStyle(
                                                depth: 2,
                                                color: Colors.white,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xfff39200).withOpacity(.2), Color(0xfff39200).withOpacity(.4)], stops: [.2, .7]),
                                                ),
                                                width: 100.w,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.w),
                                                      height: 10.w,
                                                      width: 10.w,
                                                      child: Neumorphic(
                                                        style: NeumorphicStyle(depth: -2, boxShape: NeumorphicBoxShape.circle()),
                                                        child: CachedNetworkImage(
                                                          imageUrl: dataStore.storeImageUri,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) => Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child: new CircularProgressIndicator(
                                                                color: Colors.orange,
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                          }))
                                ],
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(depth: 1, color: Colors.transparent),
                              child: Column(
                                children: [
                                  Container(
                                      width: 100.w,
                                      alignment: Alignment.topLeft,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Store Request Bantuan",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  complaintBroadCast.add(await checkComplaint());
                                                },
                                                child: Icon(
                                                  Icons.refresh,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  complaintBroadCast.add(await checkComplaint());
                                                  showMaterialModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return Scaffold(
                                                          body: SafeArea(
                                                              child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        Navigator.pop(builder);
                                                                      },
                                                                      child: Icon(Icons.arrow_back_ios),
                                                                    ),
                                                                    Expanded(
                                                                        child: Center(
                                                                      child: Text("Semua Toko Yang Terdaftar"),
                                                                    ))
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder(
                                                                      future: checkComplaint(),
                                                                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                                                        // var res = checkComplaint();
                                                                        // print(res['code']);
                                                                        var complaintList = snapshot.requireData["data"] as List;
                                                                        return ListView.builder(
                                                                            shrinkWrap: true,
                                                                            physics: NeverScrollableScrollPhysics(),
                                                                            itemCount: complaintList.length,
                                                                            itemBuilder: (context, index) {
                                                                              var obj = complaintList[index];
                                                                              return Neumorphic(
                                                                                margin: EdgeInsets.symmetric(vertical: 4),
                                                                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                                                                style: NeumorphicStyle(depth: 1),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Neumorphic(
                                                                                            style: NeumorphicStyle(depth: -2, boxShape: NeumorphicBoxShape.circle()),
                                                                                            child: Container(
                                                                                              width: 42,
                                                                                              height: 42,
                                                                                              child: FutureBuilder(
                                                                                                  future: DioClient().getAsync("/order/detail/${obj["complaint_ref_id"]}"),
                                                                                                  builder: (fBuilder, AsyncSnapshot<DioResponse> snapshotOrder) {
                                                                                                    var store = snapshotOrder.requireData.results["data"]["store"];
                                                                                                    return FutureBuilder(
                                                                                                        future: getDataStore(storeId: store["store_id"]),
                                                                                                        builder: (fBuilder, AsyncSnapshot<http.Response> snapshotOrder) {
                                                                                                          var detailStore = jsonDecode(snapshotOrder.requireData.body)['data'];
                                                                                                          return CachedNetworkImage(
                                                                                                            imageUrl: detailStore["storeImageUri"],
                                                                                                            fit: BoxFit.cover,
                                                                                                            placeholder: (context, url) => Center(
                                                                                                              child: SizedBox(
                                                                                                                width: 40.0,
                                                                                                                height: 40.0,
                                                                                                                child: new CircularProgressIndicator(
                                                                                                                  color: Colors.orange,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                                          );
                                                                                                        });
                                                                                                  }),
                                                                                            ),
                                                                                          ),
                                                                                          Text(obj["complaint_desc"])
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                            builder: (context) => DetailPesanan(
                                                                                              orderId: obj["complaint_ref_id"],
                                                                                              complaintId: obj["complaint_id"],
                                                                                            ),
                                                                                          ),
                                                                                        ).then((Object? obj) {});
                                                                                      },
                                                                                      child: Icon(Icons.open_in_new),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            });
                                                                      }),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                        );
                                                      });
                                                },
                                                child: Icon(
                                                  Icons.open_in_full_rounded,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                    child: StreamBuilder(
                                        stream: complaintBroadCast.stream,
                                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                          // var res = checkComplaint();
                                          // print(res['code']);
                                          var complaintList = snapshot.requireData["data"] as List;
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: complaintList.length > 2 ? 3 : complaintList.length,
                                              itemBuilder: (context, index) {
                                                var obj = complaintList[index];
                                                return Neumorphic(
                                                  margin: EdgeInsets.symmetric(vertical: 4),
                                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                                  style: NeumorphicStyle(depth: 1),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Neumorphic(
                                                              style: NeumorphicStyle(depth: -2, boxShape: NeumorphicBoxShape.circle()),
                                                              child: Container(
                                                                width: 42,
                                                                height: 42,
                                                                child: FutureBuilder(
                                                                    future: DioClient().getAsync("/order/detail/${obj["complaint_ref_id"]}"),
                                                                    builder: (fBuilder, AsyncSnapshot<DioResponse> snapshotOrder) {
                                                                      var store = snapshotOrder.requireData.results["data"]["store"];
                                                                      return FutureBuilder(
                                                                          future: getDataStore(storeId: store["store_id"]),
                                                                          builder: (fBuilder, AsyncSnapshot<http.Response> snapshotOrder) {
                                                                            var detailStore = jsonDecode(snapshotOrder.requireData.body)['data'];
                                                                            return CachedNetworkImage(
                                                                              imageUrl: detailStore["storeImageUri"],
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) => Center(
                                                                                child: SizedBox(
                                                                                  width: 40.0,
                                                                                  height: 40.0,
                                                                                  child: new CircularProgressIndicator(
                                                                                    color: Colors.orange,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                            );
                                                                          });
                                                                    }),
                                                              ),
                                                            ),
                                                            Text(obj["complaint_desc"])
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => DetailPesanan(orderId: obj["complaint_ref_id"], complaintId: obj["complaint_id"]),
                                                            ),
                                                          ).then((Object? obj) async {
                                                            complaintBroadCast.sink.add(await checkComplaint());
                                                          });
                                                        },
                                                        child: Icon(Icons.open_in_new),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(depth: 1, color: Colors.transparent),
                              child: Column(
                                children: [
                                  Container(
                                      width: 100.w,
                                      alignment: Alignment.topLeft,
                                      color: Color(0xfff39200),
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Request Penarikan Dana",
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await getRequestPayout();
                                                },
                                                child: Icon(
                                                  Icons.refresh,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showMaterialModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return Scaffold(
                                                          body: SafeArea(
                                                              child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        Navigator.pop(builder);
                                                                      },
                                                                      child: Icon(Icons.arrow_back_ios),
                                                                    ),
                                                                    Expanded(
                                                                        child: Center(
                                                                      child: Text("Semua Toko Yang Terdaftar"),
                                                                    ))
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        itemCount: _responseFromApi.listAllStore.length,
                                                                        itemBuilder: (context, index) {
                                                                          var dataStore = _responseFromApi.listAllStore[index];
                                                                          // print(dataStore);

                                                                          return NeumorphicButton(
                                                                            onPressed: () {
                                                                              showMaterialModalBottomSheet(
                                                                                  duration: Duration(milliseconds: 1400),
                                                                                  animationCurve: Curves.easeInOut,
                                                                                  enableDrag: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return ShowDetailStore(idStore: dataStore.idStore);
                                                                                  });
                                                                            },
                                                                            padding: EdgeInsets.all(0),
                                                                            margin: EdgeInsets.symmetric(vertical: 1.2.h),
                                                                            style: NeumorphicStyle(
                                                                              depth: 2,
                                                                              color: Colors.white,
                                                                            ),
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xfff39200).withOpacity(.2), Color(0xfff39200).withOpacity(.4)], stops: [.2, .7]),
                                                                              ),
                                                                              width: 100.w,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.w),
                                                                                    height: 10.w,
                                                                                    width: 10.w,
                                                                                    child: Neumorphic(
                                                                                      style: NeumorphicStyle(depth: -2, boxShape: NeumorphicBoxShape.circle()),
                                                                                      child: CachedNetworkImage(
                                                                                        imageUrl: dataStore.storeImageUri,
                                                                                        fit: BoxFit.cover,
                                                                                        placeholder: (context, url) => Center(
                                                                                          child: SizedBox(
                                                                                            width: 40.0,
                                                                                            height: 40.0,
                                                                                            child: new CircularProgressIndicator(
                                                                                              color: Colors.orange,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                                                        }))
                                                              ],
                                                            ),
                                                          )),
                                                        );
                                                      });
                                                },
                                                child: Icon(
                                                  Icons.open_in_full_rounded,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  ContainerHistoryRequestPayout()
                                ],
                              ),
                            ),
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
      ),
    );
  }

  // var streamGetListComplaint = checkComplaint().;
  dynamic checkComplaint() async {
    var payload = {"is_open": "0"};
    DioResponse res = await DioClient().postAsync("/complaint/list", payload);
    return res.results;
  }

  FloatingActionBubble buildFloatingActionBubble() {
    var _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    var _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    return FloatingActionBubble(
      items: [
        Bubble(
          title: "Lihat Semua Toko",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.store_rounded,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            setState(() {
              isTab = "listStore";
              isLoadingGetRequestPayout = true;
            });
          },
        ),
        Bubble(
          title: "Konfirmasi Penarikan Dana",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.store_rounded,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            setState(() {
              isTab = "reqPayout";
              isLoadingGetRequestPayout = true;
            });
            getRequestPayout();
          },
        )
      ],
      iconData: Icons.list_alt,
      iconColor: Colors.white,
      backGroundColor: Colors.blue,
      animation: _animation,
      onPress: () => _animationController.isCompleted ? _animationController.reverse() : _animationController.forward(),
    );
  }

  String maskCardNumber(String cardNumber, String mask) {
    // format the number
    String newString = '';
    for (int i = 0; i < cardNumber.length; i++) {
      if (cardNumber.length > 6) {
        if (i > 1 && (i < cardNumber.length - 2)) {
          newString += mask;
        } else {
          newString += cardNumber[i];
        }
      } else {
        newString += cardNumber[i];
      }
    }

    // return the masked number
    return newString;
  }

  Widget ContainerHistoryRequestPayout() {
    return listStoreHistoryDisbursement.length < 1
        ? Center(
            child: Text('Tidak Memiliki Request Penarikan Dana'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listStoreHistoryDisbursement.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.2.w),
                child: Neumorphic(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.2.w),
                  style: NeumorphicStyle(boxShape: NeumorphicBoxShape.rect(), color: Colors.deepOrangeAccent.withOpacity(.2), depth: 2, intensity: 1, surfaceIntensity: 1),
                  child: Row(
                    children: [
                      // Container(
                      //   width: 10.w,
                      //   child: Image.asset(
                      //     'assets/icon_bca.png',
                      //     fit: BoxFit.fitWidth,
                      //   ),
                      // ),
                      // Container(child: NeumorphicText,)
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${NumberFormat.simpleCurrency(locale: "IDR", decimalDigits: 0).format(listStoreHistoryDisbursement[index]['amount'] ?? 0)}',
                              style: TextStyle(color: Colors.redAccent, fontSize: 12.sp, fontWeight: FontWeight.bold, letterSpacing: 1.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              maskCardNumber("${listStoreHistoryDisbursement[index]['accountNumber']}", '#'),
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, letterSpacing: 1.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'A/N: ${listStoreHistoryDisbursement[index]['accountHolderName']}',
                              style: TextStyle(fontSize: 10.sp, letterSpacing: 1.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Bank / E-wallet: (${listStoreHistoryDisbursement[index]['bankCode']})',
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Status: (${listStoreHistoryDisbursement[index]['status']})',
                              style: TextStyle(fontSize: 10.sp, color: Colors.purple),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: this.context,
                              builder: (context) => AlertDialog(
                                title: const Text('Apakah Anda Yakin Menyetujui Penarikan Dana?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoadingGetRequestPayout = true;
                                      });
                                      var idReqDisbursement = listStoreHistoryDisbursement[index]['id'] ?? -1;

                                      if (await adminApproved(idRequestDisbursement: idReqDisbursement)) {
                                        getRequestPayout();
                                        Navigator.of(context).pop(true);
                                      }
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              NeumorphicIcon(
                                Icons.check,
                                size: 7.5.w,
                                style: NeumorphicStyle(color: Colors.green, depth: 2, intensity: 1, surfaceIntensity: 1),
                              ),
                              Text(
                                'Setujui\nPermintaan',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Future<void> getFromApi() async {
    List<StoreAdminPage> localListAllStore = [];
    HomeAdmin localResponse = HomeAdmin();
    var getAllStore = await http.get(Uri.parse('https://api.belanjakalimantanutara.com/api/admin/all/store'),
        // Uri.parse('http://localhost:3000/api/admin/all/store'),

        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${await SecureStorage().getToken()}'});
    if (getAllStore.statusCode == 200) {
      var bodyResponse = json.decode(getAllStore.body);
      if (bodyResponse['data'] != null) {
        localResponse = HomeAdmin.fromJson(bodyResponse['data']);
        // print(localResponse.totalStore);
      }
    }

    setState(() {
      _responseFromApi = localResponse;
      isGetDataDone = true;
    });
    complaintBroadCast.add(await checkComplaint());
  }

  Future<void> getRequestPayout() async {
    var getBankAccounts = await http.get(Uri.parse("${DioClient.ipServer}/api/admin/get-all/request-payout"), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${await SecureStorage().getToken()}'});
    print(jsonDecode(getBankAccounts.body));
    var localListStoreHistoryDisbursement = [];
    if (getBankAccounts.statusCode == 200) {
      if (jsonDecode(getBankAccounts.body)['data'] != null) {
        localListStoreHistoryDisbursement = jsonDecode(getBankAccounts.body)['data'];
      }
    }

    listStoreHistoryDisbursement.clear();
    setState(() {
      isLoadingGetRequestPayout = false;
      listStoreHistoryDisbursement = localListStoreHistoryDisbursement;
    });
  }

  Future<bool> adminApproved({int? idRequestDisbursement}) async {
    var idReqDisbursement = idRequestDisbursement != null ? idRequestDisbursement : -1;
    http.Response adminApprovedResponse = await http.get(Uri.parse("${DioClient.ipServer}/api/admin/aprove/request-payout/${idReqDisbursement}"), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${await SecureStorage().getToken()}'});
    var result = false;
    // print('xnd:::: ${adminApprovedResponse.request}');
    if (adminApprovedResponse.statusCode == 200) {
      if (jsonDecode(adminApprovedResponse.body)['data'] != null) {
        if (jsonDecode(adminApprovedResponse.body)['data']['isSukses']) {
          Toaster(context).showSuccessToast(jsonDecode(adminApprovedResponse.body)['data']['message'].toString(), gravity: ToastGravity.CENTER);
          result = true;
        }
      }
    }
    return result;
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
    FromJson.listAllStore = (json['listAllStore'] as List<dynamic>).map((e) => StoreAdminPage.fromJson(e as Map<String, dynamic>)).toList();

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
