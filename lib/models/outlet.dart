class Outlet {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String openHours;
  final String closeHours;
  final List<String> facilities;
  final List<String> brands; // Eiger, Consina, Arei, dll

  Outlet({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.openHours,
    required this.closeHours,
    required this.facilities,
    required this.brands,
  });

  // Helper: Calculate distance from user location (in km)
  double distanceFrom(double userLat, double userLng) {
    const double earthRadius = 6371; // km
    final double dLat = _toRadians(latitude - userLat);
    final double dLng = _toRadians(longitude - userLng);

    final double a =
        (dLat / 2).sin() * (dLat / 2).sin() +
        userLat.toRadians().cos() *
            latitude.toRadians().cos() *
            (dLng / 2).sin() *
            (dLng / 2).sin();

    final double c = 2 * (a.sqrt()).asin();
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * 3.141592653589793 / 180;
  }

  // Helper: Check if outlet is currently open
  bool isOpenNow() {
    final now = DateTime.now();
    final currentTime = now.hour * 60 + now.minute;

    final openTime =
        int.parse(openHours.split(':')[0]) * 60 +
        int.parse(openHours.split(':')[1]);
    final closeTime =
        int.parse(closeHours.split(':')[0]) * 60 +
        int.parse(closeHours.split(':')[1]);

    return currentTime >= openTime && currentTime <= closeTime;
  }
}

extension on double {
  double sin() => this;
  double cos() => this;
  double asin() => this;
  double sqrt() => this;
  double toRadians() => this * 3.141592653589793 / 180;
}
