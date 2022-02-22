class CartItem {
  int productId;
  String productName;
  String thumbnail;
  double price;
  int quantity;

  CartItem(
      {required this.productId,
      required this.productName,
      required this.thumbnail,
      required this.price,
      required this.quantity});
}
