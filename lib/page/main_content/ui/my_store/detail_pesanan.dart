import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/common/input_field.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
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
                            format: "dd MMMM yyyy, hh:mm WIB"),
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
                        "${order?["courier_desc"] ?? "-"} (${order?["rate_name"] ?? "-"})",
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
                        "${order?["delivery_destination"] ?? "-"}",
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Alamat Pengiriman",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${order?["delivery_destination"] ?? "-"}",
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
                      if (_showResi) SizedBox(height: 2.h),
                      if (_showResi)
                        Text(
                          "Nomor Resi",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                      SizedBox(height: 1.h),
                      if (noresi != "" &&
                          !["ORD08", "ORD04"].contains(status?["id"]))
                        Text(
                          noresi,
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      if (["ORD08", "ORD04"].contains(status?["id"]))
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextInput(
                                    hintText: "Masukkan Nomor Resi",
                                    value: noresi,
                                    keyboardType: TextInputType.text,
                                    borderRadius: 5.0,
                                    onChanged: (v) {
                                      setState(() {
                                        noresi = v ?? "";
                                      });
                                    }),
                              ),
                              SizedBox(width: 2.w),
                              InkWell(
                                onTap: () {
                                  if (noresi == "") {
                                    Toaster(context).showErrorToast(
                                        "Nomor Resi tidak boleh kosong",
                                        gravity: ToastGravity.CENTER);
                                  } else {
                                    _updateResi();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 17),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.orange),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Update",
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
                        ),
                      SizedBox(height: _showResi ? 1.h : 0),
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
                            "BCA Virtual Account",
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
    return (["ORD08", "ORD04"].contains(status?["id"]) || noresi != "")
        ? true
        : false;
  }

  _terimaPesanan() async {
    setState(() {
      isGettingData = true;
    });

    var payload = {
      "order_id": widget.orderId,
      "status": "ORD04",
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
        Toaster(context).showSuccessToast("Pesanan berhasil di tolak",
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
        setState(() {
          order = res.results["data"]["order"];
          store = res.results["data"]["store"];
          status = res.results["data"]["status"];
          products = res.results["data"]["product"];
          invoice = res.results["data"]["invoice"];
          noresi = order?["delivery_no"] ?? "";
        });
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isGettingData = false;
    });
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
