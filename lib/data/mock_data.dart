import 'package:tugas_akhir_097/models/brand.dart';
import 'package:tugas_akhir_097/models/product.dart';

// Daftar produk yang akan kita tampilkan di aplikasi
final List<Product> mockProducts = [
  Product(
    id: 7,
    name: 'Daypack Explorer 25L',
    brand: 'Eiger',
    pricePerDay: 40000,
    imageUrl: 'assets/eiger/tas1.jpg',
  ),
  // Tents
  Product(
    id: 8,
    name: 'Tent Anatrestar Dome 3P',
    brand: 'Anatrestar',
    pricePerDay: 70000,
    imageUrl: 'assets/antarestar/tenda1.jpg',
  ),
  Product(
    id: 9,
    name: 'Tent Arei Family 5P',
    brand: 'Arei',
    pricePerDay: 90000,
    imageUrl: 'assets/arei/tenda1.jpg',
  ),
  Product(
    id: 10,
    name: 'Tent Consina Ultra Light',
    brand: 'Consina',
    pricePerDay: 80000,
    imageUrl: 'assets/consina/tenda1.jpg',
  ),
  Product(
    id: 11,
    name: 'Tent Carumby Expedition',
    brand: 'Carumby',
    pricePerDay: 95000,
    imageUrl: 'assets/carumby/tenda1.jpg',
  ),
  Product(
    id: 12,
    name: 'Tent Eiger Pro 2P',
    brand: 'Eiger',
    pricePerDay: 65000,
    imageUrl: 'assets/eiger/tenda2.jpg',
  ),
  // Tracking Poles
  Product(
    id: 13,
    name: 'Tracking Pole Anatrestar Adjustable',
    brand: 'Anatrestar',
    pricePerDay: 35000,
    imageUrl: 'assets/antarestar/tp1.jpg',
  ),
  Product(
    id: 14,
    name: 'Tracking Pole Arei Carbon',
    brand: 'Arei',
    pricePerDay: 45000,
    imageUrl: 'assets/arei/tp1.jpg',
  ),
  Product(
    id: 15,
    name: 'Tracking Pole Consina Light',
    brand: 'Consina',
    pricePerDay: 30000,
    imageUrl: 'assets/consina/tp1.jpg',
  ),
  Product(
    id: 16,
    name: 'Tracking Pole Carumby Pro',
    brand: 'Carumby',
    pricePerDay: 40000,
    imageUrl: 'assets/carumby/tp1.jpg',
  ),
  Product(
    id: 17,
    name: 'Tracking Pole Eiger Trek',
    brand: 'Eiger',
    pricePerDay: 32000,
    imageUrl: 'assets/eiger/tp1.jpg',
  ),
  // Jackets
  Product(
    id: 18,
    name: 'Jacket Anatrestar Waterproof',
    brand: 'Anatrestar',
    pricePerDay: 120000,
    imageUrl: 'assets/antarestar/jaket1.jpg',
  ),
  Product(
    id: 19,
    name: 'Jacket Arei Windbreaker',
    brand: 'Arei',
    pricePerDay: 100000,
    imageUrl: 'assets/arei/jaket1.jpg',
  ),
  Product(
    id: 20,
    name: 'Jacket Consina Thermal',
    brand: 'Consina',
    pricePerDay: 110000,
    imageUrl: 'assets/consina/jaket1.jpg',
  ),
  Product(
    id: 21,
    name: 'Jacket Carumby Expedition',
    brand: 'Carumby',
    pricePerDay: 130000,
    imageUrl: 'assets/carumby/jaket1.jpg',
  ),
  Product(
    id: 22,
    name: 'Jacket Eiger Pro',
    brand: 'Eiger',
    pricePerDay: 115000,
    imageUrl: 'assets/eiger/jaket1.jpg',
  ),
  // Carriers
  Product(
    id: 23,
    name: 'Carrier Anatrestar 70L',
    brand: 'Anatrestar',
    pricePerDay: 55000,
    imageUrl: 'assets/antarestar/tas1.jpg',
  ),
  Product(
    id: 24,
    name: 'Carrier Arei 50L',
    brand: 'Arei',
    pricePerDay: 48000,
    imageUrl: 'assets/arei/tas1.jpg',
  ),
  Product(
    id: 25,
    name: 'Carrier Consina 65L',
    brand: 'Consina',
    pricePerDay: 52000,
    imageUrl: 'assets/consina/tas1.jpg',
  ),
  Product(
    id: 26,
    name: 'Carrier Carumby 80L',
    brand: 'Carumby',
    pricePerDay: 60000,
    imageUrl: 'assets/carumby/tas1.jpg',
  ),
  Product(
    id: 27,
    name: 'Carrier Eiger 55L',
    brand: 'Eiger',
    pricePerDay: 50000,
    imageUrl: 'assets/eiger/tas1.jpg',
  ),
  // Shoes
  Product(
    id: 28,
    name: 'Shoes Anatrestar Grip',
    brand: 'Anatrestar',
    pricePerDay: 85000,
    imageUrl: 'assets/antarestar/sepatu1.jpg',
  ),
  Product(
    id: 29,
    name: 'Shoes Arei Trail',
    brand: 'Arei',
    pricePerDay: 78000,
    imageUrl: 'assets/arei/sepatu1.jpg',
  ),
  Product(
    id: 30,
    name: 'Shoes Consina Comfort',
    brand: 'Consina',
    pricePerDay: 82000,
    imageUrl: 'assets/consina/sepatu1.jpg',
  ),
  Product(
    id: 31,
    name: 'Shoes Carumby Pro',
    brand: 'Carumby',
    pricePerDay: 90000,
    imageUrl: 'assets/carumby/sepatu1.jpg',
  ),
  Product(
    id: 32,
    name: 'Shoes Eiger Summit',
    brand: 'Eiger',
    pricePerDay: 88000,
    imageUrl: 'assets/eiger/sepatu1.jpg',
  ),
];

// Daftar brand yang akan kita tampilkan
final List<Brand> mockBrands = [
  Brand(name: 'Eiger', logoUrl: 'assets/LOGO.jpg'),
  Brand(name: 'Anatrestar', logoUrl: 'assets/LOGO.jpg'),
  Brand(name: 'Arei', logoUrl: 'assets/LOGO.jpg'),
  Brand(name: 'Consina', logoUrl: 'assets/LOGO.jpg'),
  Brand(name: 'Carumby', logoUrl: 'assets/LOGO.jpg'),
];
