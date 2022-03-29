import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/order/detail_order.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class DialogHistoryTransaksi extends StatefulWidget {
  final ValueChanged<bool>? onDismiss;
  const DialogHistoryTransaksi({Key? key, this.onDismiss}) : super(key: key);
  @override
  _DialogHistoryTransaksi createState() => _DialogHistoryTransaksi();
}

class _DialogHistoryTransaksi extends State<DialogHistoryTransaksi> {
  DioClient _dio = new DioClient();
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  bool isGettingData = false;
  List historyTrans = [];

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isGettingData,
      color: Colors.black38,
      opacity: .3,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [..._buildItem()],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItem() {
    List<Widget> list = [];
    historyTrans.forEach((trans) {
      list.add(InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailOrder(
                orderId: trans["order_id"],
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
                        formatDate(context, "${trans["order_at"]}",
                            format: "dd MMMM yyyy, hh:mm WIB"),
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.orange,
                      ),
                      child: Text(
                        "${trans["status"]["status_name"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ghotic',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
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
                                  ["product_thumbnail"],
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
                                trans["thumbnail_product"]["product_name"],
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Jumlah Barang : ${trans["thumbnail_product"]["product_qty"]}",
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
                      currencyFormatter
                          .format(int.parse("${trans["order_total"]}")),
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Divider(),
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
      DioResponse res = await _dio.getAsync("/order/list");
      if (res.results["code"] == 200) {
        setState(() {
          historyTrans = res.results["data"];
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
