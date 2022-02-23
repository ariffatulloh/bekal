import 'package:bekal/database/cartDAO.dart';
import 'package:bekal/database/db.dart';
import 'package:bekal/database/db_locator.dart';
import 'package:bekal/page/main_content/ui/cart/cart_checkout.dart';
import 'package:bekal/page/main_content/ui/cart/model/cart_item.dart';
import 'package:bekal/page/main_content/ui/cart/widget/cart_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double grandPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateGrandPrice();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 13.h),
          width: 100.w,
          height: 100.h,
          child: StreamBuilder(
            stream: CartDAO(dbInstance.get()).watchData(),
            builder: (context, AsyncSnapshot<List<CartEntityData>> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                itemBuilder: (context, index) {
                  CartItem item = CartItem(
                      cartId: snapshot.data![index].id,
                      userId: snapshot.data![index].userId,
                      productId: snapshot.data![index].productId,
                      productName: snapshot.data![index].productName,
                      thumbnail: snapshot.data![index].thumbnail,
                      price: snapshot.data![index].productPrice.toDouble(),
                      quantity: snapshot.data![index].quantity);

                  grandPrice += snapshot.data![index].productPrice.toDouble();

                  return CartItemScreen(
                      key: Key("item-${index}"),
                      index: index,
                      item: item,
                      onChange: _calculateGrandPrice);
                },
              );
            },
          ),
        ),
        Positioned(
            bottom: 0.h,
            child: Container(
              padding: EdgeInsets.all(16),
              width: 100.w,
              height: 15.h,
              decoration: BoxDecoration(color: Colors.grey[100]),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Checkout()),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.red,
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
            ))
      ],
    );
  }

  _calculateGrandPrice() async {
    double calGrandPrice = 0;
    var dataKeranjang = await CartDAO(dbInstance.get()).getData();
    dataKeranjang.forEach((e) {
      calGrandPrice += e.productPrice * e.quantity;
    });

    setState(() {
      grandPrice = calGrandPrice;
    });
  }
}
