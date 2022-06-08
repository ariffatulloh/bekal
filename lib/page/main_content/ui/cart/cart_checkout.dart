import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/cart/model/cart.dart';
import 'package:bekal/page/main_content/ui/cart/payment_screen.dart';
import 'package:bekal/page/main_content/ui/home_screen.dart';
import 'package:bekal/page/utility_ui/Toaster.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class Checkout extends StatefulWidget {
  final List<CartStore> items;
  const Checkout({Key? key, required this.items}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final DioClient _dio = new DioClient();

  List<Shipping?> selectedShipper = [];
  String selectedBank = "";
  List availableBanks = [];
  bool isCreatingOrder = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _getPaymentMethod();

    widget.items.forEach((e) {
      selectedShipper.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Konfirmasi Pesanan',
          style: TextStyle(
              fontFamily: 'ghotic',
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        color: Colors.black38,
        opacity: .3,
        child: Container(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._itemProduct(),
                SizedBox(height: 8),
                Text(
                  "Metode Pembayaran",
                  style: TextStyle(
                      fontFamily: 'ghotic',
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._itemPembayaran(),
                SizedBox(height: 5.h),
                Text(
                  "Total Pembayaran",
                  style: TextStyle(
                      fontFamily: 'ghotic',
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  currencyFormatter.format(_calculateGrandPrice()),
                  style: TextStyle(
                      fontFamily: 'ghotic',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (isCreatingOrder) return;

                      List checkShipper =
                          selectedShipper.where((e) => e == null).toList();

                      if (checkShipper.length > 0) {
                        return Toaster(context).showErrorToast(
                            "Pengiriman belum dipilih",
                            gravity: ToastGravity.CENTER);
                      }

                      if (selectedBank == "") {
                        return Toaster(context).showErrorToast(
                            "Metode Pembayaran belum dipilih",
                            gravity: ToastGravity.CENTER);
                      }

                      _submitOrder();
                    },
                    child: Container(
                      width: 55.w,
                      height: 5.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: isCreatingOrder ? Colors.grey : Colors.red,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isCreatingOrder)
                            Padding(
                              padding: EdgeInsets.only(right: 3.w),
                              child: SizedBox(
                                width: 5.w,
                                height: 5.w,
                                child: CircularProgressIndicator(
                                  color: Colors.orange,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          Text(
                            "Submit Pesanan",
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
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _calculateGrandPrice() {
    double calGrandPrice = 0;

    widget.items.forEach((element) {
      element.item.forEach((item) {
        calGrandPrice +=
            item.cart_qty * double.parse(item.product.priceProduct ?? "0");
      });
    });

    selectedShipper.forEach((e) {
      if (e != null) {
        calGrandPrice += e.shippingPrice;
      }
    });

    return calGrandPrice;
  }

  _getPaymentMethod() async {
    setState(() {
      isLoading = true;
    });
    try {
      DioResponse res = await _dio.getAsync("/payment/bank/list");
      print(res.results);
      if (res.results["code"] == 200) {
        List banks = res.results["data"];

        List selectedBank =
            banks.where((e) => ["MANDIRI", "BRI"].contains(e["code"])).toList();
        setState(() {
          availableBanks = selectedBank;
        });
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  _submitOrder() async {
    var products = [];
    for (int i = 0; i < widget.items.length; i++) {
      var item = [];

      widget.items[i].item.forEach((e) {
        item.add({"cart_id": e.cart_id, "product_qty": e.cart_qty});
      });

      products.add({
        "store_id": widget.items[i].store_id,
        "courier_id": selectedShipper[i]!.courierId,
        "courier_name": selectedShipper[i]!.courierName,
        "courier_code": selectedShipper[i]!.courierCode,
        "rate_id": selectedShipper[i]!.rateId,
        "rate_name": selectedShipper[i]!.rateName,
        "rate_type": selectedShipper[i]!.rateType,
        "courier_notes": "-",
        "order_cod": false,
        "use_insurance": false,
        "shipping_price": selectedShipper[i]!.shippingPrice,
        "item": item
      });
    }

    var payload = {"order_product": products, "payment_method": selectedBank};

    try {
      setState(() {
        isCreatingOrder = true;
      });

      DioResponse res = await _dio.postAsync("/order/create", payload);
      print(res.results);
      print(payload);
      if (res.results["code"] == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaymentScreen(invoiceId: res.results["data"]["invoice_id"]),
          ),
        );
      } else {
        Toaster(context).showErrorToast(res.results["errorMessage"],
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      Toaster(context).showErrorToast("Terjadi masalah pada koneksi internet",
          gravity: ToastGravity.CENTER);
    }

    setState(() {
      isCreatingOrder = false;
    });
  }

  _onSelectedCourier(int index, Shipping s) {
    setState(() {
      selectedShipper[index] = s;
    });
  }

  String buildShipInfo(Shipping? shipping) {
    if (shipping != null) {
      return "${shipping.courierName} (${shipping.rateName}) - ${currencyFormatter.format(shipping.shippingPrice)}";
    }

    return "Pilih Pengiriman";
  }

  List<Widget> _itemPembayaran() {
    List<Widget> list = [];
    availableBanks.forEach((bank) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 1.h),
        child: ListTile(
          onTap: () {
            setState(() {
              selectedBank = bank["code"];
            });
          },
          dense: false,
          selected: true,
          selectedTileColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
                color: selectedBank == bank["code"]
                    ? Colors.orange
                    : Colors.transparent,
                width: 2),
          ),
          title: Text(
            "${bank["code"]} Virtual Account",
            style: TextStyle(
                fontFamily: 'ghotic',
                fontSize: 11.sp,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.check_circle,
              color: selectedBank == bank["code"] ? Colors.blue : Colors.grey),
        ),
      ));
    });

    return list;
  }

  List<Widget> _itemProduct() {
    List<Widget> list = [];
    for (int i = 0; i < widget.items.length; i++) {
      var cart = widget.items[i];

      list.add(
        Text(
          cart.store_name,
          style: TextStyle(
              fontFamily: 'ghotic',
              color: Colors.black87,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold),
        ),
      );
      list.add(SizedBox(height: 2.h));
      cart.item.forEach((item) {
        list.add(
          Container(
            height: 26.w,
            width: 96.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 23.w,
                  height: 23.w,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: item.product.uriThumbnail ?? "",
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
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
                  width: 65.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.nameProduct,
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Jumlah Barang : ${item.cart_qty}",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      Text(
                        currencyFormatter.format(
                            int.parse(item.product.priceProduct ?? "0")),
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });

      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "Pengiriman",
              style: TextStyle(
                  fontFamily: 'ghotic',
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CourierDialog(
                          items: cart,
                          indexShipper: i,
                          onSelected: _onSelectedCourier);
                    });
              },
              dense: false,
              selected: true,
              selectedTileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              title: Text(
                buildShipInfo(selectedShipper[i]),
                style: TextStyle(
                    fontFamily: 'ghotic',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 24,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 1.h),
            Divider(),
            SizedBox(height: 3.h),
          ],
        ),
      );
    }
    return list;
  }
}

class Shipping {
  double courierId;
  String courierName;
  String courierCode;
  double rateId;
  String rateName = "";
  String rateType = "";
  double shippingPrice;

  Shipping(
      {required this.courierId,
      this.courierName = "",
      this.courierCode = "",
      required this.rateId,
      this.rateName = "",
      this.rateType = "",
      this.shippingPrice = 0.0});
}

class CourierDialog extends StatefulWidget {
  final CartStore items;
  final indexShipper;
  final Function(int index, Shipping shipping) onSelected;
  const CourierDialog(
      {Key? key,
      required this.items,
      required this.indexShipper,
      required this.onSelected})
      : super(key: key);

  @override
  _CourierDialogState createState() => new _CourierDialogState();
}

class _CourierDialogState extends State<CourierDialog> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  DioClient _dio = new DioClient();
  bool isGettingCourier = true;

  List courier = [];

  @override
  void initState() {
    super.initState();

    _gettingCourier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
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
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 7.5.h,
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
                            "Pilihan Pengiriman",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        if (isGettingCourier)
                          Container(
                            padding: EdgeInsets.all(5.w),
                            child: CircularProgressIndicator(),
                          ),
                        if (!isGettingCourier)
                          Column(
                            children:
                                List<Widget>.generate(courier.length, (i) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      widget.onSelected(
                                        widget.indexShipper,
                                        new Shipping(
                                            courierId: courier[i]["logistic"]
                                                ["id"],
                                            courierName: courier[i]["logistic"]
                                                ["name"],
                                            courierCode: courier[i]["logistic"]
                                                ["code"],
                                            rateId: courier[i]["rate"]["id"],
                                            rateName: courier[i]["rate"]
                                                ["name"],
                                            rateType: courier[i]["rate"]
                                                ["type"],
                                            shippingPrice: courier[i]
                                                ["final_price"]),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black12,
                                            width: .5,
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w, top: 2.5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(3)),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: courier[i]["logistic"]
                                                    ["logo_url"],
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    child:
                                                        new CircularProgressIndicator(
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          Container(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${courier[i]["logistic"]["name"]} (${courier[i]["rate"]["name"]})",
                                                    style: TextStyle(
                                                        fontFamily: 'ghotic',
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    currencyFormatter.format(
                                                        courier[i]
                                                            ["final_price"]),
                                                    style: TextStyle(
                                                        fontFamily: 'ghotic',
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () => {Navigator.of(context).pop()},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h),
                              child: Text(
                                "Tutup",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _gettingCourier() async {
    if (mounted) {
      setState(() {
        isGettingCourier = true;
      });

      double price = 0;
      double weight = 0;

      widget.items.item.forEach((element) {
        price += element.cart_qty *
            double.parse(element.product.priceProduct ?? "0");
        weight += element.cart_qty * element.product.weightProduct;
      });

      var payload = {
        "height": 1.0,
        "length": 1.0,
        "width": 1.0,
        "item_value": price,
        "weight": weight,
        "cod": false,
        "store_id": widget.items.store_id,
        "for_order": false,
        "limit": 30,
        "page": 1,
        "sort_by": []
      };

      try {
        DioResponse res =
            await _dio.postAsync("/logistics/pricing/check", payload);
        if (res.results["code"] == 200) {
          List pricing = res.results["data"]["pricings"];

          List selectedPricing = pricing
              .where(
                  (e) => ["J&T", "JNE", "Tiki"].contains(e["logistic"]["name"]))
              .toList();
          setState(() {
            courier = selectedPricing;
          });
        }
      } catch (e) {
        print(e);
      }

      setState(() {
        isGettingCourier = false;
      });
    }
  }
}
