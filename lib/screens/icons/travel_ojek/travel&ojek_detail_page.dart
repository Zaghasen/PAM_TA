import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/mountain.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/main_page.dart';
import 'pesanan(travel)_detail_page.dart';

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
  int vehicleCount = 1;
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

  List<String> _getBasecampOptions() {
    return _getDestinationOptions();
  }

  double _calculatePrice() {
    // Simple pricing logic for travel ojek
    double basePrice = 50000; // Base price per vehicle
    double passengerMultiplier = passengerCount * 10000;
    double vehicleMultiplier = vehicleCount * 20000;
    return (basePrice + passengerMultiplier + vehicleMultiplier) * vehicleCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Travel ${widget.mountain.name}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2A4D3A).withOpacity(0.9),
                Color(0xFF1B3A2E).withOpacity(0.9),
              ],
            ),
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
              top: 100,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            children: [
              // Hero Mountain Card
              Container(
                margin: const EdgeInsets.only(bottom: 24),
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
                  borderRadius: BorderRadius.circular(16),
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
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Lokasi Penjemputan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pilih Lokasi',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        value: selectedPickupLocation,
                        items: pickupLocations
                            .map(
                              (location) => DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedPickupLocation = value),
                        validator: (value) =>
                            value == null ? 'Pilih lokasi penjemputan' : null,
                      ),
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
                  borderRadius: BorderRadius.circular(16),
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
                        Icon(Icons.flag, color: Color(0xFF2A4D3A), size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Lokasi Tujuan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pilih Basecamp',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        value: selectedDestination,
                        items: _getDestinationOptions()
                            .map(
                              (destination) => DropdownMenuItem(
                                value: destination,
                                child: Text(destination),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedDestination = value),
                        validator: (value) =>
                            value == null ? 'Pilih lokasi tujuan' : null,
                      ),
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
                  borderRadius: BorderRadius.circular(16),
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
                        Icon(
                          Icons.directions_car,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pilih Kendaraan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pilih Kendaraan',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        value: selectedVehicle,
                        items: vehicles
                            .map(
                              (vehicle) => DropdownMenuItem(
                                value: vehicle,
                                child: Text(vehicle),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedVehicle = value),
                        validator: (value) =>
                            value == null ? 'Pilih kendaraan' : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Jumlah Penumpang & Kendaraan
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                        Icon(Icons.people, color: Color(0xFF2A4D3A), size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Jumlah Penumpang & Kendaraan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Penumpang',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: passengerCount > 1
                                        ? () => setState(() => passengerCount--)
                                        : null,
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      passengerCount.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        setState(() => passengerCount++),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kendaraan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: vehicleCount > 1
                                        ? () => setState(() => vehicleCount--)
                                        : null,
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      vehicleCount.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        setState(() => vehicleCount++),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
                  borderRadius: BorderRadius.circular(16),
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
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Waktu Penjemputan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
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
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Tanggal',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                pickupDate != null
                                    ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(pickupDate!)
                                    : 'Pilih tanggal',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: pickupTime ?? TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() => pickupTime = picked);
                              }
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Waktu',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                pickupTime != null
                                    ? pickupTime!.format(context)
                                    : 'Pilih waktu',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Zona Waktu',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedTimeZone,
                      items: timeZoneOffsets.keys
                          .map(
                            (zone) => DropdownMenuItem(
                              value: zone,
                              child: Text(zone),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedTimeZone = value!),
                    ),
                    if (pickupDate != null && pickupTime != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
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
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
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
                          // Create a Product object from the form data
                          Product travelProduct = Product(
                            id: DateTime.now()
                                .millisecondsSinceEpoch, // Unique ID
                            name: 'Travel Ojek ${widget.mountain.name}',
                            brand: widget.mountain.managedBy,
                            pricePerDay: _calculatePrice(),
                            imageUrl: widget.mountain.image,
                            category: 'travel_ojek',
                            description:
                                'Travel ojek ke ${widget.mountain.name} dari ${selectedPickupLocation} ke ${selectedDestination} pada ${pickupDate != null ? DateFormat('dd/MM/yyyy').format(pickupDate!) : ''} pukul ${pickupTime != null ? pickupTime!.format(context) : ''}',
                          );

                          // Add to cart
                          MainScreen.cartItems.add(travelProduct);

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
                                      'Yeay! Travel ojek ${widget.mountain.name} sudah masuk keranjang. Ayo lanjutkan petualanganmu!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              duration: const Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Masukkan Keranjang',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Create order logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.celebration,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Horay! Pesanan travel ojek ${widget.mountain.name} berhasil dibuat. Siapkan dirimu untuk petualangan epik!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.blue.shade600,
                              duration: const Duration(seconds: 5),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              action: SnackBarAction(
                                label: 'Lihat Detail',
                                textColor: Colors.yellow,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PesananDetailPage(
                                        mountain: widget.mountain,
                                        orderData: {
                                          'selectedPickupLocation':
                                              selectedPickupLocation,
                                          'selectedDestination':
                                              selectedDestination,
                                          'selectedVehicle': selectedVehicle,
                                          'passengerCount': passengerCount,
                                          'vehicleCount': vehicleCount,
                                          'pickupDate': pickupDate,
                                          'pickupTime': pickupTime,
                                          'selectedTimeZone': selectedTimeZone,
                                          'totalPrice': _calculatePrice(),
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A4D3A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Buat Pesanan',
                        style: TextStyle(color: Colors.white),
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
