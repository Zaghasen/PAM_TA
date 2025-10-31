import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tapak_jejak/models/user.dart';
import 'package:tapak_jejak/screens/login_page.dart';
import 'package:tapak_jejak/screens/membership_page.dart';
import 'package:tapak_jejak/services/hive_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Box _userBox;
  String _username = '';
  File? _profileImage;
  final TextEditingController _bioController = TextEditingController();

  // Biodata fields
  String _fullName = 'No Name';
  String _address = 'No Address';
  String _hobbies = 'No Hobbies';
  String _impression = 'No Impression';
  String _phoneNumber = 'No Phone Number';

  bool _isEditingBiodata = false; // Flag to toggle editing mode

  final HiveService _hiveService = HiveService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';

    _userBox = await Hive.openBox('userBox');
    final user = await _hiveService.getUserData(_username);
    if (user != null) {
      setState(() {
        _fullName = user.fullName;
        _address = user.address;
        _hobbies = user.hobbies;
        _impression = user.impression;
        _phoneNumber = user.phoneNumber;
      });
    }

    final imagePath = await _hiveService.getProfileImage(_username);
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _saveBio() async {
    final user = User(
      username: _username,
      password: '', // Not updating password here
      email: '', // Not updating email here
      fullName: _fullName,
      address: _address,
      hobbies: _hobbies,
      impression: _impression,
      phoneNumber: _phoneNumber,
    );
    await _hiveService.saveUserData(_username, user);

    setState(() {
      _isEditingBiodata = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biodata berhasil diperbarui!')),
    );
  }

  Future<void> _chooseProfileImage() async {
    final picker = ImagePicker();

    final pickedImage = await showDialog<XFile?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Foto Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto'),
                onTap: () async {
                  Navigator.pop(
                    context,
                    await picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(
                    context,
                    await picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      await _hiveService.saveProfileImage(_username, pickedImage.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto profil berhasil diperbarui!')),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await _hiveService.clearUserData(_username);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
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
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: _chooseProfileImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/profile.png'),
                      child: _profileImage == null
                          ? Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: GestureDetector(
                      onTap: _chooseProfileImage,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Nama Pengguna: $_username',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Biodata',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!_isEditingBiodata)
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  _isEditingBiodata = !_isEditingBiodata;
                                });
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_isEditingBiodata) ...[
                        _buildTextField(
                          'Nama Lengkap',
                          _fullName,
                          (value) => _fullName = value,
                        ),
                        _buildTextField(
                          'Alamat',
                          _address,
                          (value) => _address = value,
                        ),
                        _buildTextField(
                          'Hobi',
                          _hobbies,
                          (value) => _hobbies = value,
                        ),
                        _buildTextField(
                          'Kesan',
                          _impression,
                          (value) => _impression = value,
                        ),
                        _buildTextField(
                          'Nomor Telepon',
                          _phoneNumber,
                          (value) => _phoneNumber = value,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveBio,
                          child: const Text('Simpan Perubahan'),
                        ),
                      ] else ...[
                        _buildBiodataRow('Nama Lengkap', _fullName),
                        _buildBiodataRow('Alamat', _address),
                        _buildBiodataRow('Hobi', _hobbies),
                        _buildBiodataRow('Kesan', _impression),
                        _buildBiodataRow('No Hp', _phoneNumber),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
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

  Widget _buildTextField(
    String label,
    String value,
    Function(String) onChanged,
  ) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }

  Widget _buildBiodataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
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
