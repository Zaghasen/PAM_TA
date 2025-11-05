import 'package:flutter/material.dart';
import 'package:tapak_jejak/data/mock_data.dart';
import 'package:tapak_jejak/models/brand.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat/all_products_page.dart';
import 'package:tapak_jejak/screens/icons/blog/blog.dart';
import 'package:tapak_jejak/screens/icons/camping_ground/camping_ground.dart';
import 'package:tapak_jejak/screens/icons/eat_stay/eat&stay.dart';
import 'package:tapak_jejak/screens/icons/event/event.dart';
import 'package:tapak_jejak/screens/icons/keamanan/keamanan.dart';
import 'package:tapak_jejak/screens/icons/porter_guide/porter&guide.dart';
import 'package:tapak_jejak/screens/icons/trip/private&open_trip.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat/sewa_alat.dart';
import 'package:tapak_jejak/screens/icons/tiket_masuk/tiket_masuk.dart';
import 'package:tapak_jejak/screens/icons/travel_ojek/travel&ojek.dart';
import 'package:tapak_jejak/screens/icons/tutorial/tutorial.dart';
import 'package:tapak_jejak/screens/icons/cuaca/cuaca.dart';
import 'package:tapak_jejak/screens/terms_page.dart';
import 'package:tapak_jejak/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback refreshCallback;
  const HomeScreen({super.key, required this.refreshCallback});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            actions: [],
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
                    mainAxisSpacing:
                        8.0, // Kurangi spacing untuk mencegah overflow
                    crossAxisSpacing:
                        8.0, // Kurangi spacing untuk mencegah overflow
                    children: [
                      _buildCustomServiceIcon(
                        Image.asset('assets/tiket_masuk.png'),
                        'Tiket Masuk',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TermsScreen(nextPage: const TiketMasukPage()),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/travel_ojek.png'),
                        'Travel & Ojek',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TermsScreen(nextPage: const TravelOjekPage()),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/porter_guide.png'),
                        'Porter & Guide',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TermsScreen(nextPage: const PorterGuidePage()),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/sewa_alat.png'),
                        'Sewa Alat',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TermsScreen(nextPage: const SewaAlatPage()),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/private_open_trip.png'),
                        'Private & Open Trip',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsScreen(
                              nextPage: const PrivateOpenTripPage(),
                            ),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/camping_ground.png'),
                        'Camping Ground',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsScreen(
                              nextPage: const CampingGroundPage(),
                            ),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/event.png'),
                        'Event',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EventPage(),
                          ),
                        ),
                      ),
                      _buildCustomServiceIcon(
                        Image.asset('assets/eat_stay.png'),
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
                        mainAxisSpacing:
                            8.0, // Kurangi spacing untuk mencegah overflow
                        crossAxisSpacing:
                            8.0, // Kurangi spacing untuk mencegah overflow
                        children: [
                          _buildCustomServiceIcon(
                            Image.asset('assets/keamanan.png'),
                            'Keamanan',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KeamananPage(),
                              ),
                            ),
                          ),
                          _buildCustomServiceIcon(
                            Image.asset('assets/cuaca.png'),
                            'Cuaca',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CuacaPage(),
                              ),
                            ),
                          ),
                          _buildCustomServiceIcon(
                            Image.asset('assets/blog.png'),
                            'Blog',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlogPage(),
                              ),
                            ),
                          ),
                          _buildCustomServiceIcon(
                            Image.asset('assets/tutorial.png'),
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

  Widget _buildCustomServiceIcon(
    Widget iconWidget,
    String label,
    VoidCallback onTap,
  ) {
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
              SizedBox(height: 40, width: 40, child: iconWidget),
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
