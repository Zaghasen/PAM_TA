import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile(
              title: const Text('Virtual Account'),
              value: 'va',
              groupValue: 'va',
              onChanged: (val) {},
            ),
            RadioListTile(
              title: const Text('E-Wallet'),
              value: 'ewallet',
              groupValue: 'va',
              onChanged: (val) {},
            ),
            RadioListTile(
              title: const Text('Kartu Kredit'),
              value: 'cc',
              groupValue: 'va',
              onChanged: (val) {},
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF2A4D3A),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Pembayaran Berhasil!'),
                    content: const Text(
                      'Pesanan Anda telah dikonfirmasi. Silakan ambil alat sesuai jadwal.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Kosongkan keranjang setelah berhasil
                          MainScreenState.cartItems.clear();
                          Navigator.of(ctx).pop(); // Tutup dialog
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          ); // Kembali ke home
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Bayar Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
