import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Request location permission from user
  /// Returns LocationPermission to handle different permission states
  Future<LocationPermission> requestLocationPermission() async {
    // Check current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission (will show Android popup)
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  /// Get current position with permission handling
  /// Returns Position if successful, null if failed or permission denied
  Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  /// Check if location permission is granted
  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Check if location services are enabled on device
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Open app settings for manual permission grant
  Future<void> openLocationSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<String> getLocationName(double latitude, double longitude) async {
    // Simple reverse geocoding - in real app, use geocoding service
    // For demo, return coordinates as string
    return '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
  }

  Future<String?> getNearestRegion(Position position) async {
    // Reverse geocoding berdasarkan koordinat Indonesia
    // Mapping sederhana untuk wilayah Indonesia berdasarkan koordinat
    final lat = position.latitude;
    final lon = position.longitude;

    // Deteksi wilayah berdasarkan koordinat umum Indonesia
    if (lat >= 3.0 && lat <= 6.0 && lon >= 95.0 && lon <= 98.0) {
      return 'Aceh';
    } else if (lat >= -0.5 && lat <= 3.5 && lon >= 98.0 && lon <= 100.5) {
      return 'Sumatera Utara';
    } else if (lat >= -1.5 && lat <= 1.5 && lon >= 100.0 && lon <= 102.5) {
      return 'Sumatera Barat';
    } else if (lat >= -3.5 && lat <= -0.5 && lon >= 100.5 && lon <= 104.5) {
      return 'Riau';
    } else if (lat >= -4.0 && lat <= -1.5 && lon >= 103.0 && lon <= 106.0) {
      return 'Jambi';
    } else if (lat >= -5.5 && lat <= -2.0 && lon >= 102.0 && lon <= 105.5) {
      return 'Sumatera Selatan';
    } else if (lat >= -6.5 && lat <= -3.5 && lon >= 103.5 && lon <= 106.5) {
      return 'Lampung';
    } else if (lat >= -7.0 && lat <= -5.0 && lon >= 105.0 && lon <= 107.5) {
      return 'Banten';
    } else if (lat >= -7.5 && lat <= -5.5 && lon >= 106.5 && lon <= 108.0) {
      return 'Jakarta';
    } else if (lat >= -8.0 && lat <= -5.5 && lon >= 106.5 && lon <= 109.0) {
      return 'Jawa Barat';
    } else if (lat >= -8.5 && lat <= -6.5 && lon >= 108.0 && lon <= 111.0) {
      return 'Jawa Tengah';
    } else if (lat >= -8.5 && lat <= -6.5 && lon >= 110.0 && lon <= 113.0) {
      return 'Jawa Timur';
    } else if (lat >= -9.0 && lat <= -8.0 && lon >= 115.0 && lon <= 116.0) {
      return 'Bali';
    } else if (lat >= -9.5 && lat <= -8.0 && lon >= 116.0 && lon <= 120.0) {
      return 'Nusa Tenggara Barat';
    } else if (lat >= -11.0 && lat <= -8.0 && lon >= 118.0 && lon <= 125.0) {
      return 'Nusa Tenggara Timur';
    } else if (lat >= -4.0 && lat <= 2.0 && lon >= 108.5 && lon <= 115.5) {
      return 'Kalimantan Barat';
    } else if (lat >= -3.5 && lat <= 2.5 && lon >= 113.0 && lon <= 118.0) {
      return 'Kalimantan Tengah';
    } else if (lat >= -4.5 && lat <= 2.0 && lon >= 115.0 && lon <= 119.5) {
      return 'Kalimantan Selatan';
    } else if (lat >= -2.0 && lat <= 4.5 && lon >= 115.0 && lon <= 119.5) {
      return 'Kalimantan Timur';
    } else if (lat >= 0.0 && lat <= 5.0 && lon >= 116.0 && lon <= 119.5) {
      return 'Kalimantan Utara';
    } else if (lat >= -6.5 && lat <= 2.0 && lon >= 118.0 && lon <= 125.0) {
      return 'Sulawesi';
    } else if (lat >= -4.0 && lat <= 2.5 && lon >= 125.0 && lon <= 135.0) {
      return 'Maluku';
    } else if (lat >= -9.5 && lat <= 0.5 && lon >= 130.0 && lon <= 141.5) {
      return 'Papua';
    } else {
      return 'Indonesia (${lat.toStringAsFixed(2)}, ${lon.toStringAsFixed(2)})';
    }
  }
}
