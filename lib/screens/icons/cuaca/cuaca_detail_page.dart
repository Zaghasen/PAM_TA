import 'package:flutter/material.dart';
import '../../../models/weather_data.dart';

class WeatherDetailPage extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherDetailPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cuaca - ${weatherData.region}'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherData.region,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A4D3A),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bulan: ${weatherData.month} ${weatherData.year}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Curah Hujan: ${weatherData.rainfall} mm',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Hari Hujan: ${weatherData.rainyDays} hari',
              style: const TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
