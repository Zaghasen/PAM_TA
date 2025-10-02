import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/data/mock_data.dart';
import 'package:tugas_akhir_097/screens/all_products_page.dart';
import 'package:tugas_akhir_097/screens/cart_page.dart';
import 'package:tugas_akhir_097/screens/membership_page.dart';
import 'package:tugas_akhir_097/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  final VoidCallback refreshCallback;
  const HomePage({super.key, required this.refreshCallback});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              _buildHomeCard(
                context,
                'Lihat Semua Produk',
                'Jelajahi semua koleksi alat pendakian kami.',
                Icons.inventory_2,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllProductsPage(refreshCallback: refreshCallback),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Produk Unggulan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(3, (index) {
                  final product = mockProducts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      height: 120,
                      child: ProductCard(
                        product: product,
                        refreshCallback: refreshCallback,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
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
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
