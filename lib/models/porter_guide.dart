class PorterGuide {
  final int id;
  final String name;
  final String photoUrl;
  final int experienceYears;
  final double rating;
  final int totalReviews;
  final List<String> languages;
  final List<String> certifications;
  final List<String> specialMountains;
  final String specialty; // 'Porter', 'Guide', or 'Both'
  final String description;
  final List<Package> packages;
  final List<Review> reviews;
  final List<Achievement> achievements;

  PorterGuide({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.experienceYears,
    required this.rating,
    required this.totalReviews,
    required this.languages,
    required this.certifications,
    required this.specialMountains,
    required this.specialty,
    required this.description,
    required this.packages,
    required this.reviews,
    required this.achievements,
  });
}

class Package {
  final String name;
  final String description;
  final double price;
  final List<String> includes;
  final String duration;
  final bool photoVideoService;

  Package({
    required this.name,
    required this.description,
    required this.price,
    required this.includes,
    required this.duration,
    this.photoVideoService = false,
  });
}

class Review {
  final String reviewerName;
  final String reviewerPhoto;
  final double rating;
  final String comment;
  final String date;
  final String mountainClimbed;
  final List<String> photos;

  Review({
    required this.reviewerName,
    required this.reviewerPhoto,
    required this.rating,
    required this.comment,
    required this.date,
    required this.mountainClimbed,
    this.photos = const [],
  });
}

class Achievement {
  final String title;
  final String icon;
  final String description;

  Achievement({
    required this.title,
    required this.icon,
    required this.description,
  });
}
