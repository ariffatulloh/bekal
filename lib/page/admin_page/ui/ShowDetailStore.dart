import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/utility_ui/DirectoryPath.dart';
import 'package:bekal/page/utility_ui/xlsx.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class ShowDetailStore extends StatefulWidget {
  int idStore;

  ShowDetailStore({required this.idStore});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowDetailStoreState();
  }
}

class ShowDetailStoreState extends State<ShowDetailStore>
    with TickerProviderStateMixin {
  String title = "1 Minggu";
  var dummyImageVersion = '?dummy=${math.Random().nextInt(999)}';
  var listData = [];
  bool isExportInProgress = false;
  double progressExport = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataStatistikStore(paramDuration: title);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('$title'),
        leading: PopupMenuButton<String>(
          padding: EdgeInsets.all(0),
          elevation: 2,
          offset: Offset(0, kToolbarHeight),
          icon: Icon(Icons.menu_open),
          onSelected: (valueSelected) {
            setState(() {
              title = valueSelected;
              getDataStatistikStore(paramDuration: title);
            });
          },
          itemBuilder: (builder) {
            return [
              PopupMenuItem(
                  enabled: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("Kembali")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "all",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("All")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "1 tahun",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("1 Tahun")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "6 Bulan",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("6 Bulan")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "3 Bulan",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("3 Bulan")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "1 Bulan",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("1 Bulan")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "1 Minggu",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("1 Minggu")
                        ],
                      ),
                    ],
                  )),
              PopupMenuItem(
                  enabled: true,
                  value: "1 Hari",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_month_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text("1 Hari")
                        ],
                      ),
                    ],
                  ))
            ];
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: LoadingOverlay(
              isLoading: listData == null || isExportInProgress,
              color: Colors.black38,
              opacity: .3,
              progressIndicator: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: progressExport / 100,
                center: new Text("${progressExport.toStringAsFixed(1)}%"),
                progressColor: Colors.blue,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !listData.isEmpty,
                      child: NeumorphicButton(
                        onPressed: () async {
                          // await _getPermission();
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
                          size: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(listData.isEmpty ? "Tidak Ada Data" : "Unduh Excel")
                  ],
                ),
              ))
          // listData == null
          //       ? Center(
          //           child: CircularProgressIndicator(
          //             color: Colors.blue,
          //           ),
          //         )
          //       : Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               NeumorphicButton(
          //                 onPressed: () async {
          //                   // await _getPermission();
          //                   createFileExcel(
          //                     progress: (value) {
          //                       setState(() {
          //                         progressExport = value * 100;
          //                         isExportInProgress = (progressExport < 100);
          //                       });
          //                     },
          //                   );
          //                 },
          //                 style: NeumorphicStyle(
          //                     color: Colors.transparent,
          //                     boxShape: NeumorphicBoxShape.circle(),
          //                     depth: 1,
          //                     intensity: 1,
          //                     surfaceIntensity: 1),
          //                 child: Icon(
          //                   Icons.download_rounded,
          //                   color: Colors.grey,
          //                   size: 20.w,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 2.w,
          //               ),
          //               Text("Unduh Excel")
          //             ],
          //           ),
          //         )
          // : SingleChildScrollView(
          //     child: Column(
          //       children: [...getbody()],
          //     ),
          //   ),
          ),
    );
  }

  void createFileExcel({required Function(double value) progress}) async {
    List<DataTransaksi_xlsFormat> listDataTransaksiToxlsx = [];
    double progressValue = 0.0;
    // await Future.forEach(orderList, (dynamic elementorderList) async {
    //   // progressValue = indexOrder;
    //   // print('${progressValue++ / 100}');
    //   // progressValue += progressValue / orderList.length.toDouble() * 30;
    //   // print('30=> ${progressValue}');
    //   print('elementorder=${elementorderList['order']['order_id']} ');
    //   DioResponse res = await _dio
    //       .getAsync("/order/detail/${elementorderList['order']['order_id']}");
    //   if (res.results["code"] == 200) {
    //     var order = res.results["data"]["order"];
    //     var store = res.results["data"]["store"];
    //     var status = res.results["data"]["status"];
    //     var products = res.results["data"]["product"];
    //     var invoice = res.results["data"]["invoice"];
    //     var noresi = order?["delivery_no"] ?? "";
    //     double indexProduct = 0;
    //     await Future.forEach(products, (dynamic elementProducts) {
    //       var data = DataTransaksi_xlsFormat();
    //       String _buyerName = "";
    //       String _buyerPhone = "";
    //       String _buyerAddress = "";
    //       String _kurirType = "";
    //       data.detailProduct_xlsFormat.nameProduct =
    //           elementProducts['nameProduct'];
    //
    //       data.detailProduct_xlsFormat.quantity =
    //           elementProducts['stockProduct'];
    //
    //       data.detailProduct_xlsFormat.pricePerQty =
    //           elementProducts['priceProduct'];
    //
    //       data.detailProduct_xlsFormat.dateOrder =
    //           formatDate(context, "${elementorderList['order']['createdAt']}");
    //
    //       data.detailProduct_xlsFormat.statusTransaksi =
    //           elementorderList['order']['status']['status_name'];
    //
    //       data.detailProduct_xlsFormat.priceAllQty =
    //           (double.parse(elementProducts["priceProduct"]) *
    //                   int.parse(elementProducts["stockProduct"]))
    //               .toString();
    //
    //       data.buyerInformation_xlsFormat.buyerName =
    //           elementorderList['buyer']['name'];
    //       data.buyerInformation_xlsFormat.buyerPhone =
    //           elementorderList['buyer']['phone'];
    //       data.buyerInformation_xlsFormat.buyerAddress =
    //           elementorderList['order']['delivery_destination'];
    //       data.buyerInformation_xlsFormat.kurirType =
    //           '${order['courier_desc']} (${order['rate_name']})';
    //       listDataTransaksiToxlsx.add(data);
    //       var valuOfProgress = ((progressValue++) /
    //           (listDataTransaksiToxlsx.length +
    //               (products as List).length +
    //               20));
    //       progress(valuOfProgress);
    //     });
    //   }
    // });
    // print('${listDataTransaksiToxlsx.length}');

    // progress(0.1);
    // progress(((progressValue++) / (listData.length)));
    listData.forEach((element) {
      int indexRow = 0;
      // print(element["listProduct"]);

      (element["listProduct"] as List<dynamic>).forEach((listProduct) {
        // indexRow++;
        int indexColumn = 1;
        print(
            '[Row:${indexRow += 1} - Column:${indexColumn}] ${listProduct["productName"]}');

        print('[Row:${indexRow += 1} - Column:${indexColumn}] detail info');
        // print(listProduct["detailInformationOrder"]);
        (listProduct["detailInformationOrder"] as List<dynamic>)
            .forEach((detailInformationOrder) {
          // indexRow++;
          indexRow += 1;
          print(
              '[Row:${indexRow} - Column:1] ${detailInformationOrder["tanggalPemesanan"]}');
          print(
              '[Row:${indexRow} - Column:2] ${detailInformationOrder["customerName"]}');
          print(
              '[Row:${indexRow} - Column:3] ${detailInformationOrder["customerDestination"]}');
          print(
              '[Row:${indexRow} - Column:4] ${detailInformationOrder["qtyItem"]}');
          print(
              '[Row:${indexRow} - Column:5] ${detailInformationOrder["totalPrice"]}');
          print(
              '[Row:${indexRow} - Column:6] ${detailInformationOrder["courierCost"]}');
          print(
              '[Row:${indexRow} - Column:7] ${detailInformationOrder["customerPaymentMethod"]}');
          print(
              '[Row:${indexRow} - Column:8] ${detailInformationOrder["courierType"]}');
          print(
              '[Row:${indexRow} - Column:9] ${detailInformationOrder["statusPemesanan"]}');
        });
      });
      // sheet1.getRangeByIndex(1, 2).text = '${element["time"]}';
    });
    // progress(0.0);
    var ex = xlsx().createExcelFileAdminReporting(data: listData);
    var doc = await DirectoryPath().saveDoc(documents: ex);
    print((ex.length + doc.length));

    var timers = Timer.periodic(Duration(milliseconds: 1), (timer) async {
      // print('value+${timer.tick / (ex.length + doc.length)}');

      if ((timer.tick / (ex.length + doc.length)) < 1.0) {
        progress(timer.tick / (ex.length + doc.length));
      } else {
        progress(1);
        timer.cancel();
        print(timer.isActive);
        if (!timer.isActive) {
          await OpenFile.open(doc);
          //     .then((value) => null);
        }
      }
    });

    // print(timers.isActive);
    // timers.cancel();
    // progress();
    // progress(((progressValue++) / (listData.length)));
    // progress(valuOfProgress);
    // var valuOfProgress = progressValue / listDataTransaksiToxlsx.length;
    // progress(valuOfProgress);
    // print(
    //     '${(progressValue) / listDataTransaksiToxlsx.length}==${progressValue}');

    // await OpenFile.open(await DirectoryPath().saveDoc(documents: ex))
    //     .then((value) => null);
    //
    // progress(((progressValue++) / (listData.length)));
    // progress(((progressValue++) / (listData.length)));
  }

  // objDetailInfoOrder["tanggalPemesanan"] = detailInfoOrder.order?.createdAt?:"-"
  // objDetailInfoOrder["statusPemesanan"] = detailInfoOrder.order?.status?.status_name?:""
  // objDetailInfoOrder["customerName"] = detailInfoOrder.order?.user?.fullName?:""
  // objDetailInfoOrder["customerDestination"]= detailInfoOrder.order?.delivery_destination?:""
  // objDetailInfoOrder["customerPaymentMethod"]= detailInfoOrder.order?.invoice?.bank_code?:""
  // objDetailInfoOrder["qtyItem"]=detailInfoOrder.product_qty?:0
  // objDetailInfoOrder["totalPrice"]=detailInfoOrder.order?.order_total?:0
  // objDetailInfoOrder["courierType"]=detailInfoOrder.order?.courier_desc?:""
  // objDetailInfoOrder["courierCost"]=detailInfoOrder.order?.courier_cost?:0
  FloatingActionBubble buildFloatingActionBubble() {
    var _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    var _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    return FloatingActionBubble(
      items: [
        Bubble(
          title: "Lihat Semua Toko",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.store_rounded,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {},
        ),
        Bubble(
          title: "Konfirmasi Penarikan Dana",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.store_rounded,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {},
        )
      ],
      iconData: Icons.list_alt,
      iconColor: Colors.white,
      backGroundColor: Colors.blue,
      animation: _animation,
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),
    );
  }

  Future<void> getDataStatistikStore({required String paramDuration}) async {
    setState(() {
      listData = [];
    });
    var response = await http.get(
        Uri.parse(
            "${DioClient.ipServer}/api/admin/store/${widget.idStore}/getProducts/${paramDuration}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await SecureStorage().getToken()}'
        });
    // print(jsonDecode(response.body));
    var body = jsonDecode(response.body);
    var data = body["data"];
    print(data);

    setState(() {
      listData = data;
    });

    // [{productImage: http://demo.rifias.live/assets/img/thumbnail/product/2, productId: 2, totalQty: 1, totalMoney: 9000, productName: sepatu kulit}, {productImage: http://demo.rifias.live/assets/img/thumbnail/product/1, productId: 1, totalQty: 1, totalMoney: 9000, productName: ticket pegunungan cimande}], errorMessage: , errorData: null}
  }

  getbody() {
    return listData.map(
      (e) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.w),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  width: 1.w,
                ),
                Text(e["time"])
              ],
            ),
          ),
          ...e["listProduct"].map((e) {
            return Neumorphic(
              margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
              style: NeumorphicStyle(
                  color: Colors.greenAccent,
                  depth: 2,
                  intensity: 1,
                  surfaceIntensity: 1),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 3.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xfff39200).withOpacity(.1),
                          Color(0xfff39200).withOpacity(.7)
                        ],
                        stops: [
                          .1,
                          .5
                        ]),
                  ),
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: e["productImage"].toString() +
                                    dummyImageVersion,
                                placeholder: (context, url) => Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: new CircularProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            e["productName"].toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                      Container(
                        width: 100.w,
                        height: 1,
                        color: Colors.grey.shade50,
                      ),
                      SizedBox(
                        height: 1.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Detail Informasi",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.candlestick_chart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: .5.w,
                                  ),
                                  Text(
                                    e["totalQty"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: .5.w,
                                  ),
                                  Text(
                                    "Terjual",
                                    style: TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.attach_money_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: .5.w,
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(
                                            locale: "IDR", decimalDigits: 0)
                                        .format(e["totalMoney"] ?? 0),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: .5.w,
                                  ),
                                  Text(
                                    "Pendapatan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            );
          }).toList()
        ],
      ),
    );
  }
}
