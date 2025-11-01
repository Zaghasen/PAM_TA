import 'package:flutter/material.dart';
import 'package:tapak_jejak/models/mountain.dart';

class TripDetailPage extends StatefulWidget {
  final Mountain mountain;

  const TripDetailPage({super.key, required this.mountain});

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  String? selectedDateFilter;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mountain.name),
        backgroundColor: const Color(0xFF2A4D3A),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Empty Image
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/trip_kosong.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                // Message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Belum ada paket Opentrip pada gunung ${widget.mountain.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2A4D3A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                // Date Filter
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade100.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter Tanggal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A4D3A),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Pilih Tanggal',
                          labelStyle: const TextStyle(
                            color: Color(0xFF2A4D3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        value: selectedDateFilter,
                        style: const TextStyle(
                          color: Color(0xFF2A4D3A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.white,
                        items: const [
                          DropdownMenuItem(
                            value: 'Semua tanggal',
                            child: Text('Semua tanggal'),
                          ),
                          DropdownMenuItem(
                            value: '3 hari kedepan',
                            child: Text('3 hari kedepan'),
                          ),
                          DropdownMenuItem(
                            value: '7 hari kedepan',
                            child: Text('7 hari kedepan'),
                          ),
                          DropdownMenuItem(
                            value: '30 hari kedepan',
                            child: Text('30 hari kedepan'),
                          ),
                          DropdownMenuItem(
                            value: 'Pilih tanggal sendiri',
                            child: Text('Pilih tanggal sendiri'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedDateFilter = value;
                            if (value == 'Pilih tanggal sendiri') {
                              _selectDateRange(context);
                            }
                          });
                        },
                      ),
                      if (selectedDateFilter == 'Pilih tanggal sendiri' &&
                          startDate != null &&
                          endDate != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'Tanggal: ${startDate!.day}/${startDate!.month}/${startDate!.year} - ${endDate!.day}/${endDate!.month}/${endDate!.year}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2A4D3A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
