import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/login_screen.dart';
import 'package:tapak_jejak/screens/membership_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  'Profil Saya',
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
