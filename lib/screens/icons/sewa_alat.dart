import 'package:flutter/material.dart';

class SewaAlatPage extends StatelessWidget {
  const SewaAlatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sewa Alat')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/comingsoon1.png')),
            SizedBox(height: 20),
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
