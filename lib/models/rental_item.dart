class RentalItem {
  final String id;
  final String outletId;
  final String name;
  final String brand;
  final String category; // Tenda, Carrier, Sleeping Bag, dll
  final String imageUrl;
  final List<String> images;
  final double pricePerDay;
  final String description;
  final List<String> specifications;
  final int stock;
  final String condition; // Baik, Sangat Baik
  final double rating;
  final int reviewCount;

  RentalItem({
    required this.id,
    required this.outletId,
    required this.name,
    required this.brand,
    required this.category,
    required this.imageUrl,
    required this.images,
    required this.pricePerDay,
    required this.description,
    required this.specifications,
    required this.stock,
    required this.condition,
    required this.rating,
    required this.reviewCount,
  });

  bool get isAvailable => stock > 0;
}
