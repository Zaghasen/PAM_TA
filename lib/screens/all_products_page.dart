import 'package:flutter/material.dart';
import 'package:tapak_jejak/data/mock_data.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/main_screen.dart';
import 'package:tapak_jejak/screens/product_detail_page.dart';

class AllProductsPage extends StatefulWidget {
  final VoidCallback refreshCallback;
  const AllProductsPage({super.key, required this.refreshCallback});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
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
      appBar: AppBar(title: const Text('Semua Produk'), centerTitle: true),
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
                                        if (!MainScreenState.wishlistItems.any(
                                          (p) => p.id == item.id,
                                        )) {
                                          MainScreenState.wishlistItems.add(
                                            item,
                                          );
                                        }
                                      } else {
                                        MainScreenState.wishlistItems
                                            .removeWhere(
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
                                  MainScreenState.cartItems.any(
                                        (p) => p.id == item.id,
                                      )
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (MainScreenState.cartItems.any(
                                      (p) => p.id == item.id,
                                    )) {
                                      MainScreenState.cartItems.removeWhere(
                                        (p) => p.id == item.id,
                                      );
                                    } else {
                                      MainScreenState.cartItems.add(item);
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        MainScreenState.cartItems.any(
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
