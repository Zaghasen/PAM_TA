import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tapak_jejak/data/mock_outlet_data.dart';
import 'package:tapak_jejak/models/outlet.dart';
import 'package:tapak_jejak/screens/fitur/sewa_alat/outlet_detail_page.dart';

class SewaAlatMapsPage extends StatefulWidget {
  const SewaAlatMapsPage({super.key});

  @override
  State<SewaAlatMapsPage> createState() => _SewaAlatMapsPageState();
}

class _SewaAlatMapsPageState extends State<SewaAlatMapsPage> {
  final List<Outlet> outlets = MockOutletData.getAllOutlets();
  Outlet? selectedOutlet;

  // Simulasi user location (nanti bisa pakai geolocator)
  final double userLat = -7.9666; // Malang
  final double userLng = 112.6326;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Sewa Alat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Filter dialog
                  _showFilterDialog();
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Map placeholder (nanti bisa pakai Google Maps / OpenStreetMap)
          _buildMapPlaceholder(),

          // Info card current location
          Positioned(top: 16, left: 16, right: 16, child: _buildLocationCard()),

          // Bottom sheet outlet list
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.store_rounded,
                            color: Color(0xFF2A4D3A),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${outlets.length} Outlet Tersedia',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Outlet list
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: outlets.length,
                        itemBuilder: (context, index) {
                          final outlet = outlets[index];
                          return _buildOutletCard(outlet);
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

  Widget _buildMapPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: CustomPaint(
        painter: MapPainter(
          outlets: outlets,
          userLat: userLat,
          userLng: userLng,
          selectedOutlet: selectedOutlet,
          onOutletTap: (outlet) {
            setState(() {
              selectedOutlet = outlet;
            });
          },
        ),
        child: Container(),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.my_location_rounded,
              color: Colors.green.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lokasi Anda',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Malang, Jawa Timur',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A4D3A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutletCard(Outlet outlet) {
    final distance = outlet.distanceFrom(userLat, userLng);
    final isOpen = outlet.isOpenNow();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OutletDetailPage(outlet: outlet),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selectedOutlet?.id == outlet.id
                ? Color(0xFF2A4D3A)
                : Colors.grey.shade200,
            width: selectedOutlet?.id == outlet.id ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        outlet.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A4D3A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${distance.toStringAsFixed(1)} km',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: Colors.amber.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${outlet.rating} (${outlet.reviewCount})',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isOpen ? Colors.green.shade50 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: isOpen
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isOpen
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: outlet.brands.take(3).map((brand) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Text(
                    brand,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Filter Outlet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Buka Sekarang'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Terdekat (< 5km)'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Rating > 4.5'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Apply filter
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2A4D3A)),
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );
  }
}

// Custom painter for map visualization
class MapPainter extends CustomPainter {
  final List<Outlet> outlets;
  final double userLat;
  final double userLng;
  final Outlet? selectedOutlet;
  final Function(Outlet) onOutletTap;

  MapPainter({
    required this.outlets,
    required this.userLat,
    required this.userLng,
    required this.selectedOutlet,
    required this.onOutletTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw simple grid for map effect
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    for (var i = 0; i < 20; i++) {
      canvas.drawLine(
        Offset(0, size.height * i / 20),
        Offset(size.width, size.height * i / 20),
        gridPaint,
      );
      canvas.drawLine(
        Offset(size.width * i / 20, 0),
        Offset(size.width * i / 20, size.height),
        gridPaint,
      );
    }

    // Draw user location
    final userPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      12,
      userPaint,
    );

    // Draw markers for outlets
    for (var i = 0; i < outlets.length; i++) {
      final outlet = outlets[i];
      final angle = (i / outlets.length) * 2 * math.pi;
      final radius = math.min(size.width, size.height) * 0.3;

      final x = size.width * 0.5 + math.cos(angle) * radius;
      final y = size.height * 0.5 + math.sin(angle) * radius;

      final markerPaint = Paint()
        ..color = selectedOutlet?.id == outlet.id
            ? Color(0xFF2A4D3A)
            : Colors.red.shade400
        ..style = PaintingStyle.fill;

      // Draw marker pin shape
      final path = Path();
      path.moveTo(x, y - 20);
      path.lineTo(x - 10, y - 35);
      path.lineTo(x + 10, y - 35);
      path.close();

      canvas.drawPath(path, markerPaint);
      canvas.drawCircle(Offset(x, y - 35), 8, markerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
