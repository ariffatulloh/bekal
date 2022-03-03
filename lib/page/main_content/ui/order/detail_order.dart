import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({Key? key}) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

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
      body: SingleChildScrollView(
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
                "Menunggu pembayaran",
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
                    formatDate(
                        context,
                        "2022-03-02T22:38:28.517+07:00[Asia/Jakarta]"
                            .substring(0, 19),
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
                    "Toko Hectic 123",
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
                    "JNE (YES)",
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
                    "Jalan Kenangan, Rancabalong Gedebage Bandung, Kota Jawa Barat, 40295",
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
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      Text(
                        "BCA Virtual Account",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Harga",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      Text(
                        "${currencyFormatter.format(int.parse("100000"))}",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ongkos Kirim",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
                      ),
                      Text(
                        "${currencyFormatter.format(int.parse("100000"))}",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp),
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
                        "${currencyFormatter.format(int.parse("200000"))}",
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
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }

  List<Widget> _itemProduct() {
    List<Widget> list = [];
    for (int i = 0; i < 2; i++) {
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
                          imageUrl:
                              "http://rifias.live/assets/img/thumbnail/product/1",
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
                              "Sepatu Kayu Apu",
                              style: TextStyle(
                                  fontFamily: 'ghotic',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            " 1 x ${currencyFormatter.format(int.parse("100000"))}",
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
    }
    return list;
  }
}
