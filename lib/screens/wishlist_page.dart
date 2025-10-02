import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/main_screen.dart';

class WishlistPage extends StatelessWidget {
  final VoidCallback refreshCallback;
  const WishlistPage({super.key, required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    final wishlist = MainScreenState.wishlistItems;
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist Saya')),
      body: wishlist.isEmpty
          ? const Center(child: Text('Wishlist Anda masih kosong.'))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text('Rp ${product.pricePerDay.toInt()}/hari'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      product.isWishlisted = false;
                      MainScreenState.wishlistItems.removeWhere(
                        (p) => p.id == product.id,
                      );
                      refreshCallback();
                    },
                  ),
                );
              },
            ),
    );
  }
}
