import 'package:bekal/database/cartDAO.dart';
import 'package:bekal/database/db_locator.dart';
import 'package:bekal/page/main_content/ui/cart/model/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  List<CartItem> cartList = [];

  @override
  void initState() {
    super.initState();
    _getData();
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
      body: Container(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pesanan",
                style: TextStyle(
                    fontFamily: 'ghotic',
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              ...itemProduct(),
              SizedBox(height: 16),
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
                onTap: () {},
                dense: false,
                selected: true,
                selectedTileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                title: Text(
                  "JNE Reguler (${currencyFormatter.format(_calculateGrandPrice())})",
                  style: TextStyle(
                      fontFamily: 'ghotic',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 24,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 32),
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
                  onTap: () {},
                  child: Container(
                    width: 50.w,
                    height: 5.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.red,
                    ),
                    child: Text(
                      "Submit Pesanan",
                      style: TextStyle(
                          fontFamily: 'ghotic',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getData() async {
    var dataKeranjang = await CartDAO(dbInstance.get()).getData();
    List<CartItem> ci = [];

    dataKeranjang.forEach((e) {
      ci.add(new CartItem(
          cartId: e.id,
          userId: e.userId,
          productId: e.productId,
          productName: e.productName,
          thumbnail: e.thumbnail,
          price: e.productPrice.toDouble(),
          quantity: e.quantity));
    });

    setState(() {
      cartList = ci;
    });

    _calculateGrandPrice();
  }

  _calculateGrandPrice() {
    double calGrandPrice = 0;
    cartList.forEach((e) {
      calGrandPrice += e.price * e.quantity;
    });

    return calGrandPrice;
  }

  List<Widget> itemProduct() {
    List<Widget> list = [];
    cartList.forEach((item) {
      list.add(
        Container(
          margin: EdgeInsets.only(bottom: 3.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.black26),
            ),
          ),
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
                    imageUrl: item.thumbnail,
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
                        item.productName,
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Jumlah Barang : ${item.quantity}",
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      Text(
                        currencyFormatter.format(item.price),
                        style: TextStyle(
                            fontFamily: 'ghotic',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ],
          ),
        ),
      );
    });

    return list;
  }
}
