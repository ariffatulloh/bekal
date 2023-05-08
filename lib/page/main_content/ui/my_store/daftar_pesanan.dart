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
import 'package:open_file_safe/open_file_safe.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class DaftarPesanan extends StatefulWidget {
  const DaftarPesanan({Key? key}) : super(key: key);

  @override
  State<DaftarPesanan> createState() => _DaftarPesananState();
}

class ItemTabDaftarPesanan {
  IconData icon;
  String label;
  String? value;
  ItemTabDaftarPesanan({required this.icon, required this.label, this.value});
}

class _DaftarPesananState extends State<DaftarPesanan> {
  DioClient _dio = new DioClient();
  final currencyFormatter = NumberFormat.currency(locale: 'ID');

  bool isGettingData = false;
  List orderList = [];
  List<ItemTabDaftarPesanan> listItemTab = [];

  String itemTabSelected = "";

  @override
  void initState() {
    super.initState();
    List<ItemTabDaftarPesanan> listItemTabLocale = [
      ItemTabDaftarPesanan(icon: Icons.move_to_inbox, label: "Pesanan", value: "pesanan"),
      ItemTabDaftarPesanan(icon: Icons.shopping_bag_rounded, label: "Penjemputan", value: "penjemputan"),
      ItemTabDaftarPesanan(icon: Icons.route, label: "Pengiriman", value: "pengiriman"),
      ItemTabDaftarPesanan(icon: Icons.flag_rounded, label: "Terkirim", value: "terkirim"),
      ItemTabDaftarPesanan(icon: Icons.done_all, label: "Diterima", value: "diterima")
    ];
    listItemTab = listItemTabLocale;
    itemTabSelected = listItemTabLocale.first.value ?? "-";
    // listItemTab.add(ItemTabDaftarPesanan(
    //     icon: Icons.move_to_inbox, label: "Pesanan", value: "_pesanan"));
    // listItemTab.add(ItemTabDaftarPesanan(
    //     icon: Icons.delivery_dining,
    //     label: "Penjemputan",
    //     value: "_penjemputan"));
    // listItemTab.add(ItemTabDaftarPesanan(
    //     icon: Icons.route, label: "Pengiriman", value: "_pengiriman"));
    // listItemTab.add(ItemTabDaftarPesanan(
    //     icon: Icons.done_all, label: "Terkirim", value: "_Terkirim"));

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
                style: TextStyle(fontFamily: 'ghotic', color: Colors.black87, fontWeight: FontWeight.bold),
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
              style: NeumorphicStyle(color: Colors.transparent, boxShape: NeumorphicBoxShape.circle(), depth: 1, intensity: 1, surfaceIntensity: 1),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Neumorphic(
                // margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                style: NeumorphicStyle(depth: 1.3, color: Colors.white, boxShape: NeumorphicBoxShape.rect()),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  width: 100.w,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listItemTab.map((element) {
                        // print(itemTabSelected);
                        return NeumorphicButton(
                          onPressed: () {
                            print(element.value);
                            _getData();
                            setState(() {
                              itemTabSelected = element.value ?? "-";
                            });
                          },
                          padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 2.w),
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          style: NeumorphicStyle(depth: -1, intensity: 1, surfaceIntensity: 1, color: Colors.orange.withOpacity(element.value.toString().contains(itemTabSelected.toString()) ? 1 : 0)),
                          child: Row(
                            children: [
                              Icon(
                                element.icon,
                                color: element.value.toString().contains(itemTabSelected.toString()) ? Colors.white : Colors.black87,
                              ),
                              Text(
                                "${element.label}",
                                style: TextStyle(
                                  color: element.value.toString().contains(itemTabSelected.toString()) ? Colors.white : Colors.black87,
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildItem(context),
                  ),
                ),
              )
            ],
          )

          // child: PersistentTabView(
          //   context,
          //   // controller: _controller,
          //   screens: _buildScreens(),
          //   items: [
          //     PersistentBottomNavBarItem(
          //       icon: Icon(Icons.move_to_inbox_rounded),
          //       title: "Pesanan",
          //       activeColorPrimary: Colors.blue,
          //       inactiveColorPrimary: Colors.grey,
          //       inactiveColorSecondary: Colors.purple,
          //     ),
          //     PersistentBottomNavBarItem(
          //       icon: Icon(Icons.motorcycle_outlined),
          //       title: "Penjemputan",
          //       activeColorPrimary: Colors.blue,
          //       inactiveColorPrimary: Colors.grey,
          //       inactiveColorSecondary: Colors.purple,
          //     ),
          //   ],
          //   confineInSafeArea: true,
          //   backgroundColor: Colors.white, // Default is Colors.white.
          //   handleAndroidBackButtonPress: true, // Default is true.
          //   resizeToAvoidBottomInset:
          //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          //   stateManagement: true, // Default is true.
          //   hideNavigationBarWhenKeyboardShows:
          //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          //   decoration: NavBarDecoration(
          //     borderRadius: BorderRadius.circular(10.0),
          //     colorBehindNavBar: Colors.white,
          //   ),
          //   popAllScreensOnTapOfSelectedTab: true,
          //   popActionScreens: PopActionScreensType.all,
          //   itemAnimationProperties: ItemAnimationProperties(
          //     // Navigation Bar's items animation properties.
          //     duration: Duration(milliseconds: 200),
          //     curve: Curves.ease,
          //   ),
          //   screenTransitionAnimation: ScreenTransitionAnimation(
          //     // Screen transition animation on change of selected tab.
          //     animateTabTransition: true,
          //     curve: Curves.ease,
          //     duration: Duration(milliseconds: 200),
          //   ),
          //   navBarStyle: NavBarStyle
          //       .style1, // Choose the nav bar style with this property.
          // ),
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
      print('notsave status manage');
      await Permission.manageExternalStorage.request();
    }
  }

  List<Widget> _buildItem(BuildContext context) {
    List<Widget> list = [];
    List<String> filterValue() {
      switch (itemTabSelected) {
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

    orderList.where((element) => filterValue().contains(element["order"]["status"]["id"])).forEach((trans) {
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
                        formatDate(context, "${order["createdAt"]}", format: "dd MMMM yyyy, hh:mm WIB"),
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.orange,
                      ),
                      child: Text(
                        "${order["status"]["status_name"]}",
                        style: TextStyle(color: Colors.white, fontFamily: 'ghotic', fontSize: 8.sp, fontWeight: FontWeight.bold),
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
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: trans["thumbnail_product"]?["product_thumbnail"] ?? "",
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: new CircularProgressIndicator(
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                trans["thumbnail_product"]?["product_name"] ?? "",
                                style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Jumlah Barang : ${order["order_qty"] ?? ""}",
                                style: TextStyle(fontFamily: 'ghotic', fontSize: 9.sp),
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
                      style: TextStyle(fontFamily: 'ghotic', fontSize: 11.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ));
    });
    // orderList.forEach((trans) {});

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
      DioResponse res = await _dio.getAsync("/order/detail/${elementorderList['order']['order_id']}");
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
          data.detailProduct_xlsFormat.nameProduct = elementProducts['nameProduct'];

          data.detailProduct_xlsFormat.quantity = elementProducts['stockProduct'];

          data.detailProduct_xlsFormat.pricePerQty = elementProducts['priceProduct'];

          data.detailProduct_xlsFormat.dateOrder = formatDate(context, "${elementorderList['order']['createdAt']}");

          data.detailProduct_xlsFormat.statusTransaksi = elementorderList['order']['status']['status_name'];

          data.detailProduct_xlsFormat.priceAllQty = (double.parse(elementProducts["priceProduct"]) * int.parse(elementProducts["stockProduct"])).toString();

          data.buyerInformation_xlsFormat.buyerName = elementorderList['buyer']['name'];
          data.buyerInformation_xlsFormat.buyerPhone = elementorderList['buyer']['phone'];
          data.buyerInformation_xlsFormat.buyerAddress = elementorderList['order']['delivery_destination'];
          data.buyerInformation_xlsFormat.kurirType = '${order['courier_desc']} (${order['rate_name']})';
          listDataTransaksiToxlsx.add(data);
          var valuOfProgress = ((progressValue++) / (listDataTransaksiToxlsx.length + (products as List).length + 20));
          progress(valuOfProgress);
        });
      }
    });
    // print('${listDataTransaksiToxlsx.length}');

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    var ex = xlsx().createExcelFileDaftarPesanan(dataListTransaksi: listDataTransaksiToxlsx);

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    // progress(valuOfProgress);
    // var valuOfProgress = progressValue / listDataTransaksiToxlsx.length;
    // progress(valuOfProgress);
    // print(
    //     '${(progressValue) / listDataTransaksiToxlsx.length}==${progressValue}');

    await OpenFile.open(await DirectoryPath().saveDoc(documents: ex));

    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
    progress(((progressValue++) / (listDataTransaksiToxlsx.length + 3)));
  }

  List<Widget> _buildScreens() {
    return [Container(), Container()];
    SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: _buildItem(context)),
    );
  }
}
