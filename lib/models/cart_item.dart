class CartItem {
  final int productId;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    this.quantity = 1,
  });
}
