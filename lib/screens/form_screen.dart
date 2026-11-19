import 'package:flutter/material.dart';

import '../data/data_resep.dart';
import '../models/resep.dart';
import '../utils/konstanta.dart';
import '../widgets/tombol_utama.dart';

/// Form tambah resep. Hasilnya dikembalikan ke Home lewat
/// `Navigator.pop(context, resep)`.
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _durasiController = TextEditingController();
  final TextEditingController _bahanController = TextEditingController();
  final TextEditingController _langkahController = TextEditingController();

  String _kategori = 'Tradisional';

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _durasiController.dispose();
    _bahanController.dispose();
    _langkahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Periksa kembali isian yang masih kosong.'),
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }

    // Memecah teks per baris menjadi List<String>.
    final bahan = _bahanController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final langkah = _langkahController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final resepBaru = Resep(
      id: 'r${DateTime.now().millisecondsSinceEpoch}',
      nama: _namaController.text.trim(),
      kategori: _kategori,
      deskripsi: _deskripsiController.text.trim(),
      gambar: 'assets/IMG/sate.png',
      durasiMenit: int.tryParse(_durasiController.text.trim()) ?? 30,
      porsi: 2,
      bahan: bahan,
      langkah: langkah,
    );

    // pushReplacementNamed: form diganti layar detail supaya pengguna tidak
    // bisa kembali ke form yang sudah dikirim. `result` tetap mengirim objek
    // baru ke Home, jadi Home bisa langsung menampilkannya.
    Navigator.pushReplacementNamed(
      context,
      Rute.detail,
      arguments: resepBaru,
      result: resepBaru,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Resep',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final lebar = constraints.maxWidth;
              final padding = lebar >= 600 ? 24.0 : 16.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(padding, 8, padding, 32),
                child: ConstrainedBox(
                  // Di layar lebar, isi form dibatasi agar tetap nyaman dibaca.
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Nama resep'),
                      TextFormField(
                        controller: _namaController,
                        textInputAction: TextInputAction.next,
                        decoration: _dekorasi('Contoh: Nasi Goreng Kampung'),
                        validator: (nilai) {
                          if (nilai == null || nilai.trim().isEmpty) {
                            return 'Nama resep wajib diisi';
                          }
                          if (nilai.trim().length < 3) {
                            return 'Nama resep minimal 3 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _label('Kategori'),
                      DropdownButtonFormField<String>(
                        initialValue: _kategori,
                        decoration: _dekorasi('Pilih kategori'),
                        items: DataResep.kategori
                            .where((k) => k != 'Semua')
                            .map(
                              (k) => DropdownMenuItem<String>(
                                value: k,
                                child: Text(k),
                              ),
                            )
                            .toList(),
                        onChanged: (nilai) {
                          if (nilai != null) {
                            setState(() => _kategori = nilai);
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      _label('Deskripsi singkat'),
                      TextFormField(
                        controller: _deskripsiController,
                        textInputAction: TextInputAction.next,
                        decoration: _dekorasi('Contoh: Nasi, telur, kecap'),
                        validator: (nilai) {
                          if (nilai == null || nilai.trim().isEmpty) {
                            return 'Deskripsi wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _label('Durasi memasak (menit)'),
                      TextFormField(
                        controller: _durasiController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: _dekorasi('Contoh: 30'),
                        validator: (nilai) {
                          if (nilai == null || nilai.trim().isEmpty) {
                            return 'Durasi wajib diisi';
                          }
                          final angka = int.tryParse(nilai.trim());
                          if (angka == null) {
                            return 'Isi dengan angka, misalnya 30';
                          }
                          if (angka <= 0 || angka > 600) {
                            return 'Durasi harus antara 1 dan 600 menit';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _label('Bahan (satu bahan per baris)'),
                      TextFormField(
                        controller: _bahanController,
                        maxLines: 5,
                        decoration: _dekorasi(
                          '500 gram daging\n3 siung bawang putih',
                        ),
                        validator: (nilai) {
                          if (nilai == null || nilai.trim().isEmpty) {
                            return 'Minimal satu bahan';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _label('Cara membuat (satu langkah per baris)'),
                      TextFormField(
                        controller: _langkahController,
                        maxLines: 5,
                        decoration: _dekorasi(
                          'Tumis bawang hingga harum\nMasukkan nasi, aduk rata',
                        ),
                        validator: (nilai) {
                          if (nilai == null || nilai.trim().isEmpty) {
                            return 'Minimal satu langkah';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      TombolUtama(
                        label: 'Simpan resep',
                        ikon: Icons.save_outlined,
                        onPressed: _simpan,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Batal',
                            style: TextStyle(color: Warna.teksSamar),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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

  InputDecoration _dekorasi(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
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
