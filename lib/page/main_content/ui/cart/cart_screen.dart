import 'package:bekal/api/dio_client.dart';
import 'package:bekal/page/main_content/ui/cart/cart_checkout.dart';
import 'package:bekal/page/main_content/ui/cart/model/cart.dart';
import 'package:bekal/page/main_content/ui/cart/widget/cart_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double grandPrice = 0.0;
  late DioClient _dio = new DioClient();
  bool isGettingData = false;

  List<CartStore> _items = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');

    return LoadingOverlay(
      isLoading: isGettingData,
      color: Colors.white,
      opacity: .3,
      child: Stack(
        children: [
          Positioned(
            top: -20.h,
            right: -10.w,
            height: 30.h,
            width: 120.w,
            child: Neumorphic(
              style: NeumorphicStyle(
                  color: Color(0xfff39200).withOpacity(.8),
                  shadowDarkColorEmboss: Colors.black87,
                  shape: NeumorphicShape.flat,
                  depth: 2,
                  intensity: 1,
                  surfaceIntensity: 1,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w),
                      bottomRight: Radius.circular(35.w),
                      bottomLeft: Radius.circular(35.w)))),
              child: Container(
                color: Colors.transparent,
                height: 10,
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 13.h),
              width: 100.w,
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List<Widget>.generate(
                      _items.length,
                      (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Text(
                                _items[index].store_name,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ghotic'),
                              ),
                            ),
                            SizedBox(height: 2.w),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                children: List<Widget>.generate(
                                    _items[index].item.length, (i) {
                                  return CartItemScreen(
                                      key: Key("item-${index}-${i}"),
                                      index: 1,
                                      item: _items[index].item[i],
                                      onDelete: _deleteItem,
                                      onChange: _onChangeQty);
                                }),
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 10)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            child: Neumorphic(
              style: NeumorphicStyle(
                color: Color(0xfff39200).withOpacity(.8),
                boxShape: NeumorphicBoxShape.rect(),
                depth: -2,
                intensity: 1,
                surfaceIntensity: 1,
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                width: 100.w,
                height: 18.h,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Total Harga",
                          style: TextStyle(fontFamily: 'ghotic', fontSize: 14),
                        ),
                        Text(
                          currencyFormatter.format(grandPrice),
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          if (_items.isNotEmpty)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Checkout(items: _items)),
                            );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: _items.isNotEmpty ? Colors.red : Colors.grey,
                          ),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                fontFamily: 'ghotic',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _deleteItem(int cartId) async {
    try {
      setState(() {
        isGettingData = true;
      });
      await _dio.deleteAsync("/order/cart/remove/${cartId}");
    } catch (e) {}
    _getData();
  }

  _getData() async {
    setState(() {
      isGettingData = true;
    });
    List<CartStore> resData = [];
    try {
      DioResponse res = await _dio.getAsync("/order/cart");

      if (res.results["code"] == 200) {
        resData = res.results["data"]
            .map<CartStore>((json) => CartStore.fromJson(json))
            .toList();
        _items = resData;
        setState(() {
          _items = resData;

          _calculateGrandPrice();
        });
      }
    } catch (e) {}
    setState(() {
      isGettingData = false;
    });
  }

  _onChangeQty(int prodId, int qty) async {
    try {
      var payload = {"store_product_id": prodId, "product_qty": qty};
      await _dio.postAsync("/order/cart/update", payload);
    } catch (e) {}

    _calculateGrandPrice();
  }

  _calculateGrandPrice() {
    double calGrandPrice = 0;

    _items.forEach((element) {
      element.item.forEach((item) {
        calGrandPrice +=
            item.cart_qty * double.parse(item.product.priceProduct ?? "0");
      });
    });

    setState(() {
      grandPrice = calGrandPrice;
    });
  }
}
