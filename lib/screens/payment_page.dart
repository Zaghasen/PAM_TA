import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/models/product.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';

class PaymentPage extends StatefulWidget {
  final Product? item;
  const PaymentPage({super.key, this.item});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cart = MainScreenState.cartItems;
    double totalPrice;

    if (widget.item != null) {
      totalPrice = widget.item!.pricePerDay * quantity;
    } else {
      totalPrice = cart.fold(0, (sum, item) => sum + item.pricePerDay);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.item != null) ...[
              Text(
                widget.item!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Harga per hari: Rp ${widget.item!.pricePerDay.toInt()}'),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Jumlah: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ] else ...[
              const Text(
                'Ringkasan Pesanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            ],
            const SizedBox(height: 20),
            Text(
              'Total harga: Rp ${totalPrice.toInt()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
