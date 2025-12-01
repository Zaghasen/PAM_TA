import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tapak_jejak/models/porter_guide.dart';
import 'package:tapak_jejak/models/product.dart';
import 'package:tapak_jejak/models/cart_item.dart';
import 'package:tapak_jejak/screens/home/main_page.dart';

class PorterGuideDetailPage extends StatefulWidget {
  final PorterGuide porterGuide;

  const PorterGuideDetailPage({super.key, required this.porterGuide});

  @override
  State<PorterGuideDetailPage> createState() => _PorterGuideDetailPageState();
}

class _PorterGuideDetailPageState extends State<PorterGuideDetailPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  Package? selectedPackage;
  DateTime? startDate;
  DateTime? endDate;
  int numberOfPeople = 1;
  bool agreeToTerms = false;
  late TabController _tabController;

  // Equipment checklist
  Map<String, bool> equipmentChecklist = {
    'Tenda': false,
    'Sleeping Bag': false,
    'Carrier/Tas Gunung': false,
    'Matras': false,
    'Kompor & Gas': false,
    'Headlamp': false,
    'Trekking Pole': false,
    'Rain Cover': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatCurrency(double value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }

  double _calculateTotalPrice() {
    if (selectedPackage == null || startDate == null || endDate == null) {
      return 0;
    }

    int days = endDate!.difference(startDate!).inDays + 1;
    double basePrice = selectedPackage!.price * days;

    // Additional cost per person if more than 1
    if (numberOfPeople > 1) {
      basePrice = basePrice * numberOfPeople;
    }

    return basePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
                  'Detail Porter & Guide',
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
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A4D3A), Color(0xFF1B3A2E), Colors.white],
            stops: [0.0, 0.2, 0.5],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            children: [
              // Profile Header
              _buildProfileHeader(),

              // Tab Bar
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Color(0xFF2A4D3A),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color(0xFF2A4D3A),
                      tabs: const [
                        Tab(text: 'Profil'),
                        Tab(text: 'Paket'),
                        Tab(text: 'Review'),
                      ],
                    ),
                    SizedBox(
                      height: 350,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildProfileTab(),
                          _buildPackagesTab(),
                          _buildReviewsTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Hint untuk double tap jika paket sudah dipilih
              if (selectedPackage != null)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade100, Colors.amber.shade50],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade300, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: Colors.amber.shade900,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '✓ ${selectedPackage!.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.amber.shade900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap 2x paket di atas untuk mulai booking',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.amber.shade800,
                              ),
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
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2A4D3A), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.porterGuide.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.porterGuide.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A4D3A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Specialty badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: widget.porterGuide.specialty == 'Both'
                            ? Colors.amber.shade100
                            : widget.porterGuide.specialty == 'Guide'
                            ? Colors.blue.shade100
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.porterGuide.specialty == 'Both'
                            ? 'Porter & Guide'
                            : widget.porterGuide.specialty,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: widget.porterGuide.specialty == 'Both'
                              ? Colors.amber.shade900
                              : widget.porterGuide.specialty == 'Guide'
                              ? Colors.blue.shade900
                              : Colors.green.shade900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade600,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.porterGuide.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.porterGuide.totalReviews})',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Experience
                    Row(
                      children: [
                        Icon(
                          Icons.workspace_premium,
                          color: Color(0xFF2A4D3A),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.porterGuide.experienceYears} tahun',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Achievements
          if (widget.porterGuide.achievements.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.porterGuide.achievements.map((achievement) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade100, Colors.amber.shade50],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        achievement.icon,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        achievement.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Description
        Text(
          widget.porterGuide.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),

        // Languages
        _buildInfoRow(
          icon: Icons.language,
          title: 'Bahasa',
          content: widget.porterGuide.languages.join(', '),
        ),
        const SizedBox(height: 16),

        // Certifications
        _buildInfoRow(
          icon: Icons.verified,
          title: 'Sertifikasi',
          content: widget.porterGuide.certifications.join('\n'),
        ),
        const SizedBox(height: 16),

        // Special Mountains
        _buildInfoRow(
          icon: Icons.terrain,
          title: 'Spesialis Gunung',
          content: widget.porterGuide.specialMountains.join(', '),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFF2A4D3A), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A4D3A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPackagesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.porterGuide.packages.length,
      itemBuilder: (context, index) {
        final package = widget.porterGuide.packages[index];
        final isSelected = selectedPackage == package;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Color(0xFF2A4D3A) : Colors.grey.shade300,
              width: isSelected ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? Color(0xFF2A4D3A).withOpacity(0.05)
                : Colors.white,
          ),
          child: InkWell(
            onDoubleTap: () {
              setState(() {
                selectedPackage = package;
              });
              // Show booking form in bottom sheet
              _showBookingBottomSheet();
            },
            onTap: () {
              setState(() {
                selectedPackage = package;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Tap 2x untuk mulai booking')),
                    ],
                  ),
                  backgroundColor: Color(0xFF2A4D3A),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          package.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Color(0xFF2A4D3A)
                                : Colors.black87,
                          ),
                        ),
                      ),
                      if (package.photoVideoService)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 14,
                                color: Colors.purple.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Photo/Video',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 12),

                  // Includes
                  ...package.includes.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          package.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          _formatCurrency(package.price),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A4D3A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    if (widget.porterGuide.reviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Belum ada review',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.porterGuide.reviews.length,
      itemBuilder: (context, index) {
        final review = widget.porterGuide.reviews[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(review.reviewerPhoto),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.reviewerName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review.date,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber.shade600),
                      const SizedBox(width: 4),
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                review.comment,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '📍 ${review.mountainClimbed}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookingForm() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_note, color: Color(0xFF2A4D3A)),
              const SizedBox(width: 8),
              const Text(
                'Formulir Booking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A4D3A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Dates
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() => startDate = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Mulai',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      startDate != null
                          ? DateFormat('dd/MM/yyyy').format(startDate!)
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
                          content: Text('Pilih tanggal mulai terlebih dahulu'),
                        ),
                      );
                      return;
                    }
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate!,
                      firstDate: startDate!,
                      lastDate: startDate!.add(const Duration(days: 30)),
                    );
                    if (picked != null) {
                      setState(() => endDate = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Selesai',
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

          const SizedBox(height: 20),

          // Number of People
          Row(
            children: [
              const Text(
                'Jumlah Orang:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: numberOfPeople > 1
                    ? () => setState(() => numberOfPeople--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  numberOfPeople.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => numberOfPeople++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Equipment Checklist (if package includes equipment)
          if (selectedPackage!.includes.any(
            (item) =>
                item.toLowerCase().contains('tenda') ||
                item.toLowerCase().contains('sleeping') ||
                item.toLowerCase().contains('carrier'),
          ))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Perlengkapan yang Dibutuhkan:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...equipmentChecklist.keys.map((equipment) {
                  return CheckboxListTile(
                    title: Text(equipment),
                    value: equipmentChecklist[equipment],
                    onChanged: (value) {
                      setState(() {
                        equipmentChecklist[equipment] = value ?? false;
                      });
                    },
                    activeColor: Color(0xFF2A4D3A),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  );
                }),
              ],
            ),

          const SizedBox(height: 20),

          // Terms
          CheckboxListTile(
            title: const Text(
              'Saya setuju dengan syarat dan ketentuan',
              style: TextStyle(fontSize: 14),
            ),
            value: agreeToTerms,
            onChanged: (value) {
              setState(() {
                agreeToTerms = value ?? false;
              });
            },
            activeColor: Color(0xFF2A4D3A),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),

          const SizedBox(height: 20),

          // Price Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.green.shade100],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Harga:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _formatCurrency(_calculateTotalPrice()),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A4D3A),
                      ),
                    ),
                  ],
                ),
                if (startDate != null && endDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Durasi: ${endDate!.difference(startDate!).inDays + 1} hari × $numberOfPeople orang',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Wishlist Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (!agreeToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap setujui syarat dan ketentuan'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (startDate == null || endDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap pilih tanggal mulai dan selesai'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Create Product from PorterGuide booking
                final product = _createProductFromBooking();

                // Add to wishlist
                if (!MainScreen.wishlistItems.any(
                  (item) =>
                      item.name == product.name &&
                      item.description == product.description,
                )) {
                  MainScreen.wishlistItems.add(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Porter/Guide ${widget.porterGuide.name} ditambahkan ke wishlist!',
                              style: const TextStyle(color: Colors.white),
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

                  // Navigate to wishlist
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(initialIndex: 1),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item sudah ada di wishlist'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.favorite, color: Colors.white),
              label: const Text(
                'Wishlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Buat Pesanan Button
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () {
                if (!agreeToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap setujui syarat dan ketentuan'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (startDate == null || endDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap pilih tanggal mulai dan selesai'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Create Product from PorterGuide booking
                final product = _createProductFromBooking();

                // Add to cart
                MainScreen.cartItems.add(CartItem(product: product));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Porter/Guide ${widget.porterGuide.name} berhasil dipesan!',
                            style: const TextStyle(color: Colors.white),
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

                // Navigate to cart
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(initialIndex: 2),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A4D3A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text(
                'Buat Pesanan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Product _createProductFromBooking() {
    // Get selected equipment
    List<String> selectedEquipment = equipmentChecklist.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Build description
    String description =
        '''Porter/Guide: ${widget.porterGuide.name}
Paket: ${selectedPackage!.name}
Tanggal: ${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}
Durasi: ${endDate!.difference(startDate!).inDays + 1} hari
Jumlah Orang: $numberOfPeople orang

Termasuk:
${selectedPackage!.includes.map((item) => '✓ $item').join('\n')}''';

    if (selectedEquipment.isNotEmpty) {
      description +=
          '\n\nPerlengkapan Tambahan:\n${selectedEquipment.map((item) => '✓ $item').join('\n')}';
    }

    return Product(
      id: DateTime.now().millisecondsSinceEpoch,
      name: '${selectedPackage!.name} - ${widget.porterGuide.name}',
      brand: 'Porter & Guide Service',
      pricePerDay: _calculateTotalPrice(),
      imageUrl: widget.porterGuide.photoUrl,
      category: 'porter_guide',
      description: description,
    );
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.event_note, color: Color(0xFF2A4D3A), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Form Booking',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                          Text(
                            selectedPackage!.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Form content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  children: [_buildBookingFormContent()],
                ),
              ),
              // Action buttons at bottom
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _handleWishlist(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          'Wishlist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleBooking(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A4D3A),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          'Buat Pesanan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dates
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => startDate = picked);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Mulai',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    startDate != null
                        ? DateFormat('dd/MM/yyyy').format(startDate!)
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
                        content: Text('Pilih tanggal mulai terlebih dahulu'),
                      ),
                    );
                    return;
                  }
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: startDate!,
                    firstDate: startDate!,
                    lastDate: startDate!.add(const Duration(days: 30)),
                  );
                  if (picked != null) {
                    setState(() => endDate = picked);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Selesai',
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
        const SizedBox(height: 20),

        // Number of People
        Row(
          children: [
            const Text(
              'Jumlah Orang:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: numberOfPeople > 1
                  ? () => setState(() => numberOfPeople--)
                  : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                numberOfPeople.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => setState(() => numberOfPeople++),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Equipment Checklist
        if (selectedPackage!.includes.any(
          (item) =>
              item.toLowerCase().contains('tenda') ||
              item.toLowerCase().contains('sleeping') ||
              item.toLowerCase().contains('carrier'),
        ))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Perlengkapan yang Dibutuhkan:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...equipmentChecklist.keys.map((equipment) {
                return CheckboxListTile(
                  title: Text(equipment),
                  value: equipmentChecklist[equipment],
                  onChanged: (value) {
                    setState(() {
                      equipmentChecklist[equipment] = value ?? false;
                    });
                  },
                  activeColor: Color(0xFF2A4D3A),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                );
              }),
            ],
          ),
        const SizedBox(height: 20),

        // Terms
        CheckboxListTile(
          title: const Text(
            'Saya setuju dengan syarat dan ketentuan',
            style: TextStyle(fontSize: 14),
          ),
          value: agreeToTerms,
          onChanged: (value) {
            setState(() {
              agreeToTerms = value ?? false;
            });
          },
          activeColor: Color(0xFF2A4D3A),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 20),

        // Price Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade50, Colors.green.shade100],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Harga:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    _formatCurrency(_calculateTotalPrice()),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A4D3A),
                    ),
                  ),
                ],
              ),
              if (startDate != null && endDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Durasi: ${endDate!.difference(startDate!).inDays + 1} hari × $numberOfPeople orang',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleWishlist(BuildContext bottomSheetContext) {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui syarat dan ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih tanggal mulai dan selesai'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final product = _createProductFromBooking();

    if (!MainScreen.wishlistItems.any(
      (item) =>
          item.name == product.name && item.description == product.description,
    )) {
      MainScreen.wishlistItems.add(product);

      Navigator.pop(bottomSheetContext); // Close bottom sheet

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.favorite, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Porter/Guide ${widget.porterGuide.name} ditambahkan ke wishlist!',
                  style: const TextStyle(color: Colors.white),
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

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(initialIndex: 1),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item sudah ada di wishlist'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _handleBooking(BuildContext bottomSheetContext) {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui syarat dan ketentuan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih tanggal mulai dan selesai'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final product = _createProductFromBooking();
    MainScreen.cartItems.add(CartItem(product: product));

    Navigator.pop(bottomSheetContext); // Close bottom sheet

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Porter/Guide ${widget.porterGuide.name} berhasil dipesan!',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 2),
      ),
      (route) => false,
    );
  }
}
