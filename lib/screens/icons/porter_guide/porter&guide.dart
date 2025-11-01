import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/icons/porter_guide/porter_guide_detail_page.dart';
import 'package:tapak_jejak/models/product.dart';

class PorterGuidePage extends StatefulWidget {
  const PorterGuidePage({super.key});

  @override
  State<PorterGuidePage> createState() => _PorterGuidePageState();
}

class _PorterGuidePageState extends State<PorterGuidePage> {
  static String _formatCurrency(double value) {
    return value.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  List<Product> _getFilteredProducts() {
    final List<Product> allProducts = [
      Product(
        id: 1,
        name: 'Porter Gunung Merapi',
        brand: 'Local Guide Service',
        pricePerDay: 150000,
        imageUrl: 'assets/tiket_masuk/merapi.jpg',
        category: 'porter_guide',
        description:
            'Porter berpengalaman di Gunung Merapi dengan pengalaman 5 tahun. Membawa beban hingga 20kg.',
      ),
      Product(
        id: 2,
        name: 'Guide Gunung Merbabu',
        brand: 'Mountain Guide Pro',
        pricePerDay: 200000,
        imageUrl: 'assets/tiket_masuk/merbabu.jpg',
        category: 'porter_guide',
        description:
            'Guide profesional untuk pendakian Gunung Merbabu. Berlisensi dan menguasai semua jalur.',
      ),
      Product(
        id: 3,
        name: 'Porter & Guide Lawu',
        brand: 'Adventure Services',
        pricePerDay: 250000,
        imageUrl: 'assets/tiket_masuk/lawu.jpg',
        category: 'porter_guide',
        description:
            'Paket lengkap porter dan guide untuk Gunung Lawu. Aman dan terpercaya.',
      ),
      Product(
        id: 4,
        name: 'Guide Semeru Expert',
        brand: 'Summit Guides',
        pricePerDay: 300000,
        imageUrl: 'assets/tiket_masuk/semeru.jpg',
        category: 'porter_guide',
        description:
            'Guide ahli untuk pendakian Gunung Semeru. Sudah mendaki lebih dari 50 kali.',
      ),
      Product(
        id: 5,
        name: 'Porter Rinjani Support',
        brand: 'Rinjani Trekking',
        pricePerDay: 180000,
        imageUrl: 'assets/tiket_masuk/rinjani.jpg',
        category: 'porter_guide',
        description:
            'Porter khusus untuk pendakian Gunung Rinjani. Kuat dan tahan lama.',
      ),
      Product(
        id: 6,
        name: 'Guide Slamet Local',
        brand: 'Local Mountain Services',
        pricePerDay: 120000,
        imageUrl: 'assets/tiket_masuk/slamet.jpg',
        category: 'porter_guide',
        description:
            'Guide lokal untuk Gunung Slamet. Menguasai semua basecamp dan jalur.',
      ),
    ];

    return allProducts;
  }

  @override
  Widget build(BuildContext context) {
    final products = _getFilteredProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Porter & Guide'),
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
            // Header Section
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
                            Icons.hiking,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Layanan Porter & Guide',
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
                            '${products.length} Layanan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Temukan porter dan guide profesional untuk pendakian Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Product List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
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
                            builder: (context) => PorterGuideDetailPage(
                              product: product,
                              refreshCallback: () => setState(() {}),
                            ),
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
                                    product.imageUrl,
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
                                          product.name,
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
                                              Icons.business,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              product.brand,
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
                                            Icons.attach_money,
                                            size: 16,
                                            color: Color(0xFF2A4D3A),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _formatCurrency(
                                              product.pricePerDay,
                                            ),
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
                                      product.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Price per day
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Rp ${_formatCurrency(product.pricePerDay)} / hari',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
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
