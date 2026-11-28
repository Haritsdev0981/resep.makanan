import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Layar masuk (Login Screen).
/// Ditugaskan kepada: @aureelnp (ISSUE-03).
///
/// Memenuhi kriteria DPPB:
/// - CLO C: StatefulWidget buatan sendiri dengan Form & GlobalKey<FormState>.
/// - CLO C: Dua TextEditingController (_usernameController & _passwordController).
/// - CLO C: State boolean _sandiTersembunyi dan aksi toggle show/hide password dengan setState.
/// - CLO C: Validasi input form (pesan kesalahan informatif untuk username & password).
/// - CLO C: SnackBar pemberitahuan saat kredensial tidak cocok dengan AkunDemo.
/// - CLO C: Navigasi pushReplacementNamed ke HomeScreen dengan passing arguments nama pengguna.
/// - CLO C: Layout adaptif menggunakan LayoutBuilder (pembatasan lebar kartu form maks 420px di layar lebar).
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
    // Jalankan validasi seluruh FormField
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Evaluasi ekspresi logika perbandingan kredensial akun
    final cocok = username == AkunDemo.username && password == AkunDemo.password;

    if (!cocok) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Username atau password salah. Silakan coba lagi.'),
            backgroundColor: WarnaAplikasi.bahaya,
            duration: Duration(seconds: 3),
          ),
        );
      return;
    }

    // Navigasi satu arah ke HomeScreen dengan passing argument nama pengguna
    Navigator.pushReplacementNamed(
      context,
      Rute.home,
      arguments: username,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.primer,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            // Adaptive layout: jika lebar layar >= 600px (tablet/desktop), batasi lebar form maks 420px
            final lebarKartu = lebar >= 600 ? 420.0 : lebar - 32;

            return SingleChildScrollView(
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
                        // Header logo login
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.restaurant_menu,
                            size: 44,
                            color: WarnaAplikasi.primer,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Resep Masakan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Masuk untuk menjelajahi dan mengelola resep',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 24),

                        // Kartu Form Login
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelInput('Username'),
                                TextFormField(
                                  controller: _usernameController,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan username',
                                    prefixIcon: const Icon(
                                      Icons.person_outline,
                                      color: WarnaAplikasi.teksSekunder,
                                      size: 20,
                                    ),
                                    fillColor: Colors.grey.shade50,
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
                                const SizedBox(height: 16),
                                _labelInput('Password'),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _sandiTersembunyi,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _masuk(),
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan password',
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: WarnaAplikasi.teksSekunder,
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      tooltip: _sandiTersembunyi
                                          ? 'Tampilkan password'
                                          : 'Sembunyikan password',
                                      icon: Icon(
                                        _sandiTersembunyi
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 20,
                                        color: WarnaAplikasi.teksSekunder,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _sandiTersembunyi = !_sandiTersembunyi;
                                        });
                                      },
                                    ),
                                    fillColor: Colors.grey.shade50,
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
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _masuk,
                                    child: const Text('Masuk'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Informasi akun demo (membantu saat presentasi / live demo)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Akun Demo: ares / ares123',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
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

  Widget _labelInput(String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        teks,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: WarnaAplikasi.teksUtama,
        ),
      ),
    );
  }
}
