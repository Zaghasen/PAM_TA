import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tapak_jejak/screens/login/login_page.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat/rental_page.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat/produk_page.dart';
import 'package:tapak_jejak/screens/icons/blog/review_page.dart';
import 'package:tapak_jejak/screens/icons/trip/trip_page.dart';
import 'package:tapak_jejak/services/hive_service.dart';
import 'package:tapak_jejak/models/user.dart';

// -- ENTRY POINT APLIKASI --
// Fungsi main() adalah yang pertama kali dijalankan saat aplikasi dibuka.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive Adapter for User model
  Hive.registerAdapter(UserAdapter());

  final hiveService = HiveService();
  await hiveService.initHive();

  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'alerts',
      channelName: 'Alerts',
      channelDescription: 'Notifikasi untuk pendakian dan langganan',
      defaultColor: Colors.redAccent,
      ledColor: Colors.blueAccent,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ], debug: true);

  // Request notification permission
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(const MyApp());
}

// MyApp adalah widget utama yang membungkus seluruh aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi yang menggunakan Material Design.
    return MaterialApp(
      title: 'Tapak Jejak',
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
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/rental': (context) => const RentalPage(),
        '/produk': (context) => const ProdukPage(),
        '/review': (context) => const ReviewPage(),
        '/trip': (context) => const TripPage(),
      },
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
