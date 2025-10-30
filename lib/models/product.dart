// Model untuk merepresentasikan data produk
class Product {
  final int id;
  final String name;
  final String brand;
  final double pricePerDay;
  final String imageUrl;
  final String description;
  final String category; // New field for product category
  bool isWishlisted;
  int totalLike;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.imageUrl,
    this.description =
        'Deskripsi produk belum tersedia. Item ini adalah salah satu yang terbaik di kelasnya, cocok untuk petualangan Anda.',
    required this.category, // Make category required
    this.isWishlisted = false,
    this.totalLike = 0,
  });
}
