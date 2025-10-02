import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/data/mock_data.dart';
import 'package:tugas_akhir_097/models/product.dart';
import 'package:tugas_akhir_097/screens/all_products_page.dart';
import 'package:tugas_akhir_097/screens/cart_page.dart';
import 'package:tugas_akhir_097/screens/membership_page.dart';
import 'package:tugas_akhir_097/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback refreshCallback;
  const HomePage({super.key, required this.refreshCallback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredProducts = mockProducts;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchMenu(String query) {
    setState(() {
      filteredProducts = mockProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Banner
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/banner.png', // Sesuaikan nama banner jika berbeda
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 🔍 Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: _searchMenu,
                    decoration: InputDecoration(
                      hintText: "Cari Alat...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                Text(
                  'Produk Unggulan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                // Grid menu
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
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      refreshCallback: widget.refreshCallback,
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
}
