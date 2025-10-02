import 'package:flutter/material.dart';
import 'package:tugas_akhir_097/screens/login_screen.dart';

// -- ENTRY POINT APLIKASI --
// Fungsi main() adalah yang pertama kali dijalankan saat aplikasi dibuka.
void main() {
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
      title: 'Penyewaan Alat Pendakian',

      // Pengaturan tema global untuk seluruh aplikasi.
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
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
