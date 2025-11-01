import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/product.dart';

class PorterGuideDetailPage extends StatefulWidget {
  final Product product;
  final VoidCallback refreshCallback;

  const PorterGuideDetailPage({
    super.key,
    required this.product,
    required this.refreshCallback,
  });

  @override
  State<PorterGuideDetailPage> createState() => _PorterGuideDetailPageState();
}

class _PorterGuideDetailPageState extends State<PorterGuideDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedEntryPoint;
  String? selectedExitPoint;
  DateTime? startDate;
  DateTime? endDate;

  // Exchange rate data
  Map<String, double>? exchangeRates;
  bool isLoadingRates = true;

  // Currency selection
  String selectedCurrency = 'IDR'; // 'IDR' or 'USD'

  // Service types with prices
  Map<String, bool> selectedServices = {
    'Porter Barang': false,
    'Porter Tenda': false,
    'Porter Air': false,
    'Guide': false,
  };

  Map<String, int> servicePrices = {
    'Porter Barang': 150000,
    'Porter Tenda': 100000,
    'Porter Air': 80000,
    'Guide': 200000,
  };

  Map<String, int> serviceCounts = {
    'Porter Barang': 0,
    'Porter Tenda': 0,
    'Porter Air': 0,
    'Guide': 0,
  };

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

  // Get mountain name from product name
  String getMountainName() {
    if (widget.product.name.contains('Merapi')) return 'Gunung Merapi';
    if (widget.product.name.contains('Merbabu')) return 'Gunung Merbabu';
    if (widget.product.name.contains('Lawu')) return 'Gunung Lawu';
    if (widget.product.name.contains('Semeru')) return 'Gunung Semeru';
    if (widget.product.name.contains('Rinjani')) return 'Gunung Rinjani';
    if (widget.product.name.contains('Slamet')) return 'Gunung Slamet';
    return 'Gunung';
  }

  // Get basecamp options based on mountain
  List<String> _getBasecampOptions() {
    String mountainName = getMountainName();
    switch (mountainName) {
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
      case 'Gunung Lawu':
        return [
          'via Cemoro Sewu (Magetan)',
          'via Cemoro Kandang (Karanganyar)',
          'via Candi Cetho (Karanganyar)',
        ];
      case 'Gunung Semeru':
        return ['via Ranu Pani (Lumajang)'];
      case 'Gunung Rinjani':
        return [
          'via Sembalun (Lombok Timur)',
          'via Senaru (Lombok Utara)',
          'via Torean (Lombok Utara)',
          'via Aik Berik (Lombok Tengah)',
        ];
      case 'Gunung Slamet':
        return [
          'via Bambangan (Purbalingga)',
          'via Guci (Tegal)',
          'via Dipajaya (Pemalang)',
          'via Baturraden (Banyumas)',
        ];
      default:
        return ['Basecamp A', 'Basecamp B', 'Basecamp C'];
    }
  }

  // Get mountain description
  String getMountainDescription() {
    String mountainName = getMountainName();
    switch (mountainName) {
      case 'Gunung Merapi':
        return '''Gunung Merapi adalah gunung berapi aktif yang terletak di perbatasan Provinsi Jawa Tengah dan Daerah Istimewa Yogyakarta. Dengan ketinggian 2.930 mdpl, gunung ini menawarkan pemandangan spektakuler dan jalur pendakian yang menantang.

Keindahan: Panorama sunrise yang memukau, lautan pasir berbisik, dan pemandangan kota-kota di bawahnya.

Tingkat Kesulitan: Menengah hingga sulit, cocok untuk pendaki berpengalaman.

Jumlah Jalur: 2 jalur utama (Selo dan Babadan).

Flora dan Fauna: Pinus merkusii, edelweis, dan berbagai jenis burung endemik.''';
      case 'Gunung Merbabu':
        return '''Gunung Merbabu terletak di Jawa Tengah dengan ketinggian 3.145 mdpl. Gunung ini terkenal dengan panorama sunrise yang memukau dan jalur pendakian yang terjangkau.

Keindahan: Pemandangan hamparan sawah yang hijau, danau kecil di puncak, serta sunrise yang spektakuler.

Tingkat Kesulitan: Menengah, cocok untuk pemula hingga menengah.

Jumlah Jalur: 5 jalur utama (Selo, Suwanting, Wekas, Cuntel, Thekelan).

Flora dan Fauna: Hutan pinus yang lebat, bunga edelweis, dan satwa seperti monyet ekor panjang.''';
      case 'Gunung Lawu':
        return '''Gunung Lawu adalah gunung mistis yang terletak di Jawa Timur dengan ketinggian 3.265 mdpl. Gunung ini memiliki legenda dan pemandangan hamparan sawah yang indah.

Keindahan: Pemandangan sawah terasering yang hijau, kabut pagi yang menyelimuti, dan suasana mistis.

Tingkat Kesulitan: Menengah, membutuhkan stamina yang baik.

Jumlah Jalur: 3 jalur utama (Cemoro Sewu, Cemoro Kandang, Candi Cetho).

Flora dan Fauna: Hutan tropis dengan berbagai jenis pohon, burung langka, dan kupu-kupu.''';
      case 'Gunung Semeru':
        return '''Gunung Semeru adalah gunung tertinggi di Jawa dengan ketinggian 3.676 mdpl. Terletak di Taman Nasional Bromo Tengger Semeru, gunung ini menawarkan tantangan pendakian yang ekstrem.

Keindahan: Kawah aktif yang spektakuler, pemandangan sunrise yang luar biasa, dan hamparan pasir vulkanik.

Tingkat Kesulitan: Sulit hingga sangat sulit, hanya untuk pendaki profesional.

Jumlah Jalur: 1 jalur utama (Ranu Pani).

Flora dan Fauna: Edelweis, bunga khas pegunungan, dan satwa seperti kijang.''';
      case 'Gunung Rinjani':
        return '''Gunung Rinjani terletak di Lombok, Nusa Tenggara Barat dengan ketinggian 3.726 mdpl. Gunung ini memiliki danau Segara Anak yang indah di dalam kawahnya.

Keindahan: Danau kawah yang biru, pemandangan sunset yang memukau, dan panorama pulau Lombok.

Tingkat Kesulitan: Sulit, membutuhkan kondisi fisik prima.

Jumlah Jalur: 4 jalur utama (Sembalun, Senaru, Torean, Aik Berik).

Flora dan Fauna: Hutan tropis dengan pohon besar, burung endemic, dan kupu-kupu.''';
      case 'Gunung Slamet':
        return '''Gunung Slamet adalah gunung tertinggi di Jawa Tengah dengan ketinggian 3.428 mdpl. Gunung ini memiliki hutan yang masih alami dan pemandangan yang indah.

Keindahan: Pemandangan hamparan awan, hutan yang masih asri, dan suasana sepi.

Tingkat Kesulitan: Menengah hingga sulit.

Jumlah Jalur: 4 jalur utama (Bambangan, Guci, Dipajaya, Baturraden).

Flora dan Fauna: Hutan hujan tropis dengan berbagai jenis flora, dan satwa seperti rusa.''';
      default:
        return 'Deskripsi gunung belum tersedia.';
    }
  }

  double _calculatePrice() {
    if (startDate == null || endDate == null) return 0;

    int days = endDate!.difference(startDate!).inDays + 1;
    double total = 0;

    selectedServices.forEach((service, isSelected) {
      if (isSelected) {
        total += servicePrices[service]! * serviceCounts[service]! * days;
      }
    });

    return total;
  }

  String _getOrderSummary() {
    List<String> services = [];
    selectedServices.forEach((service, isSelected) {
      if (isSelected && serviceCounts[service]! > 0) {
        services.add('${serviceCounts[service]} $service');
      }
    });
    return services.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Porter & Guide',
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
                        image: AssetImage(widget.product.imageUrl),
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
                          Text(
                            getMountainName(),
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
                          Text(
                            'Layanan Porter & Guide',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Mountain Description
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
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
                        Icon(Icons.info, color: Color(0xFF2A4D3A), size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Tentang ${getMountainName()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      getMountainDescription(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              // Entry/Exit Points
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
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

              // Service Types
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
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
                        Icon(Icons.hiking, color: Color(0xFF2A4D3A), size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Tipe Layanan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...servicePrices.keys.map(
                      (service) => Column(
                        children: [
                          CheckboxListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    service,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Rp ${servicePrices[service]} / hari',
                                  style: TextStyle(
                                    color: Color(0xFF2A4D3A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            value: selectedServices[service],
                            onChanged: (value) {
                              setState(() {
                                selectedServices[service] = value ?? false;
                                if (!selectedServices[service]!) {
                                  serviceCounts[service] = 0;
                                }
                              });
                            },
                            activeColor: Color(0xFF2A4D3A),
                          ),
                          if (selectedServices[service]!)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: serviceCounts[service]! > 0
                                        ? () => setState(
                                            () => serviceCounts[service] =
                                                serviceCounts[service]! - 1,
                                          )
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
                                      serviceCounts[service].toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => setState(
                                      () => serviceCounts[service] =
                                          serviceCounts[service]! + 1,
                                    ),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Dates
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
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
                              if (picked != null) {
                                setState(() => startDate = picked);
                              }
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
                              if (picked != null) {
                                setState(() => endDate = picked);
                              }
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

              // Order Summary
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
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
                          Icons.assignment,
                          color: Color(0xFF2A4D3A),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Jumlah Pesanan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getOrderSummary().isEmpty
                          ? 'Belum ada layanan yang dipilih'
                          : _getOrderSummary(),
                      style: TextStyle(
                        fontSize: 16,
                        color: _getOrderSummary().isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

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
                      // Currency Selector
                      Row(
                        children: [
                          const Text(
                            'Mata Uang:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'IDR',
                                  groupValue: selectedCurrency,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  },
                                  activeColor: Color(0xFF2A4D3A),
                                ),
                                const Text('IDR (Rupiah)'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'USD',
                                  groupValue: selectedCurrency,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  },
                                  activeColor: Color(0xFF2A4D3A),
                                ),
                                const Text('USD (Dollar)'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (startDate != null && endDate != null)
                        Text(
                          'Durasi: ${endDate!.difference(startDate!).inDays + 1} hari',
                        ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total (${selectedCurrency}):',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            selectedCurrency == 'IDR'
                                ? NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                  ).format(_calculatePrice())
                                : (isLoadingRates
                                      ? 'Loading...'
                                      : (exchangeRates != null
                                            ? NumberFormat.currency(
                                                locale: 'en_US',
                                                symbol: '\$',
                                              ).format(
                                                _calculatePrice() /
                                                    exchangeRates!['IDR']!,
                                              )
                                            : 'Rate unavailable')),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Action Button
              ElevatedButton(
                onPressed: () {
                  // Validate form
                  if (_formKey.currentState?.validate() ?? false) {
                    // Check if at least one service is selected
                    bool hasSelectedService = selectedServices.values.any(
                      (selected) => selected,
                    );
                    if (!hasSelectedService) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih minimal satu jenis layanan'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Check if dates are selected
                    if (startDate == null || endDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih tanggal pendakian'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Check if entry and exit points are selected
                    if (selectedEntryPoint == null ||
                        selectedExitPoint == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pilih pos masuk dan pos keluar'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // If all validations pass, show the "fully booked" dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Tidak bisa melakukan pemesanan'),
                          content: const Text(
                            'Semua porter gunung ini telah disewa',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Harap lengkapi semua form terlebih dahulu',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A4D3A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
