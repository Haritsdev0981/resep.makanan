import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk FormScreen.
/// Ditugaskan kepada: @aureelnp (ISSUE-06).
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.post_add,
                size: 64,
                color: WarnaAplikasi.primer,
              ),
              SizedBox(height: 16),
              Text(
                'Form Tambah Resep',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Task Aurel: Input Resep Baru dengan 5 Controller & Validasi',
                textAlign: TextAlign.center,
                style: TextStyle(color: WarnaAplikasi.teksSekunder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
