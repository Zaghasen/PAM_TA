import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/booking_page.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';

class CartPage extends StatelessWidget {
  final VoidCallback refreshCallback;
  const CartPage({super.key, required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    final cart = MainScreenState.cartItems;
    double total = cart.fold(0, (sum, item) => sum + item.pricePerDay);

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Saya')),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text('Keranjang Anda masih kosong.'))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return ListTile(
                        leading: Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          'Rp ${product.pricePerDay.toInt()}/hari',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            MainScreenState.cartItems.remove(product);
                            refreshCallback();
                          },
                        ),
                      );
                    },
                  ),
          ),
          if (cart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total per Hari:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp ${total.toInt()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingPage(),
                        ),
                      );
                    },
                    child: const Text('Lanjutkan ke Pemesanan'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
