import 'package:bekal/page/main_content/ui/cart/model/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CartItemScreen extends StatefulWidget {
  final CartItem item;
  final Function onChange;
  final Function onDelete;
  final int index;
  const CartItemScreen(
      {Key? key,
      required this.index,
      required this.item,
      required this.onChange,
      required this.onDelete})
      : super(key: key);

  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  late CartItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Card(
        child: Container(
          height: 23.w,
          width: 96.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 23.w,
                height: 23.w,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomLeft: Radius.circular(3),
                  ),
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
                          )),
                ),
              ),
              SizedBox(width: 1.w),
              Container(
                width: 69.w,
                padding: EdgeInsets.all(2.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        style: TextStyle(fontFamily: 'ghotic', fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currencyFormatter.format(item.price),
                          style: TextStyle(
                              fontFamily: 'ghotic',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onDelete(widget.index);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(Icons.delete_outline_sharp,
                                    size: 24, color: Colors.grey),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 20.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (item.quantity > 1)
                                        setState(() {
                                          item.quantity--;
                                          widget.onChange(widget.index, item);
                                        });
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: item.quantity > 1
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    child: Text(
                                      "${item.quantity}",
                                      style: TextStyle(
                                          fontFamily: 'ghotic',
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        item.quantity++;
                                        widget.onChange(widget.index, item);
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
