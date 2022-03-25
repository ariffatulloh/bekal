import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/my_store/detail_pesanan.dart';
import 'package:bekal/page/utility_ui/CommonFunc.dart';
import 'package:bekal/page/utility_ui/DirectoryPath.dart';
import 'package:bekal/page/utility_ui/xlsx.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
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

  bool isExportInProgress = false;
  double progressExport = 0;
  @override
  Widget build(BuildContext context) {
    print(progressExport.toStringAsFixed(1) + '%');
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Expanded(
                child: Center(
              child: Text(
                'Daftar Pesanan',
                style: TextStyle(
                    fontFamily: 'ghotic',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            )),
            NeumorphicButton(
              onPressed: () async {
                await _getPermission();
                createFileExcel(
                  progress: (value) {
                    setState(() {
                      progressExport = value * 100;
                      isExportInProgress = (progressExport < 100);
                    });
                  },
                );
              },
              style: NeumorphicStyle(
                  color: Colors.transparent,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  intensity: 1,
                  surfaceIntensity: 1),
              child: Icon(
                Icons.download_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
        leading: BackButton(
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: LoadingOverlay(
        isLoading: isGettingData || isExportInProgress,
        color: Colors.black38,
        opacity: .3,
        progressIndicator: CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: progressExport / 100,
          center: new Text("${progressExport.toStringAsFixed(1)}%"),
          progressColor: Colors.blue,
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildItem(context)),
        ),
      ),
    );
  }

  Future<void> _getPermission() async {
    var status = await Permission.storage.status;
    var statusManage = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      print('notsave');
      await Permission.storage.request();
    }

    if (!statusManage.isGranted) {
      print('notsave');
      await Permission.manageExternalStorage.request();
    }
  }

  List<Widget> _buildItem(BuildContext context) {
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

  void createFileExcel({required Function(double value) progress}) async {
    List<DataTransaksi_xlsFormat> listDataTransaksiToxlsx = [];
    double progressValue = 0.0;
    await Future.forEach(orderList, (dynamic elementorderList) async {
      // progressValue = indexOrder;
      // print('${progressValue++ / 100}');
      // progressValue += progressValue / orderList.length.toDouble() * 30;
      // print('30=> ${progressValue}');
      print('elementorder=${elementorderList['order']['order_id']} ');
      DioResponse res = await _dio
          .getAsync("/order/detail/${elementorderList['order']['order_id']}");
      if (res.results["code"] == 200) {
        var order = res.results["data"]["order"];
        var store = res.results["data"]["store"];
        var status = res.results["data"]["status"];
        var products = res.results["data"]["product"];
        var invoice = res.results["data"]["invoice"];
        var noresi = order?["delivery_no"] ?? "";
        double indexProduct = 0;
        await Future.forEach(products, (dynamic elementProducts) {
          var data = DataTransaksi_xlsFormat();
          String _buyerName = "";
          String _buyerPhone = "";
          String _buyerAddress = "";
          String _kurirType = "";
          data.detailProduct_xlsFormat.nameProduct =
              elementProducts['nameProduct'];

          data.detailProduct_xlsFormat.quantity =
              elementProducts['stockProduct'];

          data.detailProduct_xlsFormat.pricePerQty =
              elementProducts['priceProduct'];

          data.detailProduct_xlsFormat.dateOrder =
              formatDate(context, "${elementorderList['order']['createdAt']}");

          data.detailProduct_xlsFormat.statusTransaksi =
              elementorderList['order']['status']['status_name'];

          data.detailProduct_xlsFormat.priceAllQty =
              (double.parse(elementProducts["priceProduct"]) *
                      int.parse(elementProducts["stockProduct"]))
                  .toString();

          data.buyerInformation_xlsFormat.buyerName =
              elementorderList['buyer']['name'];
          data.buyerInformation_xlsFormat.buyerPhone =
              elementorderList['buyer']['phone'];
          data.buyerInformation_xlsFormat.buyerAddress =
              elementorderList['order']['delivery_destination'];
          data.buyerInformation_xlsFormat.kurirType =
              '${order['courier_desc']} (${order['rate_name']})';
          listDataTransaksiToxlsx.add(data);
          var valuOfProgress = ((progressValue++) /
              (listDataTransaksiToxlsx.length +
                  (products as List).length +
                  20));
          progress(valuOfProgress);
        });
      }
    });
    // print('${listDataTransaksiToxlsx.length}');

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    var ex = xlsx().createExcelFile(dataListTransaksi: listDataTransaksiToxlsx);

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    // progress(valuOfProgress);
    // var valuOfProgress = progressValue / listDataTransaksiToxlsx.length;
    // progress(valuOfProgress);
    // print(
    //     '${(progressValue) / listDataTransaksiToxlsx.length}==${progressValue}');

    await OpenFile.open(await DirectoryPath().saveDoc(documents: ex))
        .then((value) => null);

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
  }
}
