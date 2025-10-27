class WeatherData {
  final String region;
  final double rainfall; // in mm
  final int rainyDays; // jumlah hari hujan
  final String month;
  final int year;

  WeatherData({
    required this.region,
    required this.rainfall,
    required this.rainyDays,
    required this.month,
    required this.year,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      region: json['region'] ?? '',
      rainfall: (json['rainfall'] ?? 0).toDouble(),
      rainyDays: json['rainyDays'] ?? 0,
      month: json['month'] ?? '',
      year: json['year'] ?? DateTime.now().year,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'rainfall': rainfall,
      'rainyDays': rainyDays,
      'month': month,
      'year': year,
    };
  }
}
