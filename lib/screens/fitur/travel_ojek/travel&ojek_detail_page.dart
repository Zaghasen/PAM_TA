import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/mountain.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/models/cart_item.dart';
import 'package:tapak_jejak/screens/home/main_page.dart';

class TravelOjekDetailPage extends StatefulWidget {
  final Mountain mountain;

  const TravelOjekDetailPage({super.key, required this.mountain});

  @override
  State<TravelOjekDetailPage> createState() => _TravelOjekDetailPageState();
}

class _TravelOjekDetailPageState extends State<TravelOjekDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedPickupLocation;
  String? selectedDestination;
  String? selectedVehicle;
  int passengerCount = 1;
  DateTime? pickupDate;
  TimeOfDay? pickupTime;
  String selectedTimeZone = 'WIB';

  List<String> pickupLocations = [
    'Jakarta',
    'Semarang',
    'Yogyakarta',
    'Surabaya',
  ];

  List<String> vehicles = [
    'Toyota Avanza',
    'Toyota Innova',
    'Mitsubishi Pajero',
    'Suzuki Ertiga',
    'Honda Mobilio',
    'Toyota Hiace',
    'Isuzu Elf',
    'Mercedes-Benz Sprinter',
  ];

  Map<String, int> timeZoneOffsets = {
    'WIB': 7,
    'WIT': 8,
    'WITA': 9,
    'London': 0,
  };

  List<String> _getDestinationOptions() {
    switch (widget.mountain.name) {
      case 'Gunung Andong':
        return [
          'via Sawit (Magelang)',
          'via Pendem (Magelang)',
          'via Gogik (Magelang)',
        ];
      case 'Gunung Bismo':
        return ['via Sikunang (Wonosobo)', 'via Deroduwur', 'via Silandak'];
      case 'Gunung Buthak':
        return ['via Panderman (Batu)', 'via Sirah Kencong (Blitar)'];
      case 'Gunung Kembang':
        return ['via Blembem (Wonosobo)'];
      case 'Gunung Lawu':
        return [
          'via Cemoro Sewu (Magetan)',
          'via Cemoro Kandang (Karanganyar)',
          'via Candi Cetho (Karanganyar)',
        ];
      case 'Gunung Merapi':
        return ['via Selo (Boyolali)', 'via Babadan (Magelang)'];
      case 'Gunung Merbabu':
        return [
          'via Selo (Boyolali)',
          'via Suwanting (Magelang)',
          'via Wekas (Magelang)',
          'via Cuntel (Semarang)',
          'via Thekelan (Semarang)',
        ];
      case 'Gunung Pakuwaja':
        return ['via Sikunang (Dieng)', 'via Wates (Dieng)'];
      case 'Gunung Prau':
        return [
          'via Patak Banteng (Wonosobo)',
          'via Dieng (Wonosobo)',
          'via Kalilembu (Wonosobo)',
          'via Wates (Temanggung)',
        ];
      case 'Gunung Raung':
        return ['via Kalibaru (Banyuwangi)', 'via Sumberwringin (Bondowoso)'];
      case 'Gunung Rinjani':
        return [
          'via Sembalun (Lombok Timur)',
          'via Senaru (Lombok Utara)',
          'via Torean (Lombok Utara)',
          'via Aik Berik (Lombok Tengah)',
        ];
      case 'Gunung Semeru':
        return ['via Ranu Pani (Lumajang)'];
      case 'Gunung Sindoro':
        return [
          'via Kledung (Temanggung)',
          'via Sigedang (Wonosobo)',
          'via Bansari (Temanggung)',
          'via Alang-alang Sewu (Wonosobo)',
        ];
      case 'Gunung Slamet':
        return [
          'via Bambangan (Purbalingga)',
          'via Guci (Tegal)',
          'via Dipajaya (Pemalang)',
          'via Baturraden (Banyumas)',
        ];
      case 'Gunung Sumbing':
        return [
          'via Garung (Wonosobo)',
          'via Butuh/Mangli (Magelang)',
          'via Gajah Mungkur (Wonosobo)',
          'via Batusari (Temanggung)',
        ];
      case 'Gunung Telomoyo':
        return ['via Pandean (Magelang)', 'via Sepakung (Kab. Semarang)'];
      case 'Gunung Ungaran':
        return [
          'via Basecamp Mawar (Kab. Semarang)',
          'via Promasan (Kendal)',
          'via Candi Gedong Songo (Kab. Semarang)',
        ];
      case 'Gunung Leuser':
        return ['via Kedah (Gayo Lues - ekspedisi panjang)'];
      case 'Gunung Sibuatan':
        return ['via Desa Nagalingga (Karo)'];
      case 'Gunung Kerinci':
        return ['via Kersik Tuo (Jambi - perbatasan)'];
      case 'Gunung Talamau':
        return ['via Pinaga (Pasaman Barat)'];
      case 'Gunung Dempo':
        return ['via Pagar Alam / Tugu Rimau'];
      case 'Gunung Pesagi':
        return ['via Desa Bahway (Lampung Barat)'];
      case 'Gunung Halimun (Puncak Sanggabuana)':
        return ['via Cianten/Nirmala (Bogor - bagian dari TNGHS)'];
      case 'Gunung Ciremai':
        return [
          'via Palutungan, Linggajati (Kuningan)',
          'via Apuy (Majalengka)',
        ];
      case 'Gunung Pangrango':
        return ['via Cibodas (Cianjur)'];
      case 'Gunung Gede':
        return ['via Cibodas', 'via Gunung Putri (Cianjur)'];
      case 'Gunung Cikuray':
        return ['via Pemancar, Bayongbong (Garut)'];
      case 'Gunung Papandayan':
        return ['via Cisurupan (Garut - TWA)'];
      case 'Gunung Arjuno':
        return ['via Tretes (Pasuruan)', 'via Lawang (Malang)', 'via Batu'];
      case 'Gunung Argopuro':
        return ['via Baderan (Situbondo)', 'via Bremi (Probolinggo)'];
      case 'Gunung Welirang':
        return ['via Tretes', 'via Pacet'];
      case 'Gunung Agung':
        return ['via Pura Besakih', 'via Pura Pasar Agung (Karangasem)'];
      case 'Gunung Inerie':
        return ['via Watumeze (Flores)'];
      case 'Gunung Bukit Raya':
        return ['via Rantau Malam', 'via Tumbang Habangoi'];
      case 'Gunung Halau-halau (Puncak Besar)':
        return ['via Desa Hantakan (Hulu Sungai Tengah)'];
      case 'Gunung Mekongga':
        return ['via Desa Tinukari (Kolaka Utara)'];
      case 'Gunung Bawakaraeng':
        return ['via Lembanna (Gowa)'];
      case 'Gunung Gandang Dewata':
        return ['via Mamasa'];
      case 'Gunung Gamalama':
        return ['via Moya / Marikurubu (Ternate)'];
      case 'Gunung Binaiya':
        return ['via Piliana (Pulau Seram)'];
      case 'Puncak Jaya (Carstensz Pyramid)':
        return [
          'via Sugapa (Kab. Intan Jaya - ekspedisi teknikal)',
          'via Helikopter',
        ];
      case 'Puncak Trikora':
        return [
          'Titik Hubung Logistik (Kota): via Wamena',
          'Titik Awal Trekking: via Danau Habbema',
        ];
      default:
        return ['Basecamp A', 'Basecamp B', 'Basecamp C'];
    }
  }

  String _convertTimeZone(DateTime dateTime, String fromZone, String toZone) {
    int fromOffset = timeZoneOffsets[fromZone] ?? 0;
    int toOffset = timeZoneOffsets[toZone] ?? 0;
    int difference = toOffset - fromOffset;
    DateTime converted = dateTime.add(Duration(hours: difference));
    return DateFormat('HH:mm').format(converted);
  }

  double _calculatePrice() {
    // Harga dasar berdasarkan kendaraan
    double basePrice = 500000;
    if (selectedVehicle != null) {
      if (selectedVehicle!.contains('Hiace')) {
        basePrice = 900000;
      } else if (selectedVehicle!.contains('Elf')) {
        basePrice = 1200000;
      } else if (selectedVehicle!.contains('Pajero')) {
        basePrice = 800000;
      } else if (selectedVehicle!.contains('Innova')) {
        basePrice = 600000;
      }
    }

    return basePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                  'Travel ${widget.mountain.name}',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A4D3A), Color(0xFF1B3A2E), Colors.white],
            stops: [0.0, 0.3, 0.6],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(
              top: 80,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            children: [
              // Hero Mountain Card
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.mountain.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.height,
                                  size: 18,
                                  color: Color(0xFF2A4D3A),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.mountain.height} mdpl',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2A4D3A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.mountain.name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Color(0x80000000),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.mountain.location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                color: Colors.white70,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Dikelola oleh: ${widget.mountain.managedBy}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Lokasi Penjemputan
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi Penjemputan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Pilih titik penjemputan Anda',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih lokasi penjemputan',
                        prefixIcon: const Icon(
                          Icons.my_location,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedPickupLocation,
                      items: pickupLocations
                          .map(
                            (location) => DropdownMenuItem(
                              value: location,
                              child: Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedPickupLocation = value),
                      validator: (value) =>
                          value == null ? 'Pilih lokasi penjemputan' : null,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Lokasi Tujuan
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.flag,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi Tujuan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Pilih basecamp tujuan',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih basecamp tujuan',
                        prefixIcon: const Icon(
                          Icons.place,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedDestination,
                      items: _getDestinationOptions()
                          .map(
                            (destination) => DropdownMenuItem(
                              value: destination,
                              child: Text(
                                destination,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedDestination = value),
                      validator: (value) =>
                          value == null ? 'Pilih lokasi tujuan' : null,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Pilih Kendaraan
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Kendaraan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Tipe kendaraan travel',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih tipe kendaraan',
                        prefixIcon: const Icon(
                          Icons.local_taxi,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedVehicle,
                      items: vehicles
                          .map(
                            (vehicle) => DropdownMenuItem(
                              value: vehicle,
                              child: Text(
                                vehicle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedVehicle = value),
                      validator: (value) =>
                          value == null ? 'Pilih kendaraan' : null,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Jumlah Penumpang
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.people,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Penumpang',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Berapa orang yang akan berangkat?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Color(0xFF2E7D32),
                              size: 28,
                            ),
                            onPressed: passengerCount > 1
                                ? () => setState(() => passengerCount--)
                                : null,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                passengerCount.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Color(0xFF2E7D32),
                              size: 28,
                            ),
                            onPressed: () => setState(() => passengerCount++),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Waktu Penjemputan
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.access_time,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Waktu Penjemputan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Pilih tanggal dan waktu',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih tanggal penjemputan',
                        prefixIcon: const Icon(
                          Icons.event,
                          color: Color(0xFF2E7D32),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF2E7D32),
                          ),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: pickupDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null) {
                              setState(() => pickupDate = picked);
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      controller: TextEditingController(
                        text: pickupDate != null
                            ? DateFormat('dd/MM/yyyy').format(pickupDate!)
                            : '',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih waktu penjemputan',
                        prefixIcon: const Icon(
                          Icons.schedule,
                          color: Color(0xFF2E7D32),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.access_time,
                            color: Color(0xFF2E7D32),
                          ),
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: pickupTime ?? TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setState(() => pickupTime = picked);
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      controller: TextEditingController(
                        text: pickupTime != null
                            ? pickupTime!.format(context)
                            : '',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        hintText: 'Pilih zona waktu',
                        prefixIcon: const Icon(
                          Icons.public,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedTimeZone,
                      items: timeZoneOffsets.keys
                          .map(
                            (zone) => DropdownMenuItem(
                              value: zone,
                              child: Text(
                                zone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedTimeZone = value!),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    if (pickupDate != null && pickupTime != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xFF2E7D32),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Waktu Konversi: ${_convertTimeZone(DateTime(pickupDate!.year, pickupDate!.month, pickupDate!.day, pickupTime!.hour, pickupTime!.minute), selectedTimeZone, selectedTimeZone == 'WIB'
                                      ? 'WIT'
                                      : selectedTimeZone == 'WIT'
                                      ? 'WITA'
                                      : 'WIB')} (${selectedTimeZone == 'WIB'
                                      ? 'WIT'
                                      : selectedTimeZone == 'WIT'
                                      ? 'WITA'
                                      : 'WIB'})',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF2A4D3A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Validate all fields
                          if (selectedPickupLocation == null ||
                              selectedDestination == null ||
                              selectedVehicle == null ||
                              pickupDate == null ||
                              pickupTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon lengkapi semua data'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Create a Product object for wishlist with unique ID
                          Product travelProduct = Product(
                            id:
                                DateTime.now().millisecondsSinceEpoch +
                                1, // +1 for wishlist
                            name: 'Travel ${widget.mountain.name}',
                            brand: widget.mountain.managedBy,
                            pricePerDay: _calculatePrice(),
                            imageUrl: widget.mountain.image,
                            category: 'travel_ojek',
                            description:
                                'Travel ke ${widget.mountain.name} dari $selectedPickupLocation ke $selectedDestination pada ${DateFormat('dd/MM/yyyy').format(pickupDate!)} pukul ${pickupTime!.format(context)} $selectedTimeZone dengan $selectedVehicle untuk $passengerCount penumpang',
                          );

                          // Add to wishlist
                          MainScreen.wishlistItems.add(travelProduct);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Travel ${widget.mountain.name} ditambahkan ke wishlist!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.pink.shade400,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );

                          // Navigate to wishlist page
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                initialIndex: 1, // Wishlist tab
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Tambah Wishlist',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Validate all fields
                          if (selectedPickupLocation == null ||
                              selectedDestination == null ||
                              selectedVehicle == null ||
                              pickupDate == null ||
                              pickupTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon lengkapi semua data'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Create a Product object for cart with unique ID
                          Product travelProduct = Product(
                            id: DateTime.now().millisecondsSinceEpoch,
                            name: 'Travel ${widget.mountain.name}',
                            brand: widget.mountain.managedBy,
                            pricePerDay: _calculatePrice(),
                            imageUrl: widget.mountain.image,
                            category: 'travel_ojek',
                            description:
                                'Travel ke ${widget.mountain.name} dari $selectedPickupLocation ke $selectedDestination pada ${DateFormat('dd/MM/yyyy').format(pickupDate!)} pukul ${pickupTime!.format(context)} $selectedTimeZone dengan $selectedVehicle untuk $passengerCount penumpang',
                          );

                          // Add to cart
                          MainScreen.cartItems.add(
                            CartItem(product: travelProduct),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Travel ${widget.mountain.name} berhasil dipesan!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );

                          // Navigate to cart page
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                initialIndex: 2, // Cart tab
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Ink(
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'Buat Pesanan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
