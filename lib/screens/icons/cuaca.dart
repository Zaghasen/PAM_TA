import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../models/weather_data.dart';
import '../../services/weather_service.dart';
import 'details/weather_detail_page.dart';

class WeatherProvider extends ChangeNotifier {
  List<WeatherData> _weatherData = [];
  bool _isLoading = false;
  String? _selectedMonth;
  int? _selectedYear;

  List<WeatherData> get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get selectedMonth => _selectedMonth;
  int? get selectedYear => _selectedYear;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _weatherData = await _weatherService.fetchWeatherData(
        month: _selectedMonth,
        year: _selectedYear,
      );
    } catch (e) {
      // Handle error - untuk sekarang, gunakan mock data
      _weatherData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setFilters({String? month, int? year}) {
    _selectedMonth = month;
    _selectedYear = year;
    fetchWeatherData();
  }

  void clearFilters() {
    _selectedMonth = null;
    _selectedYear = null;
    fetchWeatherData();
  }
}

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  @override
  void initState() {
    super.initState();
    // Fetch data saat pertama kali load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cuaca - Curah Hujan Indonesia',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2A4D3A),
        ),
        body: Column(
          children: [
            // Filter Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<WeatherProvider>(
                      builder: (context, provider, child) {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Bulan',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: provider.selectedMonth,
                          items: WeatherService.months.map((month) {
                            return DropdownMenuItem(
                              value: month,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (value) {
                            provider.setFilters(
                              month: value,
                              year: provider.selectedYear,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Consumer<WeatherProvider>(
                      builder: (context, provider, child) {
                        return DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Tahun',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: provider.selectedYear,
                          items: WeatherService.getYears().map((year) {
                            return DropdownMenuItem(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            provider.setFilters(
                              month: provider.selectedMonth,
                              year: value,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherProvider>().clearFilters();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A4D3A),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
            // Map and List Section
            Expanded(
              child: Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      // Map Section
                      SizedBox(
                        height: 300,
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                              -2.5489,
                              118.0149,
                            ), // Center Indonesia
                            zoom: 5.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            // WMS Layer dari BMKG (untuk implementasi penuh)
                            // TileLayer(
                            //   wmsOptions: WMSTileLayerOptions(
                            //     baseUrl: WeatherService.bmkgWmsUrl,
                            //     layers: ['0'], // Layer curah hujan
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // Weather Data List
                      Expanded(
                        child: provider.weatherData.isEmpty
                            ? const Center(
                                child: Text('Tidak ada data cuaca tersedia'),
                              )
                            : ListView.builder(
                                itemCount: provider.weatherData.length,
                                itemBuilder: (context, index) {
                                  final data = provider.weatherData[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.cloud,
                                        color: _getRainfallColor(data.rainfall),
                                        size: 40,
                                      ),
                                      title: Text(
                                        data.region,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data.month} ${data.year}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.water_drop,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text('${data.rainfall} mm'),
                                              const SizedBox(width: 16),
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${data.rainyDays} hari hujan',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey[400],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WeatherDetailPage(
                                                  weatherData: data,
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRainfallColor(double rainfall) {
    if (rainfall < 100) {
      return Colors.blue[200]!; // Rendah
    } else if (rainfall < 200) {
      return Colors.blue[400]!; // Sedang
    } else {
      return Colors.blue[800]!; // Tinggi
    }
  }
}
