import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  final Widget nextPage;

  const TermsScreen({super.key, required this.nextPage});

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _isAgreed = false;

  void _acceptTerms() {
    if (_isAgreed) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF173928),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'ATURAN PENDAKIAN',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildRule('1.', 'Pendaki wajib mengisi form registrasi'),
                      _buildRule(
                        '2.',
                        'Wajib meninggalkan identitas di ambil waktu turun',
                      ),
                      _buildRule(
                        '3.',
                        'Pendaki wajib mengikuti briefing atau arahan petugas',
                      ),
                      _buildRule('4.', 'di larang membuat jalur sendiri'),
                      _buildRule(
                        '5.',
                        'Dilarang mendirikan tenda di SUN RISE VIEW',
                      ),
                      _buildRule(
                        '6.',
                        'Dilarang merusak atau mengambil apapun milik petani di sepanjang jalur pendakian',
                      ),
                      _buildRule(
                        '7.',
                        'Sampah wajib di bawa turun sesuai yang di bawa naik',
                      ),
                      _buildRule(
                        '8.',
                        'Dilarang membuat api unggun atau yg lainya yg bisa mengakibatkan kebakaran',
                      ),
                      _buildRule(
                        '9.',
                        'Dilarang membunuh hewan apapun di sepenjang jalur',
                      ),
                      _buildRule(
                        '10.',
                        'Dilarang membuat keributan yg bisa mengganggu ketertiban umum',
                      ),
                      _buildRule(
                        '11.',
                        'Dilarang merusak atau melubangi pipa yg ada di jalur pendakian',
                      ),
                      _buildRule(
                        '12.',
                        'Dilarang foto di tempat yang berbahaya',
                      ),
                      _buildRule(
                        '13.',
                        'Dilarang membuang sisa makanan sembarangan (sisa makanan wajib untuk di kubur)',
                      ),
                      _buildRule(
                        '14.',
                        'Pendaki wajib mengikuti peraturan yg berlaku di base camp atau masyarakat sekitar',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Jam Buka/Tutup Pos Perizinan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A4D3A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '. Pos Perizinan Buka 24 Jam',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: _isAgreed,
                            onChanged: (value) {
                              setState(() {
                                _isAgreed = value ?? false;
                              });
                            },
                            activeColor: const Color(0xFF2A4D3A),
                          ),
                          Expanded(
                            child: const Text(
                              'Saya telah membaca, menyetujui, dan bersedia mengikuti semua peraturan SOP yang berlaku.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: _isAgreed
                    ? const Color(0xFF2A4D3A)
                    : Colors.grey,
                foregroundColor: Colors.white,
              ),
              onPressed: _isAgreed ? _acceptTerms : null,
              child: const Text('Setuju dan Lanjutkan'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRule(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A4D3A),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
