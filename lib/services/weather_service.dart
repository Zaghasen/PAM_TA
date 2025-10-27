import '../models/weather_data.dart';
import '../data/mock_weather_data.dart';

class WeatherService {
  // URL API BMKG WMS (untuk referensi, integrasi penuh memerlukan parsing XML capabilities)
  static const String bmkgWmsUrl =
      'https://gis.bmkg.go.id/arcgis/services/Peta_Curah_Hujan_dan_Hari_Hujan_/MapServer/WMSServer';

  // Menggunakan mock data sementara karena API WMS kompleks
  Future<List<WeatherData>> fetchWeatherData({String? month, int? year}) async {
    // Simulasi delay API call
    await Future.delayed(const Duration(seconds: 1));

    // Filter berdasarkan bulan dan tahun jika disediakan
    List<WeatherData> filteredData = mockWeatherData;
    if (month != null) {
      filteredData = filteredData.where((data) => data.month == month).toList();
    }
    if (year != null) {
      filteredData = filteredData.where((data) => data.year == year).toList();
    }

    return filteredData;
  }

  // Method untuk fetch dari API BMKG (untuk implementasi masa depan)
  // Future<List<WeatherData>> fetchFromBmkgApi() async {
  //   try {
  //     final response = await http.get(Uri.parse('$bmkgWmsUrl?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities'));
  //     if (response.statusCode == 200) {
  //       // Parse XML response - memerlukan library seperti xml2json
  //       // Untuk sekarang, return mock data
  //       return mockWeatherData;
  //     } else {
  //       throw Exception('Failed to load weather data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

  // Daftar bulan untuk filter
  static const List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // Daftar tahun untuk filter
  static List<int> getYears() {
    int currentYear = DateTime.now().year;
    return List.generate(5, (index) => currentYear - index);
  }
}
