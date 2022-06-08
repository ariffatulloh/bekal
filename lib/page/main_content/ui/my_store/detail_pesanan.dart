import 'dart:convert';

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/input_field.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:collection/collection.dart";
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class DetailPesanan extends StatefulWidget {
  final String orderId;
  const DetailPesanan({Key? key, required this.orderId}) : super(key: key);

  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final DioClient _dio = new DioClient();

  bool isGettingData = false;
  var order;
  var store;
  var status;
  var invoice;
  dynamic? buyer;
  String noresi = "";
  List products = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Detail Transaksi',
            style: TextStyle(
                fontFamily: 'ghotic',
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          leading: BackButton(
            color: Colors.black87,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: LoadingOverlay(
          isLoading: isGettingData,
          color: Colors.black38,
          opacity: .3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.black26,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                  child: Text(
                    status?["status_name"] ?? "",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5.w, 4.w, 5.w, 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal Transaksi",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        formatDate(context, order?["createdAt"],
                            format: "dd MMMM yyyy, hh:mm aa (WIB)"),
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 1.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detail Produk",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      ..._itemProduct(),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
                Container(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi Pembeli",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        "Nama Pembeli",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${buyer?['buyerName'] ?? ""}",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Nomor Telepon",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${buyer?['buyerPhone'] ?? "-"}",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Alamat Pembeli",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${order?["delivery_origin"] ?? "-"}",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Kurir",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${order?["courier_desc"] ?? "-"} (${order?["rate_name"] ?? "-"})",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      // if (_showResi) SizedBox(height: 2.h),
                      // if (_showResi)
                      //   Text(
                      //     "Nomor Resi",
                      //     style:
                      //         TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      //   ),
                      // SizedBox(height: 1.h),
                      // if (noresi != "" &&
                      //     !["ORD08", "ORD04"].contains(status?["id"]))
                      //   Text(
                      //     noresi,
                      //     style: TextStyle(
                      //         fontFamily: 'ghotic',
                      //         fontSize: 11.sp,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      Visibility(
                        visible: !["ORD01", "ORD02", "ORD03"]
                            .contains(order?["status"]["id"]),
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h),
                            Text(
                              "Nomor Resi",
                              style: TextStyle(
                                  fontFamily: 'ghotic', fontSize: 10.sp),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextInput(
                                      hintText: noresi,
                                      value: noresi,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      borderRadius: 5.0,
                                      onChanged: (v) {
                                        // setState(() {
                                        //   noresi = v ?? "";
                                        // });
                                      }),
                                ),
                                SizedBox(width: 2.w),
                                Visibility(
                                  visible:
                                      order?["delivery_pickup_code"] == null,
                                  child: InkWell(
                                    onTap: () async {
                                      if (noresi == "") {
                                        Toaster(context).showErrorToast(
                                            "Nomor Resi tidak boleh kosong",
                                            gravity: ToastGravity.CENTER);
                                      } else {
                                        // _updateResi();
                                        _reqPenjemputan(noresi);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 17),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.orange),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Req. Penjemputan",
                                            style: TextStyle(
                                                fontFamily: 'ghotic',
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      order?["delivery_pickup_code"] != null,
                                  child: InkWell(
                                    onTap: () async {
                                      if (noresi == "") {
                                        Toaster(context).showErrorToast(
                                            "Nomor Resi tidak boleh kosong",
                                            gravity: ToastGravity.CENTER);
                                      } else {
                                        // _updateResi();
                                        // _reqPenjemputan(noresi);
                                        showTrackingPaket();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 17),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.orange),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Lacak Barang",
                                            style: TextStyle(
                                                fontFamily: 'ghotic',
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 2.h)
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
                Container(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rincian Pembayaran",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Metode Pembayaran",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                          Text(
                            "${invoice?["bank_code"] ?? "-"}",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                          Text(
                            "${currencyFormatter.format(order?["order_total"] ?? 0)}",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ongkos Kirim",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                          Text(
                            "${currencyFormatter.format(order?["courier_cost"] ?? 0)}",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1.5.h),
                        height: 1,
                        decoration: BoxDecoration(color: Colors.black12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${currencyFormatter.format((order?["order_total"] ?? 0) + (order?["courier_cost"] ?? 0))}",
                            style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                if (status?["id"] == "ORD03")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return DialogTolakPesanan(
                                  orderId: widget.orderId,
                                  onSuccess: _getData,
                                );
                              });
                        },
                        child: Container(
                          width: 40.w,
                          height: 5.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.red,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tolak Pesanan",
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Konfirmasi"),
                                content: Text(
                                    "Apakah Anda akan menerima pesnan ini?"),
                                actions: [
                                  TextButton(
                                    child: Text("Tutup"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Terima Pesanan"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _terimaPesanan();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 40.w,
                          height: 5.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.green,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Terima Pesanan",
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _itemProduct() {
    List<Widget> list = [];
    products.forEach((item) {
      list.add(
        Card(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(2.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 15.w,
                      height: 15.w,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: item["uriThumbnail"],
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: new CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      width: 64.w,
                      height: 15.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item["nameProduct"],
                              style: TextStyle(
                                  fontFamily: 'ghotic',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            " ${item["stockProduct"]} x ${currencyFormatter.format((double.parse(item["priceProduct"])).toInt())}",
                            style: TextStyle(
                                fontFamily: 'ghotic', fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(2.5.w),
                width: 100.w,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black12,
                      width: .5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(fontFamily: 'ghotic', fontSize: 9.sp),
                    ),
                    Text(
                      "${currencyFormatter.format((double.parse(item["priceProduct"]) * int.parse(item["stockProduct"])))}",
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });

    return list;
  }

  bool get _showResi {
    return (noresi.isNotEmpty) ? true : false;
  }

  _terimaPesanan() async {
    setState(() {
      isGettingData = true;
    });

    var payload = {
      "order_id": widget.orderId,
      "status": "ORD04A",
      "delivery_no": "",
      "reason": ""
    };

    try {
      DioResponse res = await _dio.postAsync("/order/action", payload);
      if (res.results["code"] == 200) {
        Toaster(context).showSuccessToast("Pesanan berhasil diterima",
            gravity: ToastGravity.CENTER);
        _getData();
      }
    } catch (e) {
      print(e);

      setState(() {
        isGettingData = false;
      });
    }
  }

  _updateResi() async {
    setState(() {
      isGettingData = true;
    });

    var payload = {
      "order_id": widget.orderId,
      "status": "ORD08",
      "delivery_no": noresi,
      "reason": ""
    };

    try {
      DioResponse res = await _dio.postAsync("/order/action", payload);
      if (res.results["code"] == 200) {
        Toaster(context).showSuccessToast("Berhasil Update No Resi",
            gravity: ToastGravity.CENTER);
        _getData();
      }
    } catch (e) {
      print(e);

      setState(() {
        isGettingData = false;
      });
    }
  }

  _getData() async {
    setState(() {
      isGettingData = true;
    });
    try {
      DioResponse res = await _dio.getAsync("/order/detail/${widget.orderId}");
      if (res.results["code"] == 200) {
        print('noresi ${res.results["data"]["order"]["delivery_no"] ?? ""}');
        setState(() {
          order = res.results["data"]["order"];
          store = res.results["data"]["store"];
          status = res.results["data"]["status"];
          products = res.results["data"]["product"];
          invoice = res.results["data"]["invoice"];
          buyer = res.results["data"]["buyer"];
          noresi = res.results["data"]["order"]["delivery_no"] ?? "";
          isGettingData = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _reqPenjemputan(String noresi) async {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var responseGet = await http.get(
      Uri.parse("${DioClient.ipServer}/logistics/order/timeslot/$noresi"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage().getToken()}'
      },
    );
    List<dynamic> timeslot =
        jsonDecode(responseGet.body)["data"]["data"]["time_slots"] ?? [];
    List<Map<String, dynamic>> listAvailableTimeSlot = [];
    timeslot.forEach((element) {
      DateTime.parse(element["start_time"])
          .difference(DateTime.parse(element["end_time"]));
      var differenceMinutes = -DateTime.parse(element["start_time"])
          .difference(DateTime.parse(element["end_time"]))
          .inMinutes;
      for (int minutes = 0; minutes < differenceMinutes;) {
        minutes++;
        var setHour = 0;
        var setMinutes = 0;
        if (minutes % 30 == 0) {
          setMinutes += minutes;
          if (minutes % 60 == 0) {
            setHour++;
            setMinutes = 0;
          }
          var datetime = DateTime.parse(element["start_time"])
              .toLocal()
              .add(Duration(minutes: minutes));
          Map<String, dynamic> availableTimeSlot = Map<String, dynamic>();
          availableTimeSlot["date"] = datetime.day;
          availableTimeSlot["dateTime"] = datetime;
          listAvailableTimeSlot.add(availableTimeSlot);
          // print(
          //     "${datetime.day} ${datetime.toLocal().toIso8601String()}");
        }
      }
    });

    var slotAvailableTimesGroupByDate =
        groupBy(listAvailableTimeSlot, (Map element) {
      return element["date"];
    }).entries.toList();

    showMaterialModalBottomSheet(
      context: context,
      builder: (builder) {
        return ShowSchedulePenjemputan(
          listData: slotAvailableTimesGroupByDate,
          onSubmit: (selectedDateTime) async {
            print(selectedDateTime);
            // var getDateNow = DateTime.now().add(Duration(minutes: 10, seconds: 0));
            var payload = {
              "order_id": ['$noresi'],
              "pickup_time":
                  "${DateFormat("yyyy-MM-dd'T'HH:mm:ss", 'id').format(selectedDateTime)}${selectedDateTime.timeZoneOffset.isNegative ? '-' : '+'}${twoDigits(selectedDateTime.timeZoneOffset.inHours.abs())}:${twoDigits(selectedDateTime.timeZoneOffset.inMinutes.remainder(60).abs().toInt())}"
            };
            print(payload);
            var response = await http.post(
              Uri.parse("${DioClient.ipServer}/order/pickup"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await SecureStorage().getToken()}'
              },
              body: jsonEncode(payload),
            );
            //
            // print(jsonDecode(payload.toString()));
            print(
                "data response req pickup ::: ${jsonDecode(response.body)["data"]["metadata"]["http_status_code"]}");
            if (jsonDecode(response.body)["data"]["metadata"]
                    ["http_status_code"] ==
                200) {
              print(
                  "data response req pickup ::: ${jsonDecode(response.body)["data"]}");
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
            await _getData();
          },
        );
      },
    );

    // if (jsonDecode(response.body)['data'] != null &&
    //     jsonDecode(response.body)['data']['data'] != null) {
    //   await _getData();
    // }
  }

  void showTrackingPaket() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (builder) {
          return TrackingPaket(noResi: noresi);
        });
  }
}

class TrackingPaket extends StatelessWidget {
  TrackingPaket({required this.noResi});
  String noResi;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List?>(
        future: getDataFromApi(),
        builder: (builderCtx, asynSnapshot) {
          if (asynSnapshot.connectionState == ConnectionState.done) {
            if (asynSnapshot.data != null) {
              // print(asynSnapshot);
              return Container(
                width: 100.w,
                alignment: Alignment.topLeft,
                constraints: BoxConstraints(maxHeight: 50.h),
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NeumorphicText("Status Pengiriman",
                        style: NeumorphicStyle(
                            color: Colors.black54,
                            depth: 1,
                            intensity: 1,
                            surfaceIntensity: 1),
                        textAlign: TextAlign.left,
                        textStyle: NeumorphicTextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp)),
                    SizedBox(
                      height: 1.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: buildWidgetTracking(
                                  lisstData: asynSnapshot.data,
                                  builderContext: builderCtx) ??
                              [],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          return SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        });
  }

  Future<List?> getDataFromApi() async {
    var responsse = await http.get(
      Uri.parse(
        "${DioClient.ipServer}/logistics/order/detail/$noResi",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage().getToken()}'
      },
    );
    if (jsonEncode(responsse.body) != null) {
      if (jsonDecode(responsse.body)["data"] != null) {
        List? trackings =
            jsonDecode(responsse.body)["data"]["data"]["trackings"];

        if (trackings != null) {
          return trackings;
        }
      }
    }
    return null;
  }

  List<Widget>? buildWidgetTracking(
      {List? lisstData, required BuildContext builderContext}) {
    return lisstData?.reversed.map((e) {
      int index = lisstData.indexOf(e);
      print("$index ${lisstData.length}");
      return Column(
        children: [
          Row(
            children: [
              Neumorphic(
                padding: EdgeInsets.all(1.w),
                style: NeumorphicStyle(
                    color: index == (lisstData.length - 1)
                        ? Colors.white
                        : Colors.grey,
                    depth: 1.2,
                    intensity: 1,
                    surfaceIntensity: 1,
                    boxShape: NeumorphicBoxShape.circle()),
                child: Icon(
                  Icons.location_pin,
                  color: index == (lisstData.length - 1)
                      ? Colors.green
                      : Colors.white,
                  size: 6.5.w,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "${formatDate(builderContext, e?["created_date"], format: "dd MMMM yyyy, hh:mm aa (WIB)")}",
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.4.w),
            child: DottedBorder(
              strokeWidth: .5.w,
              color:
                  index == (lisstData.length - 1) ? Colors.green : Colors.grey,
              customPath: (size) {
                return Path()
                  ..moveTo(0, 0)
                  ..lineTo(0, size.height);
              },
              child: Container(
                width: 100.w,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                margin: EdgeInsets.only(left: 4.5.w),
                child: Column(
                  children: [
                    Text(
                      "${e?["shipper_status"]["name"]}",
                      style: TextStyle(fontSize: 10.sp),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }).toList();
  }
}

class ShowSchedulePenjemputan extends StatefulWidget {
  List<MapEntry<dynamic, List<Map<String, dynamic>>>> listData;
  Function(DateTime selectedDateTime)? onSubmit;
  ShowSchedulePenjemputan({required this.listData, this.onSubmit});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowSchedulePenjemputanState();
  }
}

class ShowSchedulePenjemputanState extends State<ShowSchedulePenjemputan> {
  int showChildByKey = 0;

  DateTime selectDateTime = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      width: 100.w,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeumorphicText(
              "Atur Waktu Penjemputan",
              style: NeumorphicStyle(
                  color: Colors.white.withOpacity(.6),
                  depth: 1.2,
                  intensity: 1,
                  surfaceIntensity: 1),
              textStyle: NeumorphicTextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text("Pilih Tanggal"),
            SizedBox(
              height: 1.h,
            ),
            Container(
              width: 100.w,
              child: SingleChildScrollView(
                child: Column(
                  children: widget.listData
                      .map(
                        (eParent) => Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NeumorphicButton(
                                  onPressed: () {
                                    setState(() {
                                      if (eParent.key.hashCode ==
                                          showChildByKey) {
                                        selectDateTime = DateTime(2000);
                                        showChildByKey = 0;
                                      } else {
                                        showChildByKey = eParent.key.hashCode;
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: .5.h, horizontal: 4.w),
                                  style: NeumorphicStyle(
                                      depth: 1, color: Colors.white),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.done_all,
                                        color: showChildByKey ==
                                                eParent.key.hashCode
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(eParent.key.toString())
                                    ],
                                  )),
                              Container(
                                width: 100.w,
                                child: Visibility(
                                  visible:
                                      showChildByKey == eParent.key.hashCode,
                                  child: Neumorphic(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.w),
                                    style: NeumorphicStyle(
                                        depth: -1, color: Colors.white),
                                    child: Container(
                                      child: Wrap(
                                        runSpacing: 1.h,
                                        spacing: 2.w,
                                        children: eParent.value.map(
                                          (eChildren) {
                                            return NeumorphicButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (selectDateTime ==
                                                        eChildren["dateTime"]) {
                                                      selectDateTime =
                                                          DateTime(2000);
                                                    } else {
                                                      selectDateTime =
                                                          eChildren["dateTime"];
                                                    }
                                                  });
                                                },
                                                padding: EdgeInsets.symmetric(
                                                    vertical: .5.h,
                                                    horizontal: 4.w),
                                                style: NeumorphicStyle(
                                                    depth: 1,
                                                    color: Colors.white),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.done_all,
                                                      color: selectDateTime ==
                                                              eChildren[
                                                                  "dateTime"]
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(DateFormat(
                                                            "HH:mm", "id")
                                                        .format(eChildren[
                                                            "dateTime"]))
                                                  ],
                                                ));
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: 100.w,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                      visible: selectDateTime != DateTime(2000),
                      child: NeumorphicButton(
                          onPressed: () {
                            widget.onSubmit != null
                                ? widget.onSubmit!(selectDateTime)
                                : null;
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          style:
                              NeumorphicStyle(depth: 1, color: Colors.orange),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delivery_dining,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                "Req.Penjemputan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )))
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}

class DialogTolakPesanan extends StatefulWidget {
  final String orderId;
  final Function onSuccess;
  const DialogTolakPesanan(
      {Key? key, required this.orderId, required this.onSuccess})
      : super(key: key);

  @override
  _DialogTolakPesananState createState() => new _DialogTolakPesananState();
}

class _DialogTolakPesananState extends State<DialogTolakPesanan> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final _formKey = GlobalKey<FormState>();
  DioClient _dio = new DioClient();
  bool isSaving = false;

  String reason = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 7.h,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Alasan Penolakan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tuliskan Alasan Penolakan Anda",
                                    style: TextStyle(
                                      fontFamily: 'ghotic',
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  TextInput(
                                      maxLines: 2,
                                      value: reason,
                                      keyboardType: TextInputType.text,
                                      borderRadius: 10.0,
                                      onChanged: (v) {
                                        setState(() {
                                          reason = v ?? "";
                                        });
                                      }),
                                ],
                              ),
                            ),
                            if (!isSaving)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.orange),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Batal",
                                            style: TextStyle(
                                                fontFamily: 'ghotic',
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          !isSaving) _submitConfirmation();
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.green,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontFamily: 'ghotic',
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (isSaving)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      "memroses penolakan...",
                                      style: TextStyle(
                                          fontFamily: 'ghotic',
                                          color: Colors.black87,
                                          fontSize: 11.sp,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ]),
                            SizedBox(height: 3.h)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submitConfirmation() async {
    setState(() {
      isSaving = true;
    });

    var payload = {
      "order_id": widget.orderId,
      "status": "ORD06",
      "delivery_no": "",
      "reason": reason
    };

    try {
      DioResponse res = await _dio.postAsync("/order/action", payload);
      if (res.results["code"] == 200) {
        Toaster(context).showSuccessToast("Pesanan berhasil di tolak",
            gravity: ToastGravity.CENTER);

        Navigator.of(context).pop();

        widget.onSuccess();
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isSaving = false;
    });
  }
}
