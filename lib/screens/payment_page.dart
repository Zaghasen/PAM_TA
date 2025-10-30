import 'package:flutter/material.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/main_screen.dart';

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
                  'Pembayaran',
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
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      // Add notification functionality
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
