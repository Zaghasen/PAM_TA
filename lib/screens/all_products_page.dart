import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/data/mock_data.dart';
import 'package:tugas_akhir_097/widgets/product_card.dart';

class AllProductsPage extends StatelessWidget {
  final VoidCallback refreshCallback;
  const AllProductsPage({super.key, required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Produk')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: mockProducts[index],
            refreshCallback: refreshCallback,
          );
        },
      ),
    );
  }
}
