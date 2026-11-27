import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk KategoriScreen.
/// Ditugaskan kepada: @alfarezi170107 (ISSUE-08).
class KategoriScreen extends StatelessWidget {
  const KategoriScreen({super.key, this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Masakan'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view,
                size: 64,
                color: WarnaAplikasi.primer,
              ),
              SizedBox(height: 16),
              Text(
                'Kategori Screen (Non-Linear Map)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Task Ares: GridView Adaptif (LayoutBuilder 1/2/3 kolom) & BottomSheet Filter',
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
