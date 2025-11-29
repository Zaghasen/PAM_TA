import 'package:flutter/material.dart';
import 'package:tapak_jejak/data/mock_data.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/home/main_page.dart';
import 'package:tapak_jejak/screens/fitur/sewa_alat/product_detail_page.dart';

class AllProductsScreen extends StatefulWidget {
  final VoidCallback refreshCallback;
  const AllProductsScreen({super.key, required this.refreshCallback});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late TextEditingController searchController;
  late List<Product> filteredProducts;
  late Map<int, bool> isLiked;
  late Map<int, int> likeCounts;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredProducts = mockProducts;
    isLiked = {};
    likeCounts = {};
    for (var product in mockProducts) {
      isLiked[product.id] = false;
      likeCounts[product.id] = product.totalLike;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchMenu(String query) {
    setState(() {
      filteredProducts = mockProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  'Semua Produk',
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
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _searchMenu,
              decoration: InputDecoration(
                hintText: "Cari Alat...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final item = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: item,
                          refreshCallback: widget.refreshCallback,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                'Rp ${item.pricePerDay.toInt()}/hari',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Like and Cart buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isLiked[item.id] ?? false
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.pink,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        bool liked = isLiked[item.id] ?? false;
                                        isLiked[item.id] = !liked;
                                        likeCounts[item.id] = liked
                                            ? item.totalLike
                                            : item.totalLike + 1;
                                      });
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isLiked[item.id] ?? false
                                                ? 'Barang disimpan di wishlist'
                                                : 'Barang dihapus dari wishlist',
                                          ),
                                        ),
                                      );
                                      if (isLiked[item.id] ?? false) {
                                        if (!MainScreen.wishlistItems.any(
                                          (p) => p.id == item.id,
                                        )) {
                                          MainScreen.wishlistItems.add(item);
                                        }
                                      } else {
                                        MainScreen.wishlistItems.removeWhere(
                                          (p) => p.id == item.id,
                                        );
                                      }
                                      widget.refreshCallback();
                                    },
                                  ),
                                  Text(
                                    '${likeCounts[item.id] ?? item.totalLike}',
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  MainScreen.cartItems.any(
                                        (p) => p.id == item.id,
                                      )
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (MainScreen.cartItems.any(
                                      (p) => p.id == item.id,
                                    )) {
                                      MainScreen.cartItems.removeWhere(
                                        (p) => p.id == item.id,
                                      );
                                    } else {
                                      MainScreen.cartItems.add(item);
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        MainScreen.cartItems.any(
                                              (p) => p.id == item.id,
                                            )
                                            ? 'Produk disimpan di keranjang'
                                            : 'Produk dihapus dari keranjang',
                                      ),
                                    ),
                                  );
                                  widget.refreshCallback();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
