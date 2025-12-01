import 'package:tapak_jejak/models/outlet.dart';
import 'package:tapak_jejak/models/rental_item.dart';

class MockOutletData {
  static List<Outlet> getAllOutlets() {
    return [
      Outlet(
        id: 'outlet-1',
        name: 'Eiger Adventure Store Seturan',
        address:
            'Jl. Seturan Raya No. 1, Caturtunggal, Depok, Sleman, Yogyakarta',
        latitude: -7.7526,
        longitude: 110.4085,
        phone: '+62 274-4333-111',
        imageUrl: 'assets/eiger.jpg',
        rating: 4.8,
        reviewCount: 245,
        openHours: '09:00',
        closeHours: '21:00',
        facilities: ['Parkir Luas', 'Toilet', 'Musholla', 'Cafe', 'AC', 'WiFi'],
        brands: ['Eiger'],
      ),
      Outlet(
        id: 'outlet-2',
        name: 'Consina Outdoor Gear Jogja',
        address:
            'Jl. Babarsari No. 43, Caturtunggal, Depok, Sleman, Yogyakarta',
        latitude: -7.7542,
        longitude: 110.4098,
        phone: '+62 274-4333-222',
        imageUrl: 'assets/consina.jpg',
        rating: 4.7,
        reviewCount: 189,
        openHours: '08:30',
        closeHours: '20:30',
        facilities: ['Parkir', 'Toilet', 'Musholla', 'WiFi'],
        brands: ['Consina'],
      ),
      Outlet(
        id: 'outlet-3',
        name: 'Arei Outdoor Equipment Seturan',
        address: 'Jl. Affandi No. 88, Caturtunggal, Depok, Sleman, Yogyakarta',
        latitude: -7.7558,
        longitude: 110.4072,
        phone: '+62 274-4333-333',
        imageUrl: 'assets/arei.jpg',
        rating: 4.9,
        reviewCount: 312,
        openHours: '09:00',
        closeHours: '21:00',
        facilities: [
          'Parkir Basement',
          'Toilet',
          'Musholla',
          'Cafe',
          'AC',
          'WiFi',
        ],
        brands: ['Arei'],
      ),
      Outlet(
        id: 'outlet-4',
        name: 'Mountain Gear Rental Condongcatur',
        address: 'Jl. Ring Road Utara, Condongcatur, Depok, Sleman, Yogyakarta',
        latitude: -7.7495,
        longitude: 110.4115,
        phone: '+62 274-4333-444',
        imageUrl: 'assets/sewa_alat.png',
        rating: 4.6,
        reviewCount: 156,
        openHours: '08:00',
        closeHours: '20:00',
        facilities: ['Parkir Luas', 'Toilet', 'WiFi'],
        brands: ['Eiger', 'Consina', 'Arei'],
      ),
      Outlet(
        id: 'outlet-5',
        name: 'Peak Outdoor Jakal',
        address:
            'Jl. Kaliurang KM 5.5, Sinduharjo, Ngaglik, Sleman, Yogyakarta',
        latitude: -7.7380,
        longitude: 110.3950,
        phone: '+62 274-4333-555',
        imageUrl: 'assets/alat.jpg',
        rating: 4.5,
        reviewCount: 178,
        openHours: '07:30',
        closeHours: '20:00',
        facilities: ['Parkir', 'Toilet', 'Musholla', 'Warung'],
        brands: ['Eiger', 'Consina', 'Arei'],
      ),
    ];
  }

