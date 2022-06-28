import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/order/detail_order.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class ItemTabDaftarPesanan {
  IconData icon;
  String label;
  String? value;
  ItemTabDaftarPesanan({required this.icon, required this.label, this.value});
}

class HistoryTransaksiCustomer extends StatelessWidget {
  HistoryTransaksiCustomer({required this.title});

  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  DioClient _dio = new DioClient();
  String title;
  List<ItemTabDaftarPesanan> listItemTab = [
    ItemTabDaftarPesanan(
        icon: Icons.move_to_inbox, label: "Pesanan", value: "pesanan"),
    ItemTabDaftarPesanan(
        icon: Icons.delivery_dining,
        label: "Penjemputan",
        value: "penjemputan"),
    ItemTabDaftarPesanan(
        icon: Icons.route, label: "Pengiriman", value: "pengiriman"),
    ItemTabDaftarPesanan(
        icon: Icons.flag_rounded, label: "Terkirim", value: "terkirim"),
    ItemTabDaftarPesanan(
        icon: Icons.done_all, label: "Diterima", value: "diterima")
  ];
  ItemTabDaftarPesanan? itemTabSelected;
  @override
  Widget build(BuildContext context) {
    if (itemTabSelected == null) {
      itemTabSelected = listItemTab.first;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '$title',
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
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
      body: SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (buildCtx, stateMenuBuilder) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Neumorphic(
                  padding: EdgeInsets.all(2.w),
                  style: NeumorphicStyle(
                      color: Colors.transparent,
                      depth: -2,
                      intensity: 1,
                      surfaceIntensity: 1,
                      boxShape: NeumorphicBoxShape.rect()),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: BuildListMenuHistoryTransaksi(
                            setState: stateMenuBuilder),
                      )),
                ),
                Expanded(
                  child: StreamBuilder<List>(
                      stream: getDataFromApi().asStream(),
                      builder: (ctxBuilder, asyncSnapshot) {
                        List<String> idStatusSelected() {
                          switch (itemTabSelected?.value?.toLowerCase() ?? "") {
                            case 'pesanan':
                              return ["ORD01", "ORD02", "ORD03"];
                            case 'penjemputan':
                              return ["ORD04", "ORD04A", "ORD04B"];
                            case 'pengiriman':
                              return [
                                "ORD08",
                                "ORD08A",
                              ];
                            case 'terkirim':
                              return ["ORD05"];
                            case 'diterima':
                              return ["ORD09"];
                            default:
                              return [];
                          }
                        }

                        List listData = [];
                        if (asyncSnapshot.hasData) {
                          listData = asyncSnapshot.requireData.where((element) {
                            return idStatusSelected()
                                .contains(element["status"]["id"]);
                          }).toList();
                          // print(listData);
                        }
                        return LoadingOverlay(
                          isLoading: !asyncSnapshot.hasData &&
                              asyncSnapshot.connectionState ==
                                  ConnectionState.waiting,
                          color: Colors.white,
                          opacity: .5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...buildListHistoryTransaksi(
                                    ctx: ctxBuilder, data: listData)
                              ],
                            ),
                          ),
                          progressIndicator: Container(
                            width: 50.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NeumorphicProgressIndeterminate(
                                  height: 1.h,
                                  duration: Duration(seconds: 1),
                                  style: ProgressStyle(depth: -2),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text("Loading...")
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> BuildListMenuHistoryTransaksi({required StateSetter setState}) {
    return listItemTab.map((element) {
      print(element == itemTabSelected);
      return NeumorphicButton(
        onPressed: () {
          print(element.value);
          // _getData();

          setState(() {
            itemTabSelected = element;
          });
        },
        padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
        style: NeumorphicStyle(
            depth: element == itemTabSelected ? -1 : 2,
            intensity: 1,
            surfaceIntensity: 1,
            color:
                Colors.orange.withOpacity(element == itemTabSelected ? 1 : 0)),
        child: Row(
          children: [
            Icon(
              element.icon,
              color: element == itemTabSelected ? Colors.white : Colors.black87,
            ),
            Text(
              "${element.label}",
              style: TextStyle(
                color:
                    element == itemTabSelected ? Colors.white : Colors.black87,
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  Future<List> getDataFromApi() async {
    try {
      DioResponse res = await _dio.getAsync("/order/list");
      if (res.results["code"] == 200) {
        // print(res.results["data"]);
        List listData = res.results["data"] ?? [];

        return listData;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  List<Widget> buildListHistoryTransaksi(
      {required List data, required BuildContext ctx}) {
    List<Widget> result = [];
    data.asMap().forEach((index, element) {
      Widget widget = InkWell(
        onTap: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => DetailOrder(
                orderId: element["order_id"],
              ),
            ),
          ).then(
            (value) {
              return getDataFromApi();
            },
          );
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
                        formatDate(ctx, "${element["order_at"]}",
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
                        "${[
                          "ORD04",
                          "ORD04A",
                          "ORD04B"
                        ].contains(element["status"]["id"]) ? "Proses Packing" : element["status"]["status_name"]} ",
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
                              imageUrl: element["thumbnail_product"]
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
                                element["thumbnail_product"]["product_name"],
                                style: TextStyle(
                                    fontFamily: 'ghotic',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Jumlah Barang : ${element["thumbnail_product"]["product_qty"]}",
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
                          .format(int.parse("${element["order_total"]}")),
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
      );
      result.add(widget);
    });
    return result;
  }
}
