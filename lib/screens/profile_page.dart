import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/membership_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                // Ganti dengan foto jika ada URL-nya
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(height: 20),
              _buildProfileInfo('Nama', 'Zalfa Ghalib Hussein'),
              _buildProfileInfo('NIM', '124230097'),
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

  Widget _buildProfileInfo(String title, String subtitle) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
