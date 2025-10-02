import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/login_screen.dart';
import 'package:tugas_akhir_097/screens/membership_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('assets/profile.png'),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileInfo('Nama', 'Zalfa Ghalib Hussein', Icons.person),
              _buildProfileInfo('NIM', '124230097', Icons.badge),
              _buildProfileInfo('Tempat', 'Magelang', Icons.location_on),
              _buildProfileInfo(
                'Tanggal Lahir',
                '11 November 2004',
                Icons.cake,
              ),
              _buildProfileInfo('Hobi', 'Mendaki', Icons.hiking),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF2A4D3A),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
              const SizedBox(height: 20),
              _buildHomeCard(
                context,
                'Status Membership',
                'Lihat keuntungan eksklusif Anda sebagai member.',
                Icons.card_membership,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembershipPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String subtitle, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2A4D3A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildHomeCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: const Color(0xFF2A4D3A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
