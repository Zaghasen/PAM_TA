import 'package:flutter/material.dart';
import 'dart:math';
import '../../../models/weather_data.dart';

class WeatherDetailPage extends StatefulWidget {
  final WeatherData weatherData;

  const WeatherDetailPage({super.key, required this.weatherData});

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Mock additional weather data
  late double temperature;
  late double humidity;
  late double windSpeed;
  late double pressure;
  late String weatherCondition;
  late int uvIndex;
  late double visibility;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    // Generate mock weather data based on rainfall
    _generateMockWeatherData();
  }

  void _generateMockWeatherData() {
    final random = Random();
    final rainfall = widget.weatherData.rainfall;

    // Temperature based on rainfall (higher rainfall = lower temp)
    temperature = 25 + random.nextDouble() * 10 - (rainfall / 20);

    // Humidity based on rainfall
    humidity = 60 + (rainfall / 2) + random.nextDouble() * 20;

    // Wind speed
    windSpeed = 5 + random.nextDouble() * 15;

    // Pressure
    pressure = 1005 + random.nextDouble() * 20;

    // UV Index
    uvIndex = 3 + random.nextInt(7);

    // Visibility
    visibility = 8 + random.nextDouble() * 7;

    // Weather condition based on rainfall
    if (rainfall < 50) {
      weatherCondition = 'Cerah';
    } else if (rainfall < 100) {
      weatherCondition = 'Berawan';
    } else if (rainfall < 200) {
      weatherCondition = 'Hujan Ringan';
    } else {
      weatherCondition = 'Hujan Lebat';
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getWeatherColor() {
    switch (weatherCondition) {
      case 'Cerah':
        return Colors.orange;
      case 'Berawan':
        return Colors.grey;
      case 'Hujan Ringan':
        return Colors.blue;
      case 'Hujan Lebat':
        return Colors.indigo;
      default:
        return Colors.green;
    }
  }

  IconData _getWeatherIcon() {
    switch (weatherCondition) {
      case 'Cerah':
        return Icons.wb_sunny;
      case 'Berawan':
        return Icons.cloud;
      case 'Hujan Ringan':
        return Icons.grain;
      case 'Hujan Lebat':
        return Icons.thunderstorm;
      default:
        return Icons.wb_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.weatherData.region,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getWeatherColor().withOpacity(0.8),
              _getWeatherColor().withOpacity(0.4),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Main Weather Card
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Weather Icon and Temperature
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _getWeatherColor().withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getWeatherIcon(),
                              size: 80,
                              color: _getWeatherColor(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                          Text(
                            weatherCondition,
                            style: TextStyle(
                              fontSize: 20,
                              color: _getWeatherColor(),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${widget.weatherData.month} ${widget.weatherData.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Weather Details Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      children: [
                        _buildWeatherDetailCard(
                          'Curah Hujan',
                          '${widget.weatherData.rainfall} mm',
                          Icons.water_drop,
                          Colors.blue,
                        ),
                        _buildWeatherDetailCard(
                          'Hari Hujan',
                          '${widget.weatherData.rainyDays} hari',
                          Icons.calendar_today,
                          Colors.orange,
                        ),
                        _buildWeatherDetailCard(
                          'Kelembaban',
                          '${humidity.toStringAsFixed(0)}%',
                          Icons.opacity,
                          Colors.teal,
                        ),
                        _buildWeatherDetailCard(
                          'Kecepatan Angin',
                          '${windSpeed.toStringAsFixed(1)} km/h',
                          Icons.air,
                          Colors.green,
                        ),
                        _buildWeatherDetailCard(
                          'Tekanan Udara',
                          '${pressure.toStringAsFixed(0)} hPa',
                          Icons.compress,
                          Colors.purple,
                        ),
                        _buildWeatherDetailCard(
                          'Visibilitas',
                          '${visibility.toStringAsFixed(1)} km',
                          Icons.visibility,
                          Colors.indigo,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // UV Index Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                color: Colors.orange,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Indeks UV: $uvIndex',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          LinearProgressIndicator(
                            value: uvIndex / 11, // Max UV index is around 11
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getUVColor(uvIndex),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _getUVDescription(uvIndex),
                            style: TextStyle(
                              color: _getUVColor(uvIndex),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Weather Tips Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.lightbulb,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Tips Cuaca',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _getWeatherTips(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetailCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A4D3A),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getUVColor(int uvIndex) {
    if (uvIndex <= 2) return Colors.green;
    if (uvIndex <= 5) return Colors.yellow;
    if (uvIndex <= 7) return Colors.orange;
    if (uvIndex <= 10) return Colors.red;
    return Colors.purple;
  }

  String _getUVDescription(int uvIndex) {
    if (uvIndex <= 2) return 'Rendah - Aman untuk aktivitas outdoor';
    if (uvIndex <= 5) return 'Sedang - Gunakan tabir surya';
    if (uvIndex <= 7) return 'Tinggi - Lindungi kulit dan mata';
    if (uvIndex <= 10) return 'Sangat Tinggi - Hindari paparan sinar matahari';
    return 'Ekstrem - Tetap di dalam ruangan';
  }

  String _getWeatherTips() {
    switch (weatherCondition) {
      case 'Cerah':
        return 'Cuaca cerah sangat cocok untuk aktivitas outdoor. Jangan lupa gunakan tabir surya dan tetap terhidrasi dengan baik.';
      case 'Berawan':
        return 'Cuaca berawan memberikan suasana yang nyaman. Tetap waspada terhadap perubahan cuaca yang tiba-tiba.';
      case 'Hujan Ringan':
        return 'Hujan ringan dapat menyegarkan udara. Bawa payung atau jas hujan saat beraktivitas di luar ruangan.';
      case 'Hujan Lebat':
        return 'Hujan lebat dapat menyebabkan banjir. Hindari perjalanan jika tidak mendesak dan pastikan saluran air tidak tersumbat.';
      default:
        return 'Pantau terus perkembangan cuaca dan persiapkan diri dengan baik untuk berbagai kondisi.';
    }
  }
}
