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
  List<CartItem> cartList = [
    CartItem(
        productId: 1,
        productName: "Baju Batik Trusmi",
        thumbnail:
            "https://tempatwisata.b-cdn.net/wp-content/uploads/2021/05/Batik-trusmii.jpg",
        price: 250000,
        quantity: 1),
    CartItem(
        productId: 2,
        productName: "Baju Batik Jogja",
        thumbnail:
            "https://tempatwisata.b-cdn.net/wp-content/uploads/2021/05/Batik-trusmii.jpg",
        price: 250000,
        quantity: 1),
    CartItem(
        productId: 3,
        productName: "Baju Batik Solo",
        thumbnail:
            "https://tempatwisata.b-cdn.net/wp-content/uploads/2021/05/Batik-trusmii.jpg",
        price: 250000,
        quantity: 1),
  ];

  double grandPrice = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _calculateGrandPrice());
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(2.w, 0.h, 2.w, 13.h),
          width: 100.w,
          height: 100.h,
          child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return CartItemScreen(
                    key: Key("item-${index}"),
                    index: index,
                    item: cartList[index],
                    onChange: _updateItem,
                    onDelete: _deleteItem);
              }),
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

  _updateItem(int index, CartItem item) {
    setState(() {
      cartList[index] = item;
      _calculateGrandPrice();
    });
  }

  _deleteItem(int position) {
    setState(() {
      cartList.removeAt(position);
      _calculateGrandPrice();
    });
  }

  _calculateGrandPrice() {
    double calGrandPrice = 0;
    cartList.forEach((e) {
      calGrandPrice += e.price * e.quantity;
    });

    setState(() {
      grandPrice = calGrandPrice;
    });
  }
}
