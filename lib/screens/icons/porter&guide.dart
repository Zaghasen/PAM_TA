import 'package:flutter/material.dart';

class PorterGuidePage extends StatelessWidget {
  const PorterGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Porter & Guide')),
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
