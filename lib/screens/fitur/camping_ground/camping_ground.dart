import 'package:flutter/material.dart';
import 'camping_ground_detail_page.dart';
import 'package:tapak_jejak/models/mountain.dart';

class CampingGroundPage extends StatefulWidget {
  const CampingGroundPage({super.key});

  @override
  State<CampingGroundPage> createState() => _CampingGroundPageState();
}

class _CampingGroundPageState extends State<CampingGroundPage> {
  String? selectedMountain;
  DateTime? selectedDate;
  int ticketQuantity = 1;

  final List<String> mountains = [
    'Gunung Merapi',
    'Gunung Merbabu',
    'Gunung Lawu',
    'Gunung Semeru',
    'Gunung Rinjani',
    'Gunung Slamet',
    'Gunung Sindoro',
    'Gunung Sumbing',
    'Gunung Prau',
    'Gunung Raung',
    'Gunung Andong',
    'Gunung Buthak',
    'Gunung Kembang',
    'Gunung Pakuwaja',
    'Gunung Telomoyo',
    'Gunung Ungaran',
    'Gunung Bismo',
    'Gunung Agung',
    'Gunung Argopuro',
    'Gunung Arjuno',
    'Gunung Bawakaraeng',
    'Gunung Binaiya',
    'Bukit Raya',
    'Gunung Cikuray',
    'Gunung Ciremai',
    'Gunung Dempo',
    'Gunung Gamalama',
    'Gunung Gandang Dewata',
    'Gunung Gede',
    'Gunung Halau-Halau',
    'Gunung Halimun',
    'Gunung Inerie',
    'Gunung Kerinci',
    'Gunung Leuser',
    'Gunung Marapi',
    'Gunung Mekongga',
    'Gunung Pangrango',
    'Gunung Papandayan',
    'Gunung Pesagi',
    'Puncak Jaya',
    'Gunung Sibuatan',
    'Gunung Welirang',
    'Gunung Trikora',
    'Gunung Talamau',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2A4D3A),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _search() {
    if (selectedMountain != null &&
        selectedDate != null &&
        ticketQuantity > 0) {
      // Navigate to detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CampingGroundDetailPage(
            mountain: Mountain(
              name: selectedMountain!,
              image: '',
              managedBy: '',
              prices: {},
              description: '',
              location: '',
              height: 0.0,
            ),
            date: selectedDate!,
            quantity: ticketQuantity,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua pilihan'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
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
                  'Camping Ground',
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/mountain_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Header Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '🏕️',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Temukan Petualangan',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2A4D3A),
                                  ),
                                ),
                                Text(
                                  'Camping Impianmu',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xFF2E7D32),
                              size: 14,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '44 Gunung Indonesia',
                              style: TextStyle(
                                color: Color(0xFF2E7D32),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Mountain Selection
                _buildSectionCard(
                  icon: Icons.terrain,
                  title: 'Pilih Destinasi Gunung',
                  subtitle: 'Temukan gunung favoritmu',
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Pilih gunung impianmu',
                      prefixIcon: const Icon(
                        Icons.landscape,
                        color: Color(0xFF2E7D32),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    initialValue: selectedMountain,
                    items: mountains.map((String mountain) {
                      return DropdownMenuItem<String>(
                        value: mountain,
                        child: Text(
                          mountain,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMountain = newValue;
                      });
                    },
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    menuMaxHeight: 300,
                  ),
                ),

                const SizedBox(height: 20),

                // Date Selection
                _buildSectionCard(
                  icon: Icons.calendar_today,
                  title: 'Tanggal Keberangkatan',
                  subtitle: 'Pilih waktu yang tepat',
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Pilih tanggal keberangkatan',
                      prefixIcon: const Icon(
                        Icons.event,
                        color: Color(0xFF2E7D32),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF2E7D32),
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : '',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Quantity Selection
                _buildSectionCard(
                  icon: Icons.people,
                  title: 'Jumlah Peserta',
                  subtitle: 'Berapa orang yang ikut?',
                  child: Container(
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
                            if (ticketQuantity > 1) {
                              setState(() {
                                ticketQuantity--;
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
                                hintText: 'Jumlah orang',
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2A4D3A),
                              ),
                              controller: TextEditingController(
                                text: ticketQuantity.toString(),
                              ),
                              onChanged: (value) {
                                int? newQuantity = int.tryParse(value);
                                if (newQuantity != null && newQuantity > 0) {
                                  setState(() {
                                    ticketQuantity = newQuantity;
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
                              ticketQuantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Search Button
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _search,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.explore, color: Colors.white, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Mulai Petualangan!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Fun Fact Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.lightbulb,
                          color: Color(0xFF2E7D32),
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '💡 Tips Petualangan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A4D3A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bawa peralatan lengkap, jaga kebersihan, hormati alam, dan buat kenangan indah di pegunungan Indonesia! 🏞️',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
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
                child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A4D3A),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
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
          child,
        ],
      ),
    );
  }
}
