class CartItem {
  int cartId;
  int productId;
  String productName;
  String thumbnail;
  double price;
  int quantity;
  int userId;

  CartItem(
      {required this.productId,
      required this.productName,
      required this.userId,
      required this.cartId,
      required this.thumbnail,
      required this.price,
      required this.quantity});
}
