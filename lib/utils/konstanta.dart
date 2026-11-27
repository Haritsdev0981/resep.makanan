import 'package:flutter/material.dart';

/// Daftar rute named routes yang digunakan di seluruh aplikasi.
/// Kriteria Penilaian DPPB CLO C (Named Routes).
class Rute {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String form = '/form';
  static const String kategori = '/kategori';
}

/// Palet warna tema aplikasi masakan nusantara.
class WarnaAplikasi {
  static const Color primer = Color(0xFFD35400); // Oranye rempah nusantara
  static const Color aksen = Color(0xFFF39C12); // Amber hangat
  static const Color latar = Color(0xFFFBF8F5); // Krem terang bersih
  static const Color kartu = Colors.white;
  static const Color teksUtama = Color(0xFF2C3E50);
  static const Color teksSekunder = Color(0xFF7F8C8D);
  static const Color batas = Color(0xFFE2E8F0);
  static const Color sukses = Color(0xFF27AE60);
  static const Color bahaya = Color(0xFFE74C3C);
}

/// Kredensial akun demo untuk pengujian validasi login.
class AkunDemo {
  static const String username = 'ares';
  static const String password = 'ares123';
}

/// Tema global aplikasi berbasis Material 3 dengan palet warna terstandar.
ThemeData temaAplikasi() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: WarnaAplikasi.primer,
      primary: WarnaAplikasi.primer,
      secondary: WarnaAplikasi.aksen,
      surface: WarnaAplikasi.latar,
    ),
    scaffoldBackgroundColor: WarnaAplikasi.latar,
    appBarTheme: const AppBarTheme(
      backgroundColor: WarnaAplikasi.primer,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: WarnaAplikasi.kartu,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: WarnaAplikasi.primer,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: WarnaAplikasi.batas),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: WarnaAplikasi.batas),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: WarnaAplikasi.primer, width: 2),
      ),
    ),
  );
}
