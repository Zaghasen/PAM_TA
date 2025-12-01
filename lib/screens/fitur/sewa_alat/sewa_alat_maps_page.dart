import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/mock_outlet_data.dart';
import '../../../models/outlet.dart';
import 'outlet_detail_page.dart';

class SewaAlatMapsPage extends StatefulWidget {
  const SewaAlatMapsPage({super.key});

  @override
  State<SewaAlatMapsPage> createState() => _SewaAlatMapsPageState();
}

class _SewaAlatMapsPageState extends State<SewaAlatMapsPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  Position? _currentPosition;
  bool _isLoadingLocation = true;
  List<Outlet> _outlets = [];
  Set<Marker> _markers = {};
  String _selectedFilter = 'Semua';
  Outlet? _selectedOutlet;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-7.7526, 110.4085), // Seturan, Jogjakarta
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _loadOutlets();
    _getCurrentLocation();
  }

  void _loadOutlets() {
    setState(() {
      _outlets = MockOutletData.getAllOutlets();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Izin lokasi ditolak');
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError(
          'Izin lokasi ditolak permanen. Silakan aktifkan di pengaturan.',
        );
        setState(() => _isLoadingLocation = false);
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });

      // Move camera to user location
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
        ),
      );

      // Update markers with distances
      _updateMarkers();

      // Listen to location changes
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Update every 10 meters
        ),
      ).listen((Position position) {
        setState(() {
          _currentPosition = position;
        });
        _updateMarkers();
      });
    } catch (e) {
      _showError('Gagal mendapatkan lokasi: $e');
      setState(() => _isLoadingLocation = false);
    }
  }

  void _updateMarkers() {
    if (_currentPosition == null) return;

    Set<Marker> markers = {};

    // Add user location marker
    markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Lokasi Anda'),
      ),
    );

    // Add outlet markers
    for (var outlet in _getFilteredOutlets()) {
      markers.add(
        Marker(
          markerId: MarkerId('outlet_${outlet.id}'),
          position: LatLng(outlet.latitude, outlet.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: outlet.name,
            snippet:
                '${outlet.distanceFrom(_currentPosition!.latitude, _currentPosition!.longitude).toStringAsFixed(1)} km',
          ),
          onTap: () {
            setState(() {
              _selectedOutlet = outlet;
            });
          },
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  List<Outlet> _getFilteredOutlets() {
    if (_currentPosition == null) return _outlets;

    List<Outlet> filtered = _outlets;

    switch (_selectedFilter) {
      case 'Buka Sekarang':
        filtered = filtered.where((o) => o.isOpenNow()).toList();
        break;
      case 'Terdekat':
        filtered = filtered
            .where(
              (o) =>
                  o.distanceFrom(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ) <
                  5,
            )
            .toList();
        break;
      case 'Rating Tinggi':
        filtered = filtered.where((o) => o.rating >= 4.5).toList();
        break;
    }

    // Sort by distance
    filtered.sort(
      (a, b) => a
          .distanceFrom(_currentPosition!.latitude, _currentPosition!.longitude)
          .compareTo(
            b.distanceFrom(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
          ),
    );

    return filtered;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sewa Alat Outdoor'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            compassEnabled: true,
          ),

          // Loading indicator
          if (_isLoadingLocation)
            Container(
              color: Colors.black45,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Mendapatkan lokasi Anda...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

          // Filter chips
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Buka Sekarang'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Terdekat'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Rating Tinggi'),
                ],
              ),
            ),
          ),

          // Bottom sheet with outlet list
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Outlet Terdekat',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_getFilteredOutlets().length} outlet',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // Outlet list
                    Expanded(
                      child: _isLoadingLocation
                          ? const Center(child: CircularProgressIndicator())
                          : _getFilteredOutlets().isEmpty
                          ? Center(
                              child: Text(
                                'Tidak ada outlet ditemukan',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: _getFilteredOutlets().length,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                final outlet = _getFilteredOutlets()[index];
                                final distance = _currentPosition != null
                                    ? outlet.distanceFrom(
                                        _currentPosition!.latitude,
                                        _currentPosition!.longitude,
                                      )
                                    : 0.0;
                                final isSelected =
                                    _selectedOutlet?.id == outlet.id;

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFE8F5E9)
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF2E7D32)
                                          : Colors.grey[300]!,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF2E7D32,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.store,
                                        color: Color(0xFF2E7D32),
                                        size: 28,
                                      ),
                                    ),
                                    title: Text(
                                      outlet.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 14,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                '${distance.toStringAsFixed(1)} km',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.amber,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${outlet.rating}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: outlet.isOpenNow()
                                                    ? Colors.green.withOpacity(
                                                        0.1,
                                                      )
                                                    : Colors.red.withOpacity(
                                                        0.1,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                outlet.isOpenNow()
                                                    ? 'Buka'
                                                    : 'Tutup',
                                                style: TextStyle(
                                                  color: outlet.isOpenNow()
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Color(0xFF2E7D32),
                                    ),
                                    onTap: () async {
                                      // Move camera to outlet
                                      final controller =
                                          await _mapController.future;
                                      controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(
                                              outlet.latitude,
                                              outlet.longitude,
                                            ),
                                            zoom: 16.0,
                                          ),
                                        ),
                                      );

                                      setState(() {
                                        _selectedOutlet = outlet;
                                      });

                                      // Navigate to detail page
                                      if (context.mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OutletDetailPage(
                                                  outlet: outlet,
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
          _updateMarkers();
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF2E7D32).withOpacity(0.2),
      checkmarkColor: const Color(0xFF2E7D32),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      elevation: 2,
      shadowColor: Colors.black26,
    );
  }
}
