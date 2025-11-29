import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/fitur/sewa_alat/all_products_page.dart';
import 'package:tapak_jejak/screens/home/main_page.dart';

enum WishlistCategory { semua, tiket_masuk, porter_guide, private_open_trip }

class WishlistPage extends StatefulWidget {
  final VoidCallback refreshCallback;
  const WishlistPage({super.key, required this.refreshCallback});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  WishlistCategory selectedCategory = WishlistCategory.semua;

  Map<String, dynamic> _getCategoryData(WishlistCategory category) {
    switch (category) {
      case WishlistCategory.semua:
        return {
          'icon': Icons.all_inclusive,
          'label': 'Semua',
          'color': Colors.orange,
        };
      case WishlistCategory.tiket_masuk:
        return {
          'icon': Icons.confirmation_number,
          'label': 'Tiket Masuk',
          'color': Colors.orange,
        };
      case WishlistCategory.porter_guide:
        return {
          'icon': Icons.hiking,
          'label': 'Porter & Guide',
          'color': Colors.orange,
        };
      case WishlistCategory.private_open_trip:
        return {
          'icon': Icons.group,
          'label': 'Private Trip',
          'color': Colors.orange,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = MainScreen.wishlistItems.where((product) {
      switch (selectedCategory) {
        case WishlistCategory.tiket_masuk:
          return product.category == 'tiket_masuk';
        case WishlistCategory.porter_guide:
          return product.category == 'porter_guide';
        case WishlistCategory.private_open_trip:
          return product.category == 'private_open_trip';
        default:
          return true; // semua
      }
    }).toList();
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
      body: Column(
        children: [
          // Creative Category filter tabs
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: WishlistCategory.values.map((category) {
                  final isSelected = selectedCategory == category;
                  final categoryData = _getCategoryData(category);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    categoryData['color'] as Color,
                                    (categoryData['color'] as Color)
                                        .withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.grey.shade100,
                                    Colors.grey.shade200,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: (categoryData['color'] as Color)
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              categoryData['icon'] as IconData,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              categoryData['label'] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: wishlist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/kosong.png',
                          height: 200,
                          width: 200,
                        ),
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
                                builder: (context) => AllProductsScreen(
                                  refreshCallback: widget.refreshCallback,
                                ),
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
                        subtitle: Text(
                          'Rp ${product.pricePerDay.toInt()}/hari',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Konfirmasi Hapus'),
                                content: Text(
                                  'Apakah Anda yakin ingin menghapus "${product.name}" dari wishlist?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              setState(() {
                                product.isWishlisted = false;
                                MainScreen.wishlistItems.removeWhere(
                                  (p) => p.id == product.id,
                                );
                              });
                              widget.refreshCallback();
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
