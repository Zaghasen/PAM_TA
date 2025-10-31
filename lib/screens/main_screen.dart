import 'package:flutter/material.dart';
// removed unused import: cart_item
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/cart_page.dart';
import 'package:tapak_jejak/screens/home_screen.dart';
import 'package:tapak_jejak/screens/profile_page.dart';
import 'package:tapak_jejak/screens/wishlist_page.dart';

class MainScreen extends StatefulWidget {
  static List<Product> wishlistItems = [];
  static List<Product> cartItems = [];

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(refreshCallback: () => setState(() {})),
      WishlistPage(refreshCallback: () => setState(() {})),
      CartPage(refreshCallback: () => setState(() {})),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isSelected ? 70 : 50,
                height: isSelected ? 70 : 50,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(isSelected ? 25 : 15),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.green.shade300.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      child: Icon(
                        _getIcon(index),
                        color: isSelected
                            ? const Color(0xFF2A4D3A)
                            : Colors.grey.shade600,
                        size: isSelected ? 28 : 24,
                      ),
                    ),
                    if (isSelected)
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _getLabel(index),
                          style: const TextStyle(
                            color: Color(0xFF2A4D3A),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.favorite;
      case 2:
        return Icons.shopping_cart;
      case 3:
        return Icons.person;
      default:
        return Icons.home;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Wishlist';
      case 2:
        return 'Cart';
      case 3:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}
