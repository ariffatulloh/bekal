import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/my_store/detail_pesanan.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class DaftarPesanan extends StatefulWidget {
  const DaftarPesanan({Key? key}) : super(key: key);

  @override
  State<DaftarPesanan> createState() => _DaftarPesananState();
}

class _DaftarPesananState extends State<DaftarPesanan> {
  DioClient _dio = new DioClient();
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  bool isGettingData = false;
  List orderList = [];

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
          'Daftar Pesanan',
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
              children: _buildItem()),
        ),
      ),
    );
  }

  List<Widget> _buildItem() {
    List<Widget> list = [];
    orderList.forEach((trans) {
      var order = trans["order"];
      list.add(InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPesanan(
                orderId: order["order_id"],
              ),
            ),
          ).then((Object? obj) => _getData());
        },
        child: Card(
          child: Container(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 3.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 11.sp,
                    ),
                    SizedBox(width: 1.5.w),
                    Expanded(
                      child: Text(
                        formatDate(context, "${order["createdAt"]}"),
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.orange,
                      ),
                      child: Text(
                        "${order["status"]["status_name"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ghotic',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: trans["thumbnail_product"]
                                      ?["product_thumbnail"] ??
                                  "",
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
                          width: 66.w,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trans["thumbnail_product"]?["product_name"] ??
                                    "",
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Jumlah Barang : ${order["order_qty"] ?? ""}",
                                style: TextStyle(
                                    fontFamily: 'ghotic', fontSize: 9.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Total Belanja",
                      style: TextStyle(
                        fontFamily: 'ghotic',
                        fontSize: 8.sp,
                      ),
                    ),
                    Text(
                      currencyFormatter.format(order["order_total"]),
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ));
    });
    return list;
  }

  _getData() async {
    setState(() {
      isGettingData = true;
    });
    try {
      DioResponse res = await _dio.getAsync("/api/my/outlet/orders");
      if (res.results["code"] == 200) {
        setState(() {
          orderList = res.results["data"];
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
