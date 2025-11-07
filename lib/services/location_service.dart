import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.location.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      bool hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  Future<String> getLocationName(double latitude, double longitude) async {
    // Simple reverse geocoding - in real app, use geocoding service
    // For demo, return coordinates as string
    return '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
  }

  Future<String?> getNearestRegion(Position position) async {
    // Mock implementation - in real app, use reverse geocoding API
    // or match with weather data regions
    return 'Daerah Terdekat (${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)})';
  }
}
