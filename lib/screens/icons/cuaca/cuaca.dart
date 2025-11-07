import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../../models/weather_data.dart';
import '../../../services/weather_service.dart';
import '../../../services/location_service.dart';
import 'cuaca_detail_page.dart';

class WeatherProvider extends ChangeNotifier {
  List<WeatherData> _weatherData = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _selectedMonth;
  int? _selectedYear;
  int _currentPage = 0;
  static const int _pageSize = 20;
  bool _hasMore = true;
  List<WeatherData> _allFilteredData = [];

  List<WeatherData> get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get selectedMonth => _selectedMonth;
  int? get selectedYear => _selectedYear;
  bool get hasMore => _hasMore;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    _currentPage = 0;
    _hasMore = true;
    notifyListeners();

    try {
      _allFilteredData = await _weatherService.fetchWeatherData(
        month: _selectedMonth,
        year: _selectedYear,
      );
      _weatherData = _allFilteredData.take(_pageSize).toList();
      _hasMore = _allFilteredData.length > _pageSize;
    } catch (e) {
      // Handle error - untuk sekarang, gunakan mock data
      _allFilteredData = [];
      _weatherData = [];
      _hasMore = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreData() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay

    int nextPage = _currentPage + 1;
    int startIndex = nextPage * _pageSize;
    int endIndex = startIndex + _pageSize;

    if (startIndex < _allFilteredData.length) {
      List<WeatherData> newData = _allFilteredData.sublist(
        startIndex,
        endIndex > _allFilteredData.length ? _allFilteredData.length : endIndex,
      );
      _weatherData.addAll(newData);
      _currentPage = nextPage;
      _hasMore = endIndex < _allFilteredData.length;
    } else {
      _hasMore = false;
    }

    _isLoadingMore = false;
    notifyListeners();
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
  String _searchQuery = '';
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  // Buat instance Provider sebagai variabel di dalam State
  late WeatherProvider _weatherProvider;

  // Location-based services
  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  String? _currentLocationName;
  bool _isLocationLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    // Inisialisasi Provider di sini (hanya sekali)
    _weatherProvider = WeatherProvider();

    // Panggil fetch data langsung dari instance
    _weatherProvider.fetchWeatherData();

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    // Jangan lupa dispose Provider-nya juga!
    _weatherProvider.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _weatherProvider.loadMoreData();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLocationLoading = true;
    });

    try {
      _currentPosition = await _locationService.getCurrentPosition();
      if (_currentPosition != null) {
        _currentLocationName = await _locationService.getLocationName(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );
      }
    } catch (e) {
      // Handle error - bisa tambahkan snackbar atau dialog
      print('Error getting location: $e');
    } finally {
      setState(() {
        _isLocationLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan 'ChangeNotifierProvider.value' untuk menyediakan instance yang sudah ada
    return ChangeNotifierProvider<WeatherProvider>.value(
      value: _weatherProvider,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                    'Cuaca',
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
        body: Container(
          color: Colors.grey.shade50,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      // Hero Header Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.fromLTRB(
                          20.0,
                          120.0,
                          20.0,
                          20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2E7D32,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    '🌤️',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pantau Cuaca',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2A4D3A),
                                        ),
                                      ),
                                      Text(
                                        'Curah Hujan Indonesia',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // Location-based weather section
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E7D32).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xFF2E7D32),
                                    size: 14,
                                  ),
                                  SizedBox(width: 5),
                                  if (_isLocationLoading)
                                    SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    )
                                  else if (_currentLocationName != null)
                                    Expanded(
                                      child: Text(
                                        'Cuaca di $_currentLocationName',
                                        style: TextStyle(
                                          color: Color(0xFF2E7D32),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: _getCurrentLocation,
                                      child: Text(
                                        'Aktifkan Lokasi',
                                        style: TextStyle(
                                          color: Color(0xFF2E7D32),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Map Section with Title
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2E7D32,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.map,
                                    color: Color(0xFF2E7D32),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Peta Curah Hujan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2A4D3A),
                                        ),
                                      ),
                                      Text(
                                        'Visualisasi data cuaca Indonesia',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://zoom.earth/places/indonesia',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          color: Colors.grey.shade200,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.map,
                                              size: 48,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Peta Cuaca Indonesia',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Gagal memuat peta',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Filter Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2E7D32,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.filter_list,
                                    color: Color(0xFF2E7D32),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Filter Data Cuaca',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2A4D3A),
                                        ),
                                      ),
                                      Text(
                                        'Pilih bulan dan tahun',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Consumer<WeatherProvider>(
                                        builder: (context, provider, child) {
                                          return DropdownButtonFormField<
                                            String
                                          >(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade50,
                                              hintText: 'Pilih bulan',
                                              prefixIcon: const Icon(
                                                Icons.calendar_view_month,
                                                color: Color(0xFF2E7D32),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 12,
                                                  ),
                                            ),
                                            initialValue:
                                                provider.selectedMonth,
                                            items: WeatherService.months.map((
                                              month,
                                            ) {
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
                                      const SizedBox(height: 8),
                                      Consumer<WeatherProvider>(
                                        builder: (context, provider, child) {
                                          return DropdownButtonFormField<int>(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade50,
                                              hintText: 'Pilih tahun',
                                              prefixIcon: const Icon(
                                                Icons.date_range,
                                                color: Color(0xFF2E7D32),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 12,
                                                  ),
                                            ),
                                            initialValue: provider.selectedYear,
                                            items: WeatherService.getYears()
                                                .map((year) {
                                                  return DropdownMenuItem(
                                                    value: year,
                                                    child: Text(
                                                      year.toString(),
                                                    ),
                                                  );
                                                })
                                                .toList(),
                                            onChanged: (value) {
                                              provider.setFilters(
                                                month: provider.selectedMonth,
                                                year: value,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<WeatherProvider>()
                                          .clearFilters();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2E7D32),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Weather Data List Section
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        constraints: const BoxConstraints(
                          minHeight: 400,
                          maxHeight: 600,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF2E7D32,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.list,
                                      color: Color(0xFF2E7D32),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Data Cuaca Daerah',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2A4D3A),
                                          ),
                                        ),
                                        Text(
                                          'Detail curah hujan per wilayah',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Search Bar
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Cari daerah...',
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF2E7D32),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Consumer<WeatherProvider>(
                                builder: (context, provider, child) {
                                  if (provider.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final filteredData = provider.weatherData
                                      .where(
                                        (data) =>
                                            data.region.toLowerCase().contains(
                                              _searchQuery.toLowerCase(),
                                            ),
                                      )
                                      .toList();

                                  return filteredData.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'Tidak ada data cuaca tersedia',
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                    ),
                                                itemCount: filteredData.length,
                                                itemBuilder: (context, index) {
                                                  final data =
                                                      filteredData[index];
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 12,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white,
                                                          Colors.grey.shade50,
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                0.05,
                                                              ),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                            16,
                                                          ),
                                                      leading: Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              _getRainfallColor(
                                                                data.rainfall,
                                                              ).withOpacity(
                                                                0.1,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Icon(
                                                          _getWeatherIcon(
                                                            data.rainfall,
                                                          ),
                                                          color:
                                                              _getRainfallColor(
                                                                data.rainfall,
                                                              ),
                                                          size: 30,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        data.region,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Color(
                                                            0xFF2A4D3A,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            '${data.month} ${data.year}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blue
                                                                      .withOpacity(
                                                                        0.1,
                                                                      ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .water_drop,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Text(
                                                                      '${data.rainfall} mm',
                                                                      style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .orange
                                                                      .withOpacity(
                                                                        0.1,
                                                                      ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Text(
                                                                      '${data.rainyDays} hari',
                                                                      style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFF2E7D32,
                                                          ).withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Color(
                                                            0xFF2E7D32,
                                                          ),
                                                          size: 16,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                WeatherDetailPage(
                                                                  weatherData:
                                                                      data,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            if (provider.isLoadingMore)
                                              const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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

  IconData _getWeatherIcon(double rainfall) {
    if (rainfall < 50) {
      return Icons.wb_sunny; // Cerah
    } else if (rainfall < 100) {
      return Icons.cloud; // Sedikit awan
    } else if (rainfall < 200) {
      return Icons.grain; // Hujan ringan
    } else {
      return Icons.thunderstorm; // Hujan lebat
    }
  }
}
