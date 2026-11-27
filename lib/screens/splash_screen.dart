import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk SplashScreen.
/// Ditugaskan kepada: @aureelnp (ISSUE-03).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.primer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.restaurant_menu,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text(
              'Resep Masakan Nusantara',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Memuat aplikasi...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: WarnaAplikasi.primer,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Rute.login);
              },
              child: const Text('Lanjut ke Login'),
            ),
          ],
        ),
      ),
    );
  }
}
