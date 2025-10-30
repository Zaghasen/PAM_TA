import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/all_products_page.dart';
import 'package:tapak_jejak/screens/main_screen.dart';

class WishlistPage extends StatelessWidget {
  final VoidCallback refreshCallback;
  const WishlistPage({super.key, required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    final wishlist = MainScreenState.wishlistItems;
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
                  'Wishlist Saya',
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
      body: wishlist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/kosong.png', height: 200, width: 200),
                  const SizedBox(height: 20),
                  const Text(
                    'Wishlist Kosong',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A4D3A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tidak ada apapun dalam wishlistmu,',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'tambahkan produk untuk melanjutkan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      backgroundColor: const Color(0xFF2A4D3A),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllProductsPage(refreshCallback: refreshCallback),
                        ),
                      );
                    },
                    child: const Text('Tambahkan Produk'),
                  ),
                ],
              ),
            )
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
