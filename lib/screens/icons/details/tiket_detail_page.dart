import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/mountain.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/screens/main_screen.dart';

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
    if (startDate == null || endDate == null) return 0;

    int days = endDate!.difference(startDate!).inDays + 1;
    double basePrice = 0;

    // Get price based on nationality of first person (assuming all same for simplicity)
    String nationality = personalData[0]['nationality'];
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

    double total = days * basePrice * ticketCount;

    // Convert currency if needed
    if (selectedCurrency != 'IDR' && exchangeRates != null) {
      double rate = exchangeRates![selectedCurrency] ?? 1;
      total = total / exchangeRates!['IDR'] * rate;
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Pemesanan Tiket',
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
                                  color: const Color(0x80000000),
                                  offset: const Offset(2, 2),
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
                          Icons.location_pin,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pos Perizinan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
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
                              labelText: 'Pos Masuk',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            initialValue: selectedEntryPoint,
                            items: _getBasecampOptions()
                                .map(
                                  (point) => DropdownMenuItem(
                                    value: point,
                                    child: Text(point),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => selectedEntryPoint = value),
                            validator: (value) =>
                                value == null ? 'Pilih pos masuk' : null,
                          ),
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
                              labelText: 'Pos Keluar',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            initialValue: selectedExitPoint,
                            items: _getBasecampOptions()
                                .map(
                                  (point) => DropdownMenuItem(
                                    value: point,
                                    child: Text(point),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => selectedExitPoint = value),
                            validator: (value) =>
                                value == null ? 'Pilih pos keluar' : null,
                          ),
                        ),
                      ],
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
                          Icons.calendar_today,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tanggal Pendakian',
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
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (picked != null)
                                setState(() => startDate = picked);
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Tanggal Naik',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                startDate != null
                                    ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(startDate!)
                                    : 'Pilih tanggal',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
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
                              if (picked != null)
                                setState(() => endDate = picked);
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Tanggal Turun',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                endDate != null
                                    ? DateFormat('dd/MM/yyyy').format(endDate!)
                                    : 'Pilih tanggal',
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          Icons.confirmation_number,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Jumlah Tiket',
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
                        IconButton(
                          onPressed: ticketCount > 1
                              ? () => setState(() => ticketCount--)
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
                            ticketCount.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() => ticketCount++);
                            if (personalData.length < ticketCount) {
                              _addPerson();
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
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
                        Icon(Icons.person, color: Color(0xFF2A4D3A), size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Data Pribadi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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

              // Price Summary
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rincian Harga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A4D3A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (startDate != null && endDate != null)
                        Text(
                          'Durasi: ${endDate!.difference(startDate!).inDays + 1} hari',
                        ),
                      Text('Jumlah orang: $ticketCount'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: selectedCurrency == 'IDR' ? 'Rp ' : '\$',
                            ).format(_calculatePrice()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: selectedCurrency,
                        items: ['IDR', 'USD', 'EUR', 'JPY']
                            .map(
                              (currency) => DropdownMenuItem(
                                value: currency,
                                child: Text(currency),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedCurrency = value!),
                      ),
                    ],
                  ),
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
                          Product ticketProduct = Product(
                            id: DateTime.now()
                                .millisecondsSinceEpoch, // Unique ID
                            name: 'Tiket ${widget.mountain.name}',
                            brand: widget.mountain.managedBy,
                            pricePerDay: _calculatePrice(),
                            imageUrl: widget.mountain.image,
                            category: 'tiket_masuk',
                            description:
                                'Tiket pendakian untuk ${widget.mountain.name} dari ${startDate != null ? DateFormat('dd/MM/yyyy').format(startDate!) : ''} sampai ${endDate != null ? DateFormat('dd/MM/yyyy').format(endDate!) : ''}',
                          );

                          // Add to cart
                          MainScreen.cartItems.add(ticketProduct);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ditambahkan ke keranjang'),
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
                            const SnackBar(content: Text('Pesanan dibuat')),
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
