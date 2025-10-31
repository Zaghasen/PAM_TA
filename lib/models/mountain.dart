class Mountain {
  final String image;
  final String name;
  final String managedBy;
  final Map<String, int> prices;
  final String description;
  final String location;
  final double height;

  Mountain({
    required this.image,
    required this.name,
    required this.managedBy,
    required this.prices,
    required this.description,
    required this.location,
    required this.height,
  });
}
