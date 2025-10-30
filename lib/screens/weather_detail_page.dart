import 'package:flutter/material.dart';
import '../models/weather_data.dart';

class WeatherDetailPage extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherDetailPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade400,
                Colors.green.shade300,
                Colors.green.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Image.asset('assets/LOGO.png', height: 40, width: 40),
                const SizedBox(width: 8),
                Text(
                  'Detail Cuaca - ${weatherData.region}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      // Add notification functionality
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud,
                      size: 64,
                      color: _getRainfallColor(weatherData.rainfall),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      weatherData.region,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${weatherData.month} ${weatherData.year}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Rainfall Information
            _buildInfoCard(
              'Curah Hujan',
              '${weatherData.rainfall} mm',
              Icons.water_drop,
              _getRainfallColor(weatherData.rainfall),
              _getRainfallDescription(weatherData.rainfall),
            ),

            const SizedBox(height: 16),

            // Rainy Days Information
            _buildInfoCard(
              'Hari Hujan',
              '${weatherData.rainyDays} hari',
              Icons.calendar_today,
              Colors.blue,
              _getRainyDaysDescription(weatherData.rainyDays),
            ),

            const SizedBox(height: 20),

            // Additional Information
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Tambahan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAdditionalInfo(
                      'Kategori Curah Hujan',
                      _getRainfallCategory(weatherData.rainfall),
                    ),
                    _buildAdditionalInfo(
                      'Frekuensi Hujan',
                      _getRainyDaysCategory(weatherData.rainyDays),
                    ),
                    _buildAdditionalInfo('Bulan', weatherData.month),
                    _buildAdditionalInfo('Tahun', weatherData.year.toString()),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tips Section
            Card(
              elevation: 2,
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tips Pendakian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A4D3A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getHikingTips(
                        weatherData.rainfall,
                        weatherData.rainyDays,
                      ),
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String description,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Color _getRainfallColor(double rainfall) {
    if (rainfall < 100) {
      return Colors.blue[200]!;
    } else if (rainfall < 200) {
      return Colors.blue[400]!;
    } else {
      return Colors.blue[800]!;
    }
  }

  String _getRainfallDescription(double rainfall) {
    if (rainfall < 100) {
      return 'Curah hujan rendah';
    } else if (rainfall < 200) {
      return 'Curah hujan sedang';
    } else {
      return 'Curah hujan tinggi';
    }
  }

  String _getRainyDaysDescription(int rainyDays) {
    if (rainyDays < 10) {
      return 'Hari hujan sedikit';
    } else if (rainyDays < 15) {
      return 'Hari hujan sedang';
    } else {
      return 'Hari hujan banyak';
    }
  }

  String _getRainfallCategory(double rainfall) {
    if (rainfall < 100) {
      return 'Rendah';
    } else if (rainfall < 200) {
      return 'Sedang';
    } else {
      return 'Tinggi';
    }
  }

  String _getRainyDaysCategory(int rainyDays) {
    if (rainyDays < 10) {
      return 'Rendah';
    } else if (rainyDays < 15) {
      return 'Sedang';
    } else {
      return 'Tinggi';
    }
  }

  String _getHikingTips(double rainfall, int rainyDays) {
    if (rainfall > 200 || rainyDays > 15) {
      return 'Kondisi cuaca cukup ekstrem. Pertimbangkan untuk menunda pendakian atau bersiap dengan peralatan anti-hujan yang memadai. Periksa kondisi jalur dan pastikan memiliki rute alternatif.';
    } else if (rainfall > 100 || rainyDays > 10) {
      return 'Kondisi cuaca cukup basah. Pastikan membawa jas hujan, sepatu anti-air, dan peralatan pendukung lainnya. Perhatikan kondisi tanah yang mungkin licin.';
    } else {
      return 'Kondisi cuaca cukup baik untuk pendakian. Tetap waspada terhadap perubahan cuaca mendadak dan bawa peralatan dasar sebagai persiapan.';
    }
  }
}
