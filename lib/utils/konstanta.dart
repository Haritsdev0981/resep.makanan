import 'package:flutter/material.dart';

/// Palet warna aplikasi. Semua layar memakai konstanta ini agar seragam.
class Warna {
  const Warna._();

  static const Color merah = Color(0xFFF54749);
  static const Color krem = Color(0xFFFEEBC9);
  static const Color amber = Color(0xFFFFCB6A);
  static const Color latar = Color(0xFFFAFAFA);
  static const Color teks = Color(0xFF2B2B2B);
  static const Color teksSamar = Color(0xFF7A7A7A);
}

/// Nama route terpusat, dipakai di MaterialApp dan saat navigasi.
class Rute {
  const Rute._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String form = '/form';
  static const String kategori = '/kategori';
}

/// Akun dummy untuk halaman login. Disimpan sebagai konstanta supaya
/// mudah ditunjukkan saat presentasi/demo.
class AkunDemo {
  const AkunDemo._();

  static const String username = 'ares';
  static const String password = 'ares123';

  /// Nama yang ditampilkan pada sapaan di Home.
  static String get namaTampilan => username;
}

/// Tema aplikasi: warna dan tipografi disamakan dengan tampilan awal.
ThemeData temaAplikasi() {
  final dasar = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Warna.merah,
      primary: Warna.merah,
    ),
    scaffoldBackgroundColor: Warna.latar,
    fontFamily: 'Roboto',
  );

  return dasar.copyWith(
    textTheme: dasar.textTheme.apply(
      bodyColor: Warna.teks,
      displayColor: Warna.teks,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Warna.latar,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Warna.teks,
      centerTitle: false,
    ),
    chipTheme: dasar.chipTheme.copyWith(
      selectedColor: Warna.merah,
      backgroundColor: Colors.white,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      side: const BorderSide(color: Color(0xFFE6E6E6)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );
}
