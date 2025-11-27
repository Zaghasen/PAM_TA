import 'package:flutter/material.dart';

class RentalPage extends StatelessWidget {
  const RentalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sewa Alat')),
      body: const Center(child: Text('Halaman Sewa Alat')),
    );
  }
}
