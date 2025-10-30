import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapak_jejak/models/user.dart';
import 'package:tapak_jejak/screens/main_screen.dart';
import 'package:tapak_jejak/services/hive_service.dart';
import 'dart:convert';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignUp = false;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final HiveService _hiveService = HiveService();

  Future<void> _signUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
      return;
    }

    String? storedData = await secureStorage.read(key: 'accounts');
    List<Map<String, String>> accounts = [];

    if (storedData != null) {
      var decodedData = json.decode(storedData);
      if (decodedData is List) {
        accounts = List<Map<String, String>>.from(
          decodedData.map((item) => Map<String, String>.from(item)),
        );
      }
    }

    for (var account in accounts) {
      if (account['username'] == username) {
        setState(() {
          _errorMessage = 'Username already exists';
        });
        return;
      }
    }

    accounts.add({'username': username, 'email': email, 'password': password});

    await secureStorage.write(key: 'accounts', value: json.encode(accounts));

    final user = User(username: username, password: password, email: email);
    await _hiveService.saveUserData(username, user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil dibuat!'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _isSignUp = false;
      _errorMessage = null;
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  Future<void> _signIn() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    String? storedData = await secureStorage.read(key: 'accounts');
    if (storedData == null) {
      setState(() {
        _errorMessage = 'No accounts found';
      });
      return;
    }

    List<dynamic> decodedData = json.decode(storedData);
    List<Map<String, String>> accounts = decodedData
        .map((account) => Map<String, String>.from(account))
        .toList();

    for (var account in accounts) {
      if (account['username'] == username && account['password'] == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Success'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
        return;
      }
    }

    setState(() {
      _errorMessage = 'Invalid username or password';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF173928),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/LOGO.png', height: 180),
              const SizedBox(height: 20),
              Text(
                'Selamat Datang, Pendaki!',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF2A4D3A),
                ),
              ),
              const SizedBox(height: 16),
              if (_isSignUp)
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF2A4D3A),
                  ),
                ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText:
                    !_isPasswordVisible, // Teks disembunyikan berdasarkan state
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.white70,
                  ),
                  // Menambahkan ikon di akhir field
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Mengubah ikon berdasarkan state
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      // Mengubah state saat ikon di-klik
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2A4D3A),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 10),
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF2A4D3A),
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSignUp ? _signUp : _signIn,
                child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignUp = !_isSignUp;
                    _errorMessage = null;
                    _usernameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                  });
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: _isSignUp
                            ? "Already have an account? "
                            : "Don't have an account? ",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: _isSignUp ? "Sign In" : "Sign Up",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
