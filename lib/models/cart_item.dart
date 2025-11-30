class CartItem {
  final dynamic product; // Can be Product or RentalItem
  final int productId;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  int quantity;
  final DateTime? rentalStartDate;
  final DateTime? rentalEndDate;
  final String? outletName;

  CartItem({
    this.product,
    int? productId,
    String? name,
    String? imageUrl,
    double? pricePerDay,
    this.quantity = 1,
    this.rentalStartDate,
    this.rentalEndDate,
    this.outletName,
  }) : productId = productId ?? (product?.id ?? 0),
       name = name ?? (product?.name ?? ''),
       imageUrl = imageUrl ?? (product?.imageUrl ?? ''),
       pricePerDay = pricePerDay ?? (product?.pricePerDay ?? 0.0);

  // Getter untuk category dari product
  String? get category => product?.category;

  // Getter untuk id (alias dari productId)
  int get id => productId;

  // Getter untuk brand dari product
  String get brand => product?.brand ?? '';

  // Getter untuk description dari product
  String get description => product?.description ?? '';
}
