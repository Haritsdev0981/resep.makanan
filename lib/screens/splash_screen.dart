import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Layar pembuka (Splash Screen).
/// Ditugaskan kepada: @aureelnp (ISSUE-03).
///
/// Memenuhi kriteria DPPB:
/// - CLO C: StatefulWidget dengan pengelolaan lifecycle Timer (initState & dispose).
/// - CLO C: Navigasi pushReplacementNamed satu arah (tidak bisa kembali ke splash).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Menggunakan Timer 2 detik sebelum berpindah otomatis ke LoginScreen
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Rute.login);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.primer,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ikon makanan dengan kontainer lingkaran elegan
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 52,
                  color: WarnaAplikasi.primer,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Resep Masakan Nusantara',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Inspirasi Masakan Nusantara Sehari-hari',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 36),
              // Indikator loading halus
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
