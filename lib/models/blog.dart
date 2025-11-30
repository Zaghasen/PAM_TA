class FieldReport {
  final int id;
  final String title;
  final String
  category; // Field Report, Trip Report, Gear Review, Tips & Tricks, Safety Alert
  final String imageUrl;
  final String date;
  final String description;
  final String content;

  // Community Features
  final String authorName;
  final String authorAvatar;
  final String mountainName;
  final String location; // Provinsi/Region
  final int difficultyLevel; // 1-5
  final int duration; // dalam jam
  final double? elevation; // dalam meter (mdpl)
  final List<String> tags; // e.g., ['sunrise', 'camping', 'via ferrata']

  // Engagement
  final int likes;
  final int comments;
  final int shares;

  final String?
  linkToService; // Opsional, link ke layanan lain seperti 'sewa_alat'

  FieldReport({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.date,
    required this.description,
    required this.content,
    required this.authorName,
    required this.authorAvatar,
    required this.mountainName,
    required this.location,
    required this.difficultyLevel,
    required this.duration,
    this.elevation,
    this.tags = const [],
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.linkToService,
  });
}

// Untuk backward compatibility
typedef BlogPost = FieldReport;
