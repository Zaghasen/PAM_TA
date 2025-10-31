import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/icons/details/tiket_detail_page.dart';
import 'package:tapak_jejak/models/mountain.dart';

class TiketMasukPage extends StatefulWidget {
  const TiketMasukPage({super.key});

  @override
  State<TiketMasukPage> createState() => _TiketMasukPageState();
}

class _TiketMasukPageState extends State<TiketMasukPage> {
  String? selectedProvince;

  static String _formatCurrency(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  List<Mountain> _getFilteredMountains() {
    final List<Mountain> allMountains = [
      Mountain(
        image: 'assets/tiket_masuk/merapi.jpg',
        name: 'Gunung Merapi',
        managedBy: 'Balai Taman Nasional Gunung Merapi',
        description:
            'Gunung berapi aktif dengan pemandangan spektakuler dan jalur pendakian menantang.',
        location: 'Yogyakarta, Jawa Tengah',
        height: 2914,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/merbabu.jpg',
        name: 'Gunung Merbabu',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan panorama sunrise yang memukau dan jalur pendakian yang terjangkau.',
        location: 'Magelang, Jawa Tengah',
        height: 3145,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/lawu.jpg',
        name: 'Gunung Lawu',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung mistis dengan legenda dan pemandangan hamparan sawah yang indah.',
        location: 'Karanganyar, Jawa Timur',
        height: 3265,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/semeru.jpg',
        name: 'Gunung Semeru',
        managedBy: 'Taman Nasional Bromo Tengger Semeru',
        description:
            'Gunung tertinggi di Jawa dengan puncak Mahameru dan panorama luar biasa.',
        location: 'Lumajang, Jawa Timur',
        height: 3676,
        prices: {
          'Hari Kerja WNI': 30000,
          'Hari Kerja WNA': 200000,
          'Hari Libur WNI': 35000,
          'Hari Libur WNA': 250000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/rinjani.jpg',
        name: 'Gunung Rinjani',
        managedBy: 'Taman Nasional Gunung Rinjani',
        description:
            'Gunung dengan danau Segara Anak yang mempesona dan pendakian epik.',
        location: 'Lombok, Nusa Tenggara Barat',
        height: 3726,
        prices: {
          'Hari Kerja WNI': 25000,
          'Hari Kerja WNA': 250000,
          'Hari Libur WNI': 30000,
          'Hari Libur WNA': 300000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/slamet.jpg',
        name: 'Gunung Slamet',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan vegetasi yang masih asri dan jalur pendakian yang menantang.',
        location: 'Banyumas, Jawa Tengah',
        height: 3428,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/sindoro.jpg',
        name: 'Gunung Sindoro',
        managedBy: 'Perhutani',
        description:
            'Gunung kembar dengan Sumbing, menawarkan pendakian yang menyenangkan.',
        location: 'Temanggung, Jawa Tengah',
        height: 3135,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/sumbing.jpg',
        name: 'Gunung Sumbing',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan puncak yang landai dan pemandangan yang luas.',
        location: 'Temanggung, Jawa Tengah',
        height: 3371,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/prau.jpg',
        name: 'Gunung Prau',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan hamparan edelweis dan sunrise yang memukau.',
        location: 'Wonogiri, Jawa Tengah',
        height: 2565,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/raung.jpg',
        name: 'Gunung Raung',
        managedBy: 'Balai Taman Nasional Alas Purwo',
        description:
            'Gunung dengan kawah aktif dan hutan tropis yang masih alami.',
        location: 'Banyuwangi, Jawa Timur',
        height: 3332,
        prices: {
          'Hari Kerja WNI': 20000,
          'Hari Kerja WNA': 180000,
          'Hari Libur WNI': 25000,
          'Hari Libur WNA': 220000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/andong.jpg',
        name: 'Gunung Andong',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan pemandangan sawah terasering dan udara sejuk.',
        location: 'Boyolali, Jawa Tengah',
        height: 1726,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/buthak.jpg',
        name: 'Gunung Buthak',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan jalur pendakian yang mudah dan panorama yang indah.',
        location: 'Pati, Jawa Tengah',
        height: 1101,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/kembang.jpg',
        name: 'Gunung Kembang',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan vegetasi yang hijau dan jalur pendakian yang menyenangkan.',
        location: 'Pati, Jawa Tengah',
        height: 1275,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/pakuwaja.jpg',
        name: 'Gunung Pakuwaja',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan pemandangan laut dari puncaknya yang unik.',
        location: 'Pati, Jawa Tengah',
        height: 551,
        prices: {
          'Hari Kerja WNI': 5000,
          'Hari Kerja WNA': 50000,
          'Hari Libur WNI': 8000,
          'Hari Libur WNA': 80000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/telomoyo.jpg',
        name: 'Gunung Telomoyo',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan jalur pendakian yang landai dan cocok untuk pemula.',
        location: 'Magelang, Jawa Tengah',
        height: 1894,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/ungaran.jpg',
        name: 'Gunung Ungaran',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan hutan pinus yang rindang dan udara yang sejuk.',
        location: 'Semarang, Jawa Tengah',
        height: 2050,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/bismo.jpg',
        name: 'Gunung Bismo',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan legenda dan pemandangan yang mistis.',
        location: 'Boyolali, Jawa Tengah',
        height: 2525,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
    ];

    if (selectedProvince == null || selectedProvince == 'Semua') {
      return allMountains;
    }

    return allMountains.where((mountain) {
      return mountain.location.contains(selectedProvince!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mountains = _getFilteredMountains();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiket Masuk'),
        backgroundColor: const Color(0xFF2A4D3A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Filter Section
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2A4D3A).withOpacity(0.9),
                    Color(0xFF4A7C59).withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.95),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF2A4D3A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Filter Berdasarkan Provinsi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_getFilteredMountains().length} Gunung',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green.shade200,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Pilih Provinsi',
                          labelStyle: TextStyle(
                            color: Color(0xFF2A4D3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            backgroundColor: Colors.green.shade50.withOpacity(
                              0.7,
                            ),
                            letterSpacing: 0.5,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF2A4D3A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        value: selectedProvince,
                        style: TextStyle(
                          color: Color(0xFF2A4D3A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.white,
                        items: [
                          DropdownMenuItem(
                            value: 'Semua',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  color: Color(0xFF2A4D3A),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('Semua Provinsi'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Jawa Tengah',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF2A4D3A),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('Jawa Tengah'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Jawa Timur',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF2A4D3A),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('Jawa Timur'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Nusa Tenggara Barat',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF2A4D3A),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('Nusa Tenggara Barat'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => selectedProvince = value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Mountain List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: mountains.length,
                itemBuilder: (context, index) {
                  final mountain = mountains[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TiketDetailPage(mountain: mountain),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hero Image with Gradient Overlay
                              Stack(
                                children: [
                                  Image.asset(
                                    mountain.image,
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mountain.name,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withOpacity(
                                                  0.5,
                                                ),
                                                offset: const Offset(1, 1),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              mountain.location,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.height,
                                            size: 16,
                                            color: Color(0xFF2A4D3A),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${mountain.height} mdpl',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2A4D3A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Content Section
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Description
                                    Text(
                                      mountain.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Managed By
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.business,
                                          size: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Dikelola oleh: ${mountain.managedBy}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    // Pricing Section
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.green.shade200,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.payment,
                                                size: 20,
                                                color: const Color(0xFF2A4D3A),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Tarif Masuk',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2A4D3A),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          ...mountain.prices.entries.map((
                                            entry,
                                          ) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    entry.key,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Rp ${_formatCurrency(entry.value)}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF2A4D3A),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
