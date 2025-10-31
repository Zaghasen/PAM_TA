import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tapak_jejak/screens/login_screen.dart';
import 'package:tapak_jejak/services/hive_service.dart';

// -- ENTRY POINT APLIKASI --
// Fungsi main() adalah yang pertama kali dijalankan saat aplikasi dibuka.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final hiveService = HiveService();
  await hiveService.initHive();

  runApp(const MyApp());
}

// MyApp adalah widget utama yang membungkus seluruh aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi yang menggunakan Material Design.
    return MaterialApp(
      // Judul aplikasi yang muncul di task manager.
      title: 'Aplikasi Pendakian - TAPAK JEJAK',

      // Pengaturan tema global untuk seluruh aplikasi.
      theme: ThemeData(
        primaryColor: const Color(0xFF2A4D3A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2A4D3A),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
      ),

      // Menghilangkan banner "Debug" di pojok kanan atas.
      debugShowCheckedModeBanner: false,

      // Menentukan halaman pertama yang akan ditampilkan saat aplikasi dibuka.
      home: const LoginScreen(),
    );
  }
}
