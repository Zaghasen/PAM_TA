import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:math' as math;

enum KeamananCategory { sos, kompas }

class KeamananPage extends StatefulWidget {
  const KeamananPage({super.key});

  @override
  State<KeamananPage> createState() => _KeamananPageState();
}

class _KeamananPageState extends State<KeamananPage> {
  KeamananCategory selectedCategory = KeamananCategory.sos;
  bool _isSOSPressed = false;

  Map<String, dynamic> _getCategoryData(KeamananCategory category) {
    switch (category) {
      case KeamananCategory.sos:
        return {'icon': Icons.warning, 'label': 'SOS', 'color': Colors.red};
      case KeamananCategory.kompas:
        return {'icon': Icons.explore, 'label': 'Kompas', 'color': Colors.blue};
    }
  }

  Future<void> _sendSOSNotification() async {
    // Request notification permission first
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      // Request permission
      isAllowed = await AwesomeNotifications()
          .requestPermissionToSendNotifications();

      if (!isAllowed) {
        // Permission denied, show dialog
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(child: Text('Izin Diperlukan')),
                ],
              ),
              content: const Text(
                'Aplikasi memerlukan izin notifikasi untuk mengirim sinyal SOS darurat. '
                'Silakan aktifkan notifikasi di pengaturan aplikasi.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Nanti'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    AwesomeNotifications().showNotificationConfigPage();
                  },
                  child: const Text('Buka Pengaturan'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    // Send notification
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'alerts',
          title: '🚨 SINYAL SOS DARURAT!',
          body:
              'Permintaan bantuan darurat telah dikirim. Tim penyelamat akan segera menghubungi Anda. Tetap tenang dan tunggu di lokasi Anda.',
          notificationLayout: NotificationLayout.BigText,
          color: Colors.red,
          backgroundColor: Colors.white,
          criticalAlert: true,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          autoDismissible: false,
          ticker: 'SOS Emergency Alert',
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'CANCEL_SOS',
            label: 'Batalkan SOS',
            color: Colors.orange,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'SHARE_LOCATION',
            label: 'Bagikan Lokasi',
            color: Colors.green,
            autoDismissible: false,
          ),
        ],
      );
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Gagal mengirim notifikasi: ${e.toString()}'),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

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
                  'Keamanan',
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
      body: Column(
        children: [
          // Category filter tabs
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: KeamananCategory.values.map((category) {
                final isSelected = selectedCategory == category;
                final categoryData = _getCategoryData(category);

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  categoryData['color'] as Color,
                                  (categoryData['color'] as Color).withOpacity(
                                    0.8,
                                  ),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey.shade100,
                                  Colors.grey.shade200,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: (categoryData['color'] as Color)
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            categoryData['icon'] as IconData,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categoryData['label'] as String,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: selectedCategory == KeamananCategory.sos
                ? _buildSOSView()
                : _buildKompasView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSOSView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isSOSPressed = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _isSOSPressed = false;
                });
              },
              onTapCancel: () {
                setState(() {
                  _isSOSPressed = false;
                });
              },
              onTap: () async {
                // Kirim notifikasi SOS
                await _sendSOSNotification();

                // Tampilkan dialog konfirmasi
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'SOS Terkirim!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sinyal darurat Anda telah dikirim!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              '✓ Notifikasi terkirim ke sistem\n'
                              '✓ Tim penyelamat telah diberitahu\n'
                              '✓ Lokasi Anda sedang dilacak\n'
                              '✓ Bantuan akan segera datang',
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Harap tetap tenang dan tunggu di lokasi Anda.',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Mengerti',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _isSOSPressed ? 240 : 250,
                height: _isSOSPressed ? 190 : 200,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.red.shade600, Colors.red.shade800],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(_isSOSPressed ? 0.4 : 0.6),
                      blurRadius: _isSOSPressed ? 20 : 30,
                      spreadRadius: _isSOSPressed ? 5 : 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.emergency,
                        color: Colors.white,
                        size: 60,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _isSOSPressed ? 44 : 48,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Apakah Anda Sedang Dalam Bahaya?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange.shade200, width: 2),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Tekan untuk mengirim SOS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Notifikasi darurat akan dikirim dan\nbantuan akan segera datang',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKompasView() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Error mengakses kompas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Perangkat Anda mungkin tidak memiliki sensor kompas',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        double? direction = snapshot.data?.heading;

        if (direction == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.explore_off, size: 80, color: Colors.orange),
                const SizedBox(height: 20),
                const Text(
                  'Kompas tidak tersedia',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Pastikan sensor kompas perangkat Anda aktif',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Konversi ke radian untuk rotasi
        double directionInRadians = (direction * (math.pi / 180)) * -1;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Rotating compass face
                    Transform.rotate(
                      angle: directionInRadians,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer ring markings
                          ...List.generate(12, (index) {
                            final angle = index * 30.0;
                            return Transform.rotate(
                              angle: angle * math.pi / 180,
                              child: Container(
                                width: 2,
                                height: 20,
                                color: Colors.black,
                                margin: const EdgeInsets.only(top: 130),
                              ),
                            );
                          }),
                          // Compass directions
                          const Positioned(
                            top: 30,
                            child: Text(
                              'N',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                shadows: [
                                  Shadow(
                                    color: Color(0x80000000),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 30,
                            child: Text(
                              'S',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    color: Color(0x80000000),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 30,
                            child: Text(
                              'W',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    color: Color(0x80000000),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Positioned(
                            right: 30,
                            child: Text(
                              'E',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    color: Color(0x80000000),
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Static compass needle (always points up/north)
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: CompassNeedlePainter(),
                    ),
                    // Center dot
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Direction indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.navigation,
                          color: Colors.blue,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${direction.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getCardinalDirection(direction),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kompas Digital',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  shadows: [
                    Shadow(
                      color: Color(0x4D000000),
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.green.shade200, width: 1),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Colors.green, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Putar perangkat untuk melihat arah',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getCardinalDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) return 'Utara';
    if (heading >= 22.5 && heading < 67.5) return 'Timur Laut';
    if (heading >= 67.5 && heading < 112.5) return 'Timur';
    if (heading >= 112.5 && heading < 157.5) return 'Tenggara';
    if (heading >= 157.5 && heading < 202.5) return 'Selatan';
    if (heading >= 202.5 && heading < 247.5) return 'Barat Daya';
    if (heading >= 247.5 && heading < 292.5) return 'Barat';
    if (heading >= 292.5 && heading < 337.5) return 'Barat Laut';
    return 'Unknown';
  }
}

// Custom painter untuk jarum kompas
class CompassNeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final needleLength = size.height / 2 - 10;

    // Jarum utara (merah)
    paint.color = Colors.red;
    final northPath = Path();
    northPath.moveTo(center.dx, center.dy - needleLength);
    northPath.lineTo(center.dx - 8, center.dy);
    northPath.lineTo(center.dx + 8, center.dy);
    northPath.close();
    canvas.drawPath(northPath, paint);

    // Jarum selatan (putih dengan border hitam)
    paint.color = Colors.white;
    final southPath = Path();
    southPath.moveTo(center.dx, center.dy + needleLength);
    southPath.lineTo(center.dx - 8, center.dy);
    southPath.lineTo(center.dx + 8, center.dy);
    southPath.close();
    canvas.drawPath(southPath, paint);

    // Border untuk jarum selatan
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5;
    canvas.drawPath(southPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
