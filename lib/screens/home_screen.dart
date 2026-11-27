import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk HomeScreen.
/// Ditugaskan kepada: @Haritsdev0981 (ISSUE-05).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, $username!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category_outlined),
            onPressed: () {
              Navigator.pushNamed(context, Rute.kategori);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dinner_dining,
                size: 64,
                color: WarnaAplikasi.primer,
              ),
              const SizedBox(height: 16),
              const Text(
                'Home Screen (Daftar Resep Masakan)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Task Harits: Banner, Search, Filter Kategori, & Passing Data',
                textAlign: TextAlign.center,
                style: TextStyle(color: WarnaAplikasi.teksSekunder),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Tambah Resep Baru'),
                onPressed: () {
                  Navigator.pushNamed(context, Rute.form);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
