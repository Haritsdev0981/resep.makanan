import 'package:flutter/material.dart';

import 'models/resep.dart';
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

/// Akar aplikasi. Semua perpindahan layar memakai named route
/// yang didaftarkan di sini.
class AplikasiResep extends StatelessWidget {
  const AplikasiResep({super.key, this.ruteAwal = Rute.splash});

  /// Route pertama yang dibuka. Dipakai juga oleh widget test agar bisa
  /// langsung mulai dari Home tanpa melewati splash.
  final String ruteAwal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: temaAplikasi(),
      initialRoute: ruteAwal,
      routes: {
        Rute.splash: (_) => const SplashScreen(),
        Rute.login: (_) => const LoginScreen(),
        Rute.home: (context) {
          // Menerima username dari Login lewat arguments (boleh kosong bila
          // Home dibuka langsung, misalnya pada widget test).
          final argumen = ModalRoute.of(context)!.settings.arguments;
          final username = argumen is String ? argumen : AkunDemo.username;
          return HomeScreen(username: username);
        },
        Rute.form: (_) => const FormScreen(),
        Rute.detail: (context) {
          // Menerima data Resep yang dikirim lewat arguments.
          final resep = ModalRoute.of(context)!.settings.arguments as Resep;
          return DetailScreen(resep: resep);
        },
        Rute.kategori: (context) {
          // Menerima Map (struktur non-linear) lewat arguments.
          final data = ModalRoute.of(context)!.settings.arguments
              as Map<String, List<Resep>>;
          return KategoriScreen(data: data);
        },
      },
    );
  }
}
