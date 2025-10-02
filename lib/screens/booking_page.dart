import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';
import 'package:tugas_akhir_097/screens/payment_page.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = MainScreenState.cartItems;
    double total = cart.fold(0, (sum, item) => sum + item.pricePerDay);

    return Scaffold(
      appBar: AppBar(title: const Text('Pemesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan Pesanan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return Text('- ${item.name}');
                },
              ),
            ),
            const Divider(),
            const Text('Pilih Tanggal Sewa (Contoh):'),
            Text('Mulai: 2 Oktober 2025'),
            Text('Selesai: 5 Oktober 2025'),
            Text('Durasi: 3 Hari'),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Biaya (3 hari):',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp ${(total * 3).toInt()}',
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
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
              child: const Text('Lanjutkan ke Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
