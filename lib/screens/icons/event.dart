import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/event_background.png', height: 250, width: 250),
            const SizedBox(height: 20),
            const Text(
              'Event Tidak Tersedia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A4D3A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Event yang anda nantikan belum tersedia,\nsilahkan kembali di lain waktu',
              style: TextStyle(fontSize: 16, color: Color(0xFF2A4D3A)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
