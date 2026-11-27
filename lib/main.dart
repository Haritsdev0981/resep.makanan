import 'package:flutter/material.dart';

import 'screens/detail_screen.dart';
import 'screens/form_screen.dart';
import 'screens/home_screen.dart';
import 'screens/kategori_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/konstanta.dart';

void main() {
  runApp(const AplikasiResep());
}

/// Akar aplikasi. Mendaftarkan seluruh named routes proyek.
/// Memenuhi kriteria DPPB CLO C (Named Routes & Navigasi).
class AplikasiResep extends StatelessWidget {
  const AplikasiResep({super.key, this.ruteAwal = Rute.splash});

  /// Rute awal yang dipanggil saat aplikasi dibuka pertama kali.
  final String ruteAwal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Masakan',
      debugShowCheckedModeBanner: false,
      theme: temaAplikasi(),
      initialRoute: ruteAwal,
      routes: {
        Rute.splash: (_) => const SplashScreen(),
        Rute.login: (_) => const LoginScreen(),
        Rute.home: (context) {
          final argumen = ModalRoute.of(context)?.settings.arguments;
          final username = argumen is String ? argumen : AkunDemo.username;
          return HomeScreen(username: username);
        },
        Rute.form: (_) => const FormScreen(),
        Rute.detail: (context) {
          final argumen = ModalRoute.of(context)?.settings.arguments;
          return DetailScreen(data: argumen);
        },
        Rute.kategori: (context) {
          final argumen = ModalRoute.of(context)?.settings.arguments;
          return KategoriScreen(data: argumen);
        },
      },
    );
  }
}
