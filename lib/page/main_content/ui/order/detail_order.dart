import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class DetailOrder extends StatefulWidget {
  final String orderId;
  const DetailOrder({Key? key, required this.orderId}) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final DioClient _dio = new DioClient();

  bool isGettingData = false;
  var order;
  var store;
  var status;
  List products = [];

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
                    SizedBox(height: 2.h),
                    Text(
                      "Penjual",
                      style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      store?["store_name"] ?? "",
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
                      "Pengiriman",
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.5.h),
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
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                        Text(
                          "BCA Virtual Account",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Harga",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                        Text(
                          "${currencyFormatter.format(order?["order_total"] ?? 0)}",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ongkos Kirim",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                        ),
                        Text(
                          "${currencyFormatter.format(order?["courier_cost"] ?? 0)}",
                          style:
                              TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
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
              Center(
                child: InkWell(
                  child: Container(
                    width: 55.w,
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
                          "Batalkan Pesanan",
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h)
            ],
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
                            " 1 x ${currencyFormatter.format((double.parse(item["priceProduct"])).toInt())}",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "${currencyFormatter.format(int.parse("100000"))}",
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 11.sp,
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
