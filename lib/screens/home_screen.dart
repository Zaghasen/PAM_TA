import 'package:flutter/material.dart';
import 'package:tapak_jejak/data/mock_data.dart';
import 'package:tapak_jejak/models/brand.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/all_products_page.dart';
import 'package:tapak_jejak/screens/icons/blog.dart';
import 'package:tapak_jejak/screens/icons/camping_ground.dart';
import 'package:tapak_jejak/screens/icons/cuaca.dart';
import 'package:tapak_jejak/screens/icons/eat&stay.dart';
import 'package:tapak_jejak/screens/icons/event.dart';
import 'package:tapak_jejak/screens/icons/keamanan.dart';
import 'package:tapak_jejak/screens/icons/porter&guide.dart';
import 'package:tapak_jejak/screens/icons/private&open_trip.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat.dart';
import 'package:tapak_jejak/screens/icons/tiket_masuk.dart';
import 'package:tapak_jejak/screens/icons/travel&ojek.dart';
import 'package:tapak_jejak/screens/icons/tutorial.dart';
import 'package:tapak_jejak/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback refreshCallback;
  const HomePage({super.key, required this.refreshCallback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> uniqueProducts;
  late Map<int, int> likeCounts;

  @override
  void initState() {
    super.initState();
    uniqueProducts = _getUniqueByType(mockProducts);
    likeCounts = {};
    for (var product in mockProducts) {
      likeCounts[product.id] = 13457;
    }
  }

  List<Product> _getUniqueByType(List<Product> products) {
    List<String> types = ['tenda', 'tas', 'jaket', 'sepatu', 'tp'];
    List<Product> result = [];
    for (String type in types) {
      final candidates = products
          .where((p) => p.name.toLowerCase().contains(type))
          .toList();
      if (candidates.isNotEmpty && !result.contains(candidates.first)) {
        result.add(candidates.first);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penyewaan Alat Pendakian Tapak Jejak',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                // Banner
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/banner.png', // Sesuaikan nama banner jika berbeda
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Service Icons Grid (2x4)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    children: [
                      _buildServiceIcon(
                        Icons.confirmation_number,
                        'Tiket Masuk',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TiketMasukPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.directions_car,
                        'Travel & Ojek',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TravelOjekPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.person,
                        'Porter & Guide',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PorterGuidePage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.build,
                        'Sewa Alat',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SewaAlatPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.group,
                        'Private & Open Trip',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivateOpenTripPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.terrain,
                        'Camping Ground',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CampingGroundPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.event,
                        'Event',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EventPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.restaurant,
                        'Eat & Stay',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EatStayPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Monitoring Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Pantau Kondisi Gunung Sebelum Mendaki',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: const Color(0xFF2A4D3A),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        children: [
                          _buildMonitoringIcon(
                            Icons.security,
                            'Keamanan',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KeamananPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.wb_sunny,
                            'Cuaca',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CuacaPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.article,
                            'Blog',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlogPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.school,
                            'Tutorial',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TutorialPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildHomeCard(
                  context,
                  'Lihat Semua Produk',
                  'Jelajahi semua koleksi alat pendakian kami.',
                  Icons.inventory_2,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllProductsPage(
                        refreshCallback: widget.refreshCallback,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Brand Unggulan',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF2A4D3A),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mockBrands.length,
                        itemBuilder: (context, index) =>
                            _buildBrandCard(mockBrands[index]),
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75, // Disesuaikan untuk layout baru
                  ),
                  itemCount: uniqueProducts.length,
                  itemBuilder: (context, index) {
                    final product = uniqueProducts[index];
                    return ProductCard(
                      product: product,
                      refreshCallback: widget.refreshCallback,
                      likeCount: likeCounts[product.id] ?? 111104,
                      onLike: (liked) {
                        setState(() {
                          if (liked) {
                            likeCounts[product.id] =
                                (likeCounts[product.id] ?? 111104) + 1;
                          } else {
                            likeCounts[product.id] =
                                (likeCounts[product.id] ?? 111104) - 1;
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: const Color(0xFF2A4D3A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildBrandCard(Brand brand) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                brand.logoUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                brand.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                brand.description,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF2A4D3A),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF2A4D3A),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
