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
                  'TAPAK JEJAK',
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                // Banner Carousel
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            'assets/banner_${index + 1}.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
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
                        Icons.local_activity,
                        'Tiket Masuk',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TiketMasukPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.two_wheeler,
                        'Travel & Ojek',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TravelOjekPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.hiking,
                        'Porter & Guide',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PorterGuidePage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.handyman,
                        'Sewa Alat',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SewaAlatPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.route,
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
                        Icons.calendar_today,
                        'Event',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EventPage(),
                          ),
                        ),
                      ),
                      _buildServiceIcon(
                        Icons.home,
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade100, Colors.green.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Pantau Kondisi Gunung untuk Pendakian Aman!',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: const Color(0xFF2A4D3A),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
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
                            Icons.shield,
                            'Keamanan',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KeamananPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.cloud,
                            'Cuaca',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CuacaPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.book,
                            'Blog',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlogPage(),
                              ),
                            ),
                          ),
                          _buildMonitoringIcon(
                            Icons.lightbulb,
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
                // Lihat Semua Produk Section
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade200, Colors.green.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllProductsPage(
                          refreshCallback: widget.refreshCallback,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          size: 50,
                          color: const Color(0xFF2A4D3A),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lihat Semua Produk',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: const Color(0xFF2A4D3A),
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(1, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Jelajahi semua koleksi alat pendakian kami.',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF2A4D3A),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Brand Unggulan Section
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade300, Colors.green.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Brand Unggulan',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: const Color(0xFF2A4D3A),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
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
    bool isHighlighted = false;
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        onTap: onTap,
        onHighlightChanged: (highlighted) {
          setState(() => isHighlighted = highlighted);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isHighlighted ? 10 : 5,
                offset: Offset(0, isHighlighted ? 4 : 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: const Color(0xFF2A4D3A)),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonitoringIcon(IconData icon, String label, VoidCallback onTap) {
    bool isHighlighted = false;
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        onTap: onTap,
        onHighlightChanged: (highlighted) {
          setState(() => isHighlighted = highlighted);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isHighlighted ? 10 : 5,
                offset: Offset(0, isHighlighted ? 4 : 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: const Color(0xFF2A4D3A)),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
