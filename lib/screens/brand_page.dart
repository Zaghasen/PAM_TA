import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/data/mock_data.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: mockBrands.length,
        itemBuilder: (context, index) {
          final brand = mockBrands[index];
          return Card(
            child: Center(
              child: Image.network(
                brand.logoUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Text(brand.name, style: const TextStyle(fontSize: 20)),
              ),
            ),
          );
        },
      ),
    );
  }
}
