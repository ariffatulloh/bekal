import 'package:bekal/api/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  final String invoiceId;
  const PaymentScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final DioClient _dio = new DioClient();

  bool isGettingData = false;
  List stores = [];
  var invoice;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Pembayaran',
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor Invoice",
                    style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    invoice?["invoice_id"] ?? "",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Batas Akhir Pembayaran",
                    style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "20 Februari 2022 23.00 WIB",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
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
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${invoice?["bank_code"] ?? ""} Virtual Account",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  Text(
                    "Nomor Virtual Account",
                    style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          invoice?["account_number"] ?? "",
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: invoice?["account_number"] ?? ""));
                          Fluttertoast.showToast(
                            msg: "Nomor VA di copy",
                            gravity: ToastGravity.CENTER,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            children: [
                              Text(
                                "Salin",
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              SizedBox(width: 1.w),
                              Icon(
                                Icons.copy,
                                size: 12.sp,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Total Pembayaran",
                    style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "${currencyFormatter.format(invoice?["expected_amount"] ?? 0)}",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
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
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pembelanjaan",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  ..._itemProduct()
                ],
              ),
            ),
            Container(
              height: 1.h,
              decoration: BoxDecoration(color: Colors.black12),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
              child: Center(
                child: Text(
                  "Pesananmu baru diteruskan ke penjual setelah pembayaran terverifikasi",
                  style: TextStyle(
                    fontFamily: 'ghotic',
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  List<Widget> _itemProduct() {
    List<Widget> list = [];
    stores.forEach((item) {
      list.add(
        Card(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 1.h),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(4.w),
            child: Row(children: [
              Expanded(
                child: Text(
                  item["store_name"],
                  style: TextStyle(
                      fontFamily: 'ghotic',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Belanja",
                    style: TextStyle(fontFamily: 'ghotic', fontSize: 9.sp),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "${currencyFormatter.format(item["total_order"])}",
                    style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ]),
          ),
        ),
      );
    });

    return list;
  }

  _getData() async {
    setState(() {
      isGettingData = true;
    });
    try {
      DioResponse res =
          await _dio.getAsync("/payment/detail?invoice_id=${widget.invoiceId}");
      if (res.results["code"] == 200) {
        setState(() {
          stores = res.results["data"]["store"];
          invoice = res.results["data"]["invoice"];
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
