import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/mountain.dart';
import 'package:tapak_jejak/models/ticket_order.dart';
import 'package:tapak_jejak/screens/home/main_page.dart';
import 'package:tapak_jejak/services/notification_controller.dart';

class TiketDetailPage extends StatefulWidget {
  final Mountain mountain;

  const TiketDetailPage({super.key, required this.mountain});

  @override
  State<TiketDetailPage> createState() => _TiketDetailPageState();
}

class _TiketDetailPageState extends State<TiketDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedEntryPoint;
  String? selectedExitPoint;
  DateTime? startDate;
  DateTime? endDate;
  int ticketCount = 1;
  int? leaderIndex;
  String selectedCurrency = 'IDR';
  Map<String, dynamic>? exchangeRates;
  bool isLoadingRates = false;

  List<Map<String, dynamic>> personalData = [
    {
      'name': '',
      'ktp': '',
      'address': '',
      'birthDate': null,
      'nationality': 'WNI',
    },
  ];

  List<String> _getBasecampOptions() {
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

  @override
  void initState() {
    super.initState();
    _loadExchangeRates();
  }

  Future<void> _loadExchangeRates() async {
    setState(() => isLoadingRates = true);
    try {
      final response = await http.get(
        Uri.parse(
          'https://v6.exchangerate-api.com/v6/77d1037daf793bd583386ce0/latest/USD',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          exchangeRates = data['conversion_rates'];
          isLoadingRates = false;
        });
      }
    } catch (e) {
      setState(() => isLoadingRates = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat kurs mata uang')),
      );
    }
  }

  double _calculatePrice() {
    if (startDate == null || endDate == null) return 0.0;

    int days = endDate!.difference(startDate!).inDays + 1;
    double basePrice = 0.0;

    // Get price based on nationality of first person (assuming all same for simplicity)
    String nationality = personalData.isNotEmpty
        ? personalData[0]['nationality']
        : 'WNI';
    bool isHoliday = _isHoliday(startDate!) || _isHoliday(endDate!);

    if (nationality == 'WNI') {
      basePrice = isHoliday
          ? widget.mountain.prices['Hari Libur WNI']!.toDouble()
          : widget.mountain.prices['Hari Kerja WNI']!.toDouble();
    } else {
      basePrice = isHoliday
          ? widget.mountain.prices['Hari Libur WNA']!.toDouble()
          : widget.mountain.prices['Hari Kerja WNA']!.toDouble();
    }

    double total = (days * basePrice * ticketCount).toDouble();

    // Convert currency if needed
    if (selectedCurrency != 'IDR' && exchangeRates != null) {
      // Exchange rates are based on USD, so we need to:
      // 1. Convert IDR to USD first: IDR / IDR_rate
      // 2. Then convert USD to target currency: USD * target_rate
      double idrRate = (exchangeRates!['IDR'] ?? 1.0).toDouble();
      double targetRate = (exchangeRates![selectedCurrency] ?? 1.0).toDouble();
      total = (total / idrRate) * targetRate;
    }

    return total;
  }

  bool _isHoliday(DateTime date) {
    // Simple holiday check - you can expand this
    int day = date.weekday;
    return day == DateTime.saturday || day == DateTime.sunday;
  }

  void _addPerson() {
    setState(() {
      personalData.add({
        'name': '',
        'ktp': '',
        'address': '',
        'birthDate': null,
        'nationality': 'WNI',
      });
    });
  }

  void _removePerson(int index) {
    if (personalData.length > 1) {
      setState(() {
        personalData.removeAt(index);
        if (leaderIndex == index) {
          leaderIndex = null;
        } else if (leaderIndex != null && leaderIndex! > index)
          leaderIndex = leaderIndex! - 1;
      });
    }
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
                  'Pemesanan Tiket',
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
              top: 16,
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

              // Entry/Exit Points
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
                            Icons.location_pin,
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
                                'Pos Perizinan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Pilih pos masuk dan keluar',
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
                        fillColor: Colors.white,
                        hintText: 'Pilih pos masuk',
                        prefixIcon: const Icon(
                          Icons.login,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedEntryPoint,
                      items: _getBasecampOptions()
                          .map(
                            (point) => DropdownMenuItem(
                              value: point,
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedEntryPoint = value),
                      validator: (value) =>
                          value == null ? 'Pilih pos masuk' : null,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Pilih pos keluar',
                        prefixIcon: const Icon(
                          Icons.logout,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      initialValue: selectedExitPoint,
                      items: _getBasecampOptions()
                          .map(
                            (point) => DropdownMenuItem(
                              value: point,
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedExitPoint = value),
                      validator: (value) =>
                          value == null ? 'Pilih pos keluar' : null,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Dates
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
                            Icons.calendar_today,
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
                                'Tanggal Pendakian',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Pilih tanggal naik dan turun',
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
                        fillColor: Colors.white,
                        hintText: 'Pilih tanggal naik',
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null) {
                              setState(() => startDate = picked);
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      controller: TextEditingController(
                        text: startDate != null
                            ? DateFormat('dd/MM/yyyy').format(startDate!)
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
                        fillColor: Colors.white,
                        hintText: 'Pilih tanggal turun',
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
                            if (startDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Pilih tanggal naik terlebih dahulu',
                                  ),
                                ),
                              );
                              return;
                            }
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: startDate!,
                              firstDate: startDate!,
                              lastDate: startDate!.add(
                                const Duration(days: 30),
                              ),
                            );
                            if (picked != null) {
                              setState(() => endDate = picked);
                            }
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      controller: TextEditingController(
                        text: endDate != null
                            ? DateFormat('dd/MM/yyyy').format(endDate!)
                            : '',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Ticket Count
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
                            Icons.confirmation_number,
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
                                'Jumlah Tiket',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Berapa tiket yang diperlukan?',
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Color(0xFF2E7D32),
                              size: 24,
                            ),
                            onPressed: () {
                              if (ticketCount > 1) {
                                setState(() {
                                  ticketCount--;
                                });
                              }
                            },
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Jumlah tiket',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                                controller: TextEditingController(
                                  text: ticketCount.toString(),
                                ),
                                onChanged: (value) {
                                  int? newQuantity = int.tryParse(value);
                                  if (newQuantity != null && newQuantity > 0) {
                                    setState(() {
                                      ticketCount = newQuantity;
                                      while (personalData.length <
                                          ticketCount) {
                                        _addPerson();
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Color(0xFF2E7D32),
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                ticketCount++;
                                if (personalData.length < ticketCount) {
                                  _addPerson();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Personal Data
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
                            Icons.person,
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
                                'Data Pribadi',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Isi informasi pendaki',
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
                    ...List.generate(personalData.length, (index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Orang ke-${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (personalData.length > 1)
                                    IconButton(
                                      onPressed: () => _removePerson(index),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nama Lengkap',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) =>
                                    personalData[index]['name'] = value,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Nama wajib diisi'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nomor KTP',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    personalData[index]['ktp'] = value,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'KTP wajib diisi'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Tempat Tinggal',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) =>
                                    personalData[index]['address'] = value,
                                validator: (value) => value?.isEmpty ?? true
                                    ? 'Alamat wajib diisi'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(
                                      const Duration(days: 365 * 18),
                                    ),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setState(
                                      () => personalData[index]['birthDate'] =
                                          picked,
                                    );
                                  }
                                },
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Tanggal Lahir',
                                    border: OutlineInputBorder(),
                                  ),
                                  child: Text(
                                    personalData[index]['birthDate'] != null
                                        ? DateFormat('dd/MM/yyyy').format(
                                            personalData[index]['birthDate'],
                                          )
                                        : 'Pilih tanggal lahir',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Kewarganegaraan',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue:
                                    personalData[index]['nationality'],
                                items: ['WNI', 'WNA']
                                    .map(
                                      (nat) => DropdownMenuItem(
                                        value: nat,
                                        child: Text(nat),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => setState(
                                  () => personalData[index]['nationality'] =
                                      value,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CheckboxListTile(
                                title: const Text('Jadikan Ketua Rombongan'),
                                value: leaderIndex == index,
                                onChanged: (value) {
                                  setState(() {
                                    leaderIndex = value == true ? index : null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (ticketCount > personalData.length)
                      ElevatedButton(
                        onPressed: _addPerson,
                        child: const Text('Tambah Data Orang'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Price Summary - Enhanced
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
                            Icons.account_balance_wallet,
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
                                'Rincian Harga',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2A4D3A),
                                ),
                              ),
                              Text(
                                'Detail pembayaran tiket',
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
                    // Price Details
                    if (startDate != null && endDate != null) ...[
                      _buildPriceDetailRow(
                        Icons.calendar_today,
                        'Durasi',
                        '${endDate!.difference(startDate!).inDays + 1} hari',
                      ),
                      const SizedBox(height: 8),
                    ],
                    _buildPriceDetailRow(
                      Icons.people,
                      'Jumlah Pendaki',
                      '$ticketCount orang',
                    ),
                    const SizedBox(height: 8),
                    _buildPriceDetailRow(
                      Icons.confirmation_number,
                      'Tipe Tiket',
                      personalData.isNotEmpty &&
                              personalData[0]['nationality'] == 'WNI'
                          ? 'WNI'
                          : 'WNA',
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 2),
                    const SizedBox(height: 16),
                    // Currency Selector
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Pilih mata uang',
                        prefixIcon: const Icon(
                          Icons.currency_exchange,
                          color: Color(0xFF2E7D32),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        isDense: true,
                      ),
                      initialValue: selectedCurrency,
                      items: [
                        _buildCurrencyMenuItem('IDR', '🇮🇩', 'Rupiah'),
                        _buildCurrencyMenuItem('USD', '🇺🇸', 'US Dollar'),
                        _buildCurrencyMenuItem('EUR', '🇪🇺', 'Euro'),
                        _buildCurrencyMenuItem('JPY', '🇯🇵', 'Yen'),
                      ],
                      onChanged: (value) =>
                          setState(() => selectedCurrency = value!),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      isExpanded: true,
                    ),
                    const SizedBox(height: 20),
                    // Total Price
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Termasuk biaya admin',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatCurrency(_calculatePrice()),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (isLoadingRates)
                                const SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ],
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
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (selectedEntryPoint == null ||
                              selectedExitPoint == null ||
                              startDate == null ||
                              endDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon lengkapi semua data'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Validate personal data
                          for (var person in personalData) {
                            if (person['name'].toString().isEmpty ||
                                person['ktp'].toString().isEmpty ||
                                person['address'].toString().isEmpty ||
                                person['birthDate'] == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Mohon lengkapi semua data pribadi',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          }

                          // Create ticket order for wishlist
                          List<PersonData> persons = personalData
                              .asMap()
                              .entries
                              .map(
                                (entry) => PersonData(
                                  name: entry.value['name'],
                                  ktp: entry.value['ktp'],
                                  address: entry.value['address'],
                                  birthDate: entry.value['birthDate'],
                                  nationality: entry.value['nationality'],
                                  isLeader: entry.key == leaderIndex,
                                ),
                              )
                              .toList();

                          TicketOrder wishlistOrder = TicketOrder(
                            id: 'WISH-${DateTime.now().millisecondsSinceEpoch}',
                            mountainName: widget.mountain.name,
                            mountainImage: widget.mountain.image,
                            entryPoint: selectedEntryPoint!,
                            exitPoint: selectedExitPoint!,
                            startDate: startDate!,
                            endDate: endDate!,
                            ticketCount: ticketCount,
                            personalData: persons,
                            leaderIndex: leaderIndex,
                            totalPrice: _calculatePrice(),
                            currency: selectedCurrency,
                            managedBy: widget.mountain.managedBy,
                            orderDate: DateTime.now(),
                          );

                          // Add to wishlist
                          if (!MainScreen.wishlistTicketOrders.any(
                            (o) => o.id == wishlistOrder.id,
                          )) {
                            MainScreen.wishlistTicketOrders.add(wishlistOrder);
                          }

                          // Send notification
                          await NotificationController.showSuccessNotification(
                            '💚 Ditambahkan ke Wishlist!',
                            'Tiket ${widget.mountain.name} berhasil masuk wishlist. Jangan lupa booking ya!',
                          );

                          // Navigate to wishlist page
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                initialIndex: 1, // Wishlist tab
                              ),
                            ),
                            (route) => false, // Remove all previous routes
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (selectedEntryPoint == null ||
                              selectedExitPoint == null ||
                              startDate == null ||
                              endDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon lengkapi semua data'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Validate personal data
                          for (var person in personalData) {
                            if (person['name'].toString().isEmpty ||
                                person['ktp'].toString().isEmpty ||
                                person['address'].toString().isEmpty ||
                                person['birthDate'] == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Mohon lengkapi semua data pribadi',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          }

                          // Create ticket order
                          List<PersonData> persons = personalData
                              .asMap()
                              .entries
                              .map(
                                (entry) => PersonData(
                                  name: entry.value['name'],
                                  ktp: entry.value['ktp'],
                                  address: entry.value['address'],
                                  birthDate: entry.value['birthDate'],
                                  nationality: entry.value['nationality'],
                                  isLeader: entry.key == leaderIndex,
                                ),
                              )
                              .toList();

                          TicketOrder order = TicketOrder(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            mountainName: widget.mountain.name,
                            mountainImage: widget.mountain.image,
                            entryPoint: selectedEntryPoint!,
                            exitPoint: selectedExitPoint!,
                            startDate: startDate!,
                            endDate: endDate!,
                            ticketCount: ticketCount,
                            personalData: persons,
                            leaderIndex: leaderIndex,
                            totalPrice: _calculatePrice(),
                            currency: selectedCurrency,
                            managedBy: widget.mountain.managedBy,
                            orderDate: DateTime.now(),
                          );

                          // Add to cart (store in MainScreen)
                          if (!MainScreen.ticketOrders.contains(order)) {
                            MainScreen.ticketOrders.add(order);
                          }

                          // Send notification
                          await NotificationController.showSuccessNotification(
                            '🎉 Pesanan Dibuat!',
                            'Tiket ${widget.mountain.name} siap dibayar! Cek keranjang untuk lihat barcode dan detail.',
                          );

                          // Navigate to cart page
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(
                                initialIndex: 2, // Cart tab
                              ),
                            ),
                            (route) => false, // Remove all previous routes
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

  // Helper method untuk format mata uang dengan simbol yang benar
  String _formatCurrency(double amount) {
    switch (selectedCurrency) {
      case 'IDR':
        return NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp ',
          decimalDigits: 0,
        ).format(amount);
      case 'USD':
        return NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$ ',
          decimalDigits: 2,
        ).format(amount);
      case 'EUR':
        return NumberFormat.currency(
          locale: 'de_DE',
          symbol: '€ ',
          decimalDigits: 2,
        ).format(amount);
      case 'JPY':
        return NumberFormat.currency(
          locale: 'ja_JP',
          symbol: '¥ ',
          decimalDigits: 0,
        ).format(amount);
      default:
        return NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp ',
          decimalDigits: 0,
        ).format(amount);
    }
  }

  // Helper method untuk price detail row
  Widget _buildPriceDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF2A4D3A)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2A4D3A),
          ),
        ),
      ],
    );
  }

  // Helper method untuk currency dropdown item dengan bendera dan simbol yang benar
  DropdownMenuItem<String> _buildCurrencyMenuItem(
    String currency,
    String flag,
    String name,
  ) {
    // Simbol mata uang yang benar
    String symbol;
    switch (currency) {
      case 'IDR':
        symbol = 'Rp';
        break;
      case 'USD':
        symbol = '\$';
        break;
      case 'EUR':
        symbol = '€';
        break;
      case 'JPY':
        symbol = '¥';
        break;
      default:
        symbol = currency;
    }

    return DropdownMenuItem(
      value: currency,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(flag, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$symbol $currency - $name',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
