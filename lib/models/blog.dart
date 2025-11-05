class BlogPost {
  final int id;
  final String title;
  final String category;
  final String imageUrl;
  final String date;
  final String description;
  final String content;
  final String?
  linkToService; // Opsional, link ke layanan lain seperti 'sewa_alat'

  BlogPost({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.date,
    required this.description,
    required this.content,
    this.linkToService,
  });
}
