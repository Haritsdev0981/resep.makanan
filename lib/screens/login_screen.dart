import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk LoginScreen.
/// Ditugaskan kepada: @aureelnp (ISSUE-03).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk Aplikasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 64,
                color: WarnaAplikasi.primer,
              ),
              const SizedBox(height: 16),
              const Text(
                'Layar Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Task Aurel: Form Login dengan Validasi & Show/Hide Password',
                textAlign: TextAlign.center,
                style: TextStyle(color: WarnaAplikasi.teksSekunder),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Rute.home,
                    arguments: AkunDemo.username,
                  );
                },
                child: const Text('Masuk sebagai Tamu / Demo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
