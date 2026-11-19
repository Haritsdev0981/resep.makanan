import 'package:flutter/material.dart';

import '../utils/konstanta.dart';
import '../widgets/tombol_utama.dart';

/// Halaman login.
///
/// Akun dummy: username `ares`, password `ares123` (lihat [AkunDemo]).
/// Setelah berhasil, layar ini diganti dengan Home memakai
/// `pushReplacementNamed` supaya pengguna tidak bisa kembali ke login
/// lewat tombol back.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _sandiTersembunyi = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _masuk() {
    // Validasi input: pesan kesalahan jelas jika field kosong.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Operator perbandingan + logika: keduanya harus cocok.
    final cocok =
        username == AkunDemo.username && password == AkunDemo.password;

    if (!cocok) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Username atau password salah. Coba lagi.'),
            duration: Duration(seconds: 3),
          ),
        );
      return;
    }

    // Alur yang tidak boleh kembali: login diganti Home.
    Navigator.pushReplacementNamed(
      context,
      Rute.home,
      arguments: username,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.merah,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final lebarKartu = lebar >= 600 ? 420.0 : lebar - 32;

            return SingleChildScrollView(
              // ScrollView menjaga layar tetap aman saat keyboard muncul
              // atau di layar landscape yang pendek.
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Center(
                  child: SizedBox(
                    width: lebarKartu,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo di atas kartu, tetap memakai gaya splash.
                        Container(
                          width: 84,
                          height: 84,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.restaurant_menu,
                            size: 42,
                            color: Warna.merah,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Resep Makanan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Masuk untuk melihat resep',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 20),

                        // Kartu putih berisi form.
                        Container(
                          padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Username'),
                                TextFormField(
                                  controller: _usernameController,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: _dekorasi(
                                    hint: 'Masukkan username',
                                    ikon: Icons.person_outline,
                                  ),
                                  validator: (nilai) {
                                    if (nilai == null || nilai.trim().isEmpty) {
                                      return 'Username wajib diisi';
                                    }
                                    if (nilai.trim().length < 3) {
                                      return 'Username minimal 3 karakter';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                _label('Password'),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _sandiTersembunyi,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _masuk(),
                                  decoration: _dekorasi(
                                    hint: 'Masukkan password',
                                    ikon: Icons.lock_outline,
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      tooltip: _sandiTersembunyi
                                          ? 'Tampilkan password'
                                          : 'Sembunyikan password',
                                      icon: Icon(
                                        _sandiTersembunyi
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 20,
                                      ),
                                      onPressed: () => setState(
                                        () => _sandiTersembunyi =
                                            !_sandiTersembunyi,
                                      ),
                                    ),
                                  ),
                                  validator: (nilai) {
                                    if (nilai == null || nilai.isEmpty) {
                                      return 'Password wajib diisi';
                                    }
                                    if (nilai.length < 6) {
                                      return 'Password minimal 6 karakter';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TombolUtama(
                                  label: 'Masuk',
                                  ikon: Icons.login,
                                  onPressed: _masuk,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Petunjuk akun demo, berguna saat presentasi.
                        const Text(
                          'Akun demo: ${AkunDemo.username} / '
                          '${AkunDemo.password}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _label(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        teks,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  InputDecoration _dekorasi({required String hint, required IconData ikon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
      prefixIcon: Icon(ikon, size: 20, color: Warna.teksSamar),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Warna.merah),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Warna.merah),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Warna.merah, width: 1.6),
      ),
    );
  }
}