  static List<RentalItem> getOutletProducts(String outletId) {
    // Products berdasarkan brand outlet
    final baseProducts = [
      RentalItem(
        id: 'item-1',
        outletId: outletId,
        name: 'Tenda Dome Consina 4 Orang',
        brand: 'Consina',
        category: 'Tenda',
        imageUrl: 'assets/consina/tenda1.jpg',
        images: ['assets/consina/tenda1.jpg', 'assets/consina/tenda2.jpg'],
        pricePerDay: 75000,
        description:
            'Tenda dome berkualitas untuk 4 orang dengan fly sheet double layer, cocok untuk camping di pegunungan.',
        specifications: [
          'Kapasitas: 4 orang',
          'Material: Polyester 190T',
          'Waterproof: 2000mm',
          'Dimensi: 200 x 200 x 130 cm',
          'Berat: 3.5 kg',
        ],
        stock: 5,
        condition: 'Baik',
        rating: 4.7,
        reviewCount: 89,
      ),
      RentalItem(
        id: 'item-2',
        outletId: outletId,
        name: 'Carrier Eiger 60L',
        brand: 'Eiger',
        category: 'Carrier',
        imageUrl: 'assets/eiger/tas1.jpg',
        images: ['assets/eiger/tas1.jpg', 'assets/eiger/tas2.jpg'],
        pricePerDay: 50000,
        description:
            'Carrier ergonomis dengan sistem suspensi yang nyaman untuk perjalanan panjang.',
        specifications: [
          'Kapasitas: 60 Liter',
          'Material: Polyester 600D',
          'Rain Cover: Included',
          'Back System: Adjustable',
          'Berat: 1.8 kg',
        ],
        stock: 8,
        condition: 'Sangat Baik',
        rating: 4.8,
        reviewCount: 156,
      ),
      RentalItem(
        id: 'item-3',
        outletId: outletId,
        name: 'Sleeping Bag Arei Polar',
        brand: 'Arei',
        category: 'Sleeping Bag',
        imageUrl: 'assets/arei/jaket1.jpg',
        images: ['assets/arei/jaket1.jpg', 'assets/arei/jaket2.jpg'],
        pricePerDay: 35000,
        description:
            'Sleeping bag hangat untuk suhu ekstrem hingga -5°C, cocok untuk pendakian pegunungan tinggi.',
        specifications: [
          'Temperature Rating: -5°C hingga 15°C',
          'Material: Hollow Fiber',
          'Dimensi: 210 x 75 cm',
          'Berat: 1.2 kg',
          'Tipe: Mummy',
        ],
        stock: 12,
        condition: 'Baik',
        rating: 4.6,
        reviewCount: 124,
      ),
      RentalItem(
        id: 'item-4',
        outletId: outletId,
        name: 'Sepatu Gunung Eiger',
        brand: 'Eiger',
        category: 'Sepatu',
        imageUrl: 'assets/eiger/sepatu1.jpg',
        images: ['assets/eiger/sepatu1.jpg', 'assets/eiger/sepatu2.jpg'],
        pricePerDay: 40000,
        description:
            'Sepatu gunung berkualitas dengan grip kuat dan waterproof untuk berbagai medan.',
        specifications: [
          'Material: Suede + Cordura',
          'Sole: Vibram',
          'Waterproof: Yes',
          'Size: 39-44',
          'Berat: 800g',
        ],
        stock: 15,
        condition: 'Sangat Baik',
        rating: 4.9,
        reviewCount: 201,
      ),
      RentalItem(
        id: 'item-5',
        outletId: outletId,
        name: 'Trekking Pole Consina',
        brand: 'Consina',
        category: 'Aksesoris',
        imageUrl: 'assets/consina/tp1.jpg',
        images: ['assets/consina/tp1.jpg', 'assets/consina/tp2.jpg'],
        pricePerDay: 20000,
        description:
            'Sepasang trekking pole aluminium dengan anti-shock system.',
        specifications: [
          'Material: Aluminium 7075',
          'Panjang: 65-135 cm (adjustable)',
          'Berat: 250g per pole',
          'Anti-shock: Yes',
        ],
        stock: 10,
        condition: 'Baik',
        rating: 4.5,
        reviewCount: 78,
      ),
      RentalItem(
        id: 'item-6',
        outletId: outletId,
        name: 'Jaket Gunung Arei',
        brand: 'Arei',
        category: 'Jaket',
        imageUrl: 'assets/arei/jaket1.jpg',
        images: ['assets/arei/jaket1.jpg', 'assets/arei/jaket2.jpg'],
        pricePerDay: 45000,
        description:
            'Jaket windproof dan waterproof, ringan dan hangat untuk pendakian.',
        specifications: [
          'Material: Polyester + Fleece',
          'Waterproof: 3000mm',
          'Windproof: Yes',
          'Hood: Adjustable',
          'Berat: 600g',
        ],
        stock: 20,
        condition: 'Baik',
        rating: 4.7,
        reviewCount: 92,
      ),
      RentalItem(
        id: 'item-7',
        outletId: outletId,
        name: 'Tas Carrier Arei 50L',
        brand: 'Arei',
        category: 'Carrier',
        imageUrl: 'assets/arei/tas1.jpg',
        images: ['assets/arei/tas1.jpg', 'assets/arei/tas2.jpg'],
        pricePerDay: 45000,
        description:
            'Carrier 50L dengan sistem ventilasi punggung dan rain cover.',
        specifications: [
          'Kapasitas: 50 Liter',
          'Material: Ripstop Nylon',
          'Rain Cover: Included',
          'Ventilasi Punggung: Yes',
          'Berat: 1.5 kg',
        ],
        stock: 7,
        condition: 'Sangat Baik',
        rating: 4.8,
        reviewCount: 134,
      ),
      RentalItem(
        id: 'item-8',
        outletId: outletId,
        name: 'Tenda Dome Eiger 2 Orang',
        brand: 'Eiger',
        category: 'Tenda',
        imageUrl: 'assets/eiger/tenda 1.jpg',
        images: ['assets/eiger/tenda 1.jpg', 'assets/eiger/tenda2.jpg'],
        pricePerDay: 60000,
        description:
            'Tenda 2 orang ultralight dengan konstruksi kokoh dan mudah dipasang.',
        specifications: [
          'Kapasitas: 2 orang',
          'Material: Polyester 210T',
          'Waterproof: 3000mm',
          'Dimensi: 210 x 140 x 110 cm',
          'Berat: 2.2 kg',
        ],
        stock: 6,
        condition: 'Baik',
        rating: 4.6,
        reviewCount: 98,
      ),
    ];

    return baseProducts;
  }

  static Outlet? getOutletById(String id) {
    try {
      return getAllOutlets().firstWhere((outlet) => outlet.id == id);
    } catch (e) {
      return null;
    }
  }
}
