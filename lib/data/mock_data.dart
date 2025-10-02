import 'package:tugas_akhir_097/models/brand.dart';
import 'package:tugas_akhir_097/models/product.dart';

// Daftar produk yang akan kita tampilkan di aplikasi
final List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'Tenda Dome Pro 4P',
    brand: 'Eiger',
    pricePerDay: 75000,
    imageUrl: 'https://placehold.co/600x400/22c55e/FFFFFF?text=Tenda',
  ),
  Product(
    id: 2,
    name: 'Carrier Rucksack 60L',
    brand: 'Arei',
    pricePerDay: 50000,
    imageUrl: 'https://placehold.co/600x400/3b82f6/FFFFFF?text=Carrier',
  ),
  Product(
    id: 3,
    name: 'Sleeping Bag Comfort',
    brand: 'Consina',
    pricePerDay: 25000,
    imageUrl: 'https://placehold.co/600x400/8b5cf6/FFFFFF?text=Sleeping+Bag',
  ),
  Product(
    id: 4,
    name: 'Sepatu Hiking T-Rex',
    brand: 'Anatrestar',
    pricePerDay: 80000,
    imageUrl: 'https://placehold.co/600x400/f97316/FFFFFF?text=Sepatu',
  ),
  Product(
    id: 5,
    name: 'Kompor Portable Mini',
    brand: 'Arei',
    pricePerDay: 20000,
    imageUrl: 'https://placehold.co/600x400/ef4444/FFFFFF?text=Kompor',
  ),
  Product(
    id: 6,
    name: 'Matras Gulung',
    brand: 'Consina',
    pricePerDay: 10000,
    imageUrl: 'https://placehold.co/600x400/14b8a6/FFFFFF?text=Matras',
  ),
  Product(
    id: 7,
    name: 'Daypack Explorer 25L',
    brand: 'Eiger',
    pricePerDay: 40000,
    imageUrl: 'https://placehold.co/600x400/6366f1/FFFFFF?text=Daypack',
  ),
];

// Daftar brand yang akan kita tampilkan
final List<Brand> mockBrands = [
  Brand(
    name: 'Eiger',
    logoUrl: 'https://placehold.co/400x400/1f2937/FFFFFF?text=Eiger',
  ),
  Brand(
    name: 'Anatrestar',
    logoUrl: 'https://placehold.co/400x400/1f2937/FFFFFF?text=Anatrestar',
  ),
  Brand(
    name: 'Arei',
    logoUrl: 'https://placehold.co/400x400/1f2937/FFFFFF?text=Arei',
  ),
  Brand(
    name: 'Consina',
    logoUrl: 'https://placehold.co/400x400/1f2937/FFFFFF?text=Consina',
  ),
];
