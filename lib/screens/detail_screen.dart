import 'package:flutter/material.dart';

import '../utils/konstanta.dart';

/// Skeleton Screen untuk DetailScreen.
/// Ditugaskan kepada: @alfarezi170107 (ISSUE-07).
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Resep'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                size: 64,
                color: WarnaAplikasi.primer,
              ),
              SizedBox(height: 16),
              Text(
                'Detail Resep Masakan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Task Ares: Bahan, Langkah, Hapus Resep (AlertDialog) & SnackBar Undo',
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
