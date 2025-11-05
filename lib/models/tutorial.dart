class Tutorial {
  final int id;
  final String title;
  final String category;
  final String imageUrl;
  final String duration;
  final String description;
  final List<String> steps;
  final String? linkToService; // Opsional, link ke layanan lain

  Tutorial({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.duration,
    required this.description,
    required this.steps,
    this.linkToService,
  });
}
