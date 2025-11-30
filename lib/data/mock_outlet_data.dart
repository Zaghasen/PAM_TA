import 'package:tapak_jejak/models/outlet.dart';
import 'package:tapak_jejak/models/rental_item.dart';

class MockOutletData {
  static List<Outlet> getAllOutlets() {
    return [
      Outlet(
        id: 'outlet-1',
        name: 'Mountain Gear Rental Semeru',
        address: 'Jl. Raya Semeru No. 45, Lumajang, Jawa Timur',
        latitude: -8.1084,
        longitude: 112.9224,
        phone: '+62 813-1234-5678',
        imageUrl: 'assets/outlets/semeru_gear.jpg',
        rating: 4.8,
        reviewCount: 156,
        openHours: '07:00',
        closeHours: '20:00',
        facilities: ['Parkir Luas', 'Toilet', 'Musholla', 'Cafe'],
        brands: ['Eiger', 'Consina', 'Arei', 'Deuter'],
      ),
      Outlet(
        id: 'outlet-2',
        name: 'Adventure Shop Ranu Pane',
        address: 'Ranu Pane Base Camp, Lumajang, Jawa Timur',
        latitude: -8.0450,
        longitude: 112.9500,
        phone: '+62 813-2345-6789',
        imageUrl: 'assets/outlets/ranu_pane_shop.jpg',
        rating: 4.6,
        reviewCount: 89,
        openHours: '06:00',
        closeHours: '19:00',
        facilities: ['Parkir', 'Toilet', 'Rest Area'],
        brands: ['Eiger', 'Consina', 'Rei'],
      ),
      Outlet(
        id: 'outlet-3',
        name: 'Peak Equipment Malang',
        address: 'Jl. Ijen No. 88, Malang, Jawa Timur',
        latitude: -7.9666,
        longitude: 112.6326,
        phone: '+62 813-3456-7890',
        imageUrl: 'assets/outlets/peak_malang.jpg',
        rating: 4.9,
        reviewCount: 234,
        openHours: '08:00',
        closeHours: '21:00',
        facilities: ['Parkir Basement', 'Toilet', 'Musholla', 'Cafe', 'AC'],
        brands: [
          'Eiger',
          'Consina',
          'Arei',
          'Deuter',
          'Osprey',
          'The North Face',
        ],
      ),
      Outlet(
        id: 'outlet-4',
        name: 'Summit Rental Bromo',
        address: 'Cemoro Lawang, Probolinggo, Jawa Timur',
        latitude: -7.9425,
        longitude: 112.9531,
        phone: '+62 813-4567-8901',
        imageUrl: 'assets/outlets/bromo_rental.jpg',
        rating: 4.5,
        reviewCount: 178,
        openHours: '05:00',
        closeHours: '22:00',
        facilities: ['Parkir', 'Toilet', 'Warung'],
        brands: ['Eiger', 'Consina', 'Arei'],
      ),
      Outlet(
        id: 'outlet-5',
        name: 'Highland Gear Batu',
        address: 'Jl. Raya Selecta No. 12, Batu, Jawa Timur',
        latitude: -7.8700,
        longitude: 112.5200,
        phone: '+62 813-5678-9012',
        imageUrl: 'assets/outlets/highland_batu.jpg',
        rating: 4.7,
        reviewCount: 145,
        openHours: '07:30',
        closeHours: '20:30',
        facilities: ['Parkir', 'Toilet', 'Musholla', 'WiFi'],
        brands: ['Eiger', 'Consina', 'Arei', 'Deuter', 'Fjallraven'],
      ),
    ];
  }

  static List<RentalItem> getOutletProducts(String outletId) {
    // Sample products - bisa di-expand sesuai kebutuhan
    final baseProducts = [
      RentalItem(
        id: 'item-1',
        outletId: outletId,
        name: 'Tenda Dome 4 Orang Consina',
        brand: 'Consina',
        category: 'Tenda',
        imageUrl: 'assets/consina/tenda_dome.jpg',
        images: [
          'assets/consina/tenda_dome.jpg',
          'assets/consina/tenda_dome_2.jpg',
          'assets/consina/tenda_dome_3.jpg',
        ],
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
        name: 'Carrier Eiger Tas Gunung 60L',
        brand: 'Eiger',
        category: 'Carrier',
        imageUrl: 'assets/eiger/carrier_60l.jpg',
        images: [
          'assets/eiger/carrier_60l.jpg',
          'assets/eiger/carrier_60l_2.jpg',
        ],
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
        imageUrl: 'assets/arei/sleeping_bag.jpg',
        images: [
          'assets/arei/sleeping_bag.jpg',
          'assets/arei/sleeping_bag_2.jpg',
        ],
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
        name: 'Kompor Camping Portable',
        brand: 'Consina',
        category: 'Cooking Set',
        imageUrl: 'assets/consina/kompor_camping.jpg',
        images: ['assets/consina/kompor_camping.jpg'],
        pricePerDay: 25000,
        description:
            'Kompor portable dengan sistem piezo ignition, efisien dan mudah digunakan.',
        specifications: [
          'Tipe: Gas Canister',
          'Material: Stainless Steel',
          'Berat: 400g',
          'BTU: 2800',
        ],
        stock: 15,
        condition: 'Sangat Baik',
        rating: 4.9,
        reviewCount: 201,
      ),
      RentalItem(
        id: 'item-5',
        outletId: outletId,
        name: 'Trekking Pole Eiger Pair',
        brand: 'Eiger',
        category: 'Aksesoris',
        imageUrl: 'assets/eiger/trekking_pole.jpg',
        images: ['assets/eiger/trekking_pole.jpg'],
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
        name: 'Matras Lipat Arei',
        brand: 'Arei',
        category: 'Aksesoris',
        imageUrl: 'assets/arei/matras.jpg',
        images: ['assets/arei/matras.jpg'],
        pricePerDay: 15000,
        description: 'Matras lipat untuk alas tidur, ringan dan mudah dibawa.',
        specifications: [
          'Material: EVA Foam',
          'Dimensi: 180 x 50 x 1 cm',
          'Berat: 300g',
          'Tipe: Foldable',
        ],
        stock: 20,
        condition: 'Baik',
        rating: 4.4,
        reviewCount: 92,
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
