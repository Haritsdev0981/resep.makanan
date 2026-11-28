import 'package:flutter/material.dart';

import '../data/data_resep.dart';
import '../models/resep.dart';
import '../utils/konstanta.dart';

/// Halaman form tambah resep masakan baru.
/// Ditugaskan kepada: @aureelnp (ISSUE-06).
///
/// Memenuhi kriteria penilaian DPPB:
/// - CLO C: StatefulWidget buatan sendiri dengan Form & GlobalKey<FormState>.
/// - CLO C: 5 TextEditingController (_namaController, _deskripsiController, _durasiController, _bahanController, _langkahController).
/// - CLO C: DropdownButtonFormField untuk pemilihan kategori masakan.
/// - CLO C: Validasi form ketat dengan pesan kesalahan spesifik dan informatif:
///   * Nama resep wajib diisi & minimal 3 karakter.
///   * Deskripsi resep wajib diisi & minimal 5 karakter.
///   * Durasi wajib berupa angka positif antara 1 - 600 menit.
///   * Bahan minimal 1 butir (dipisahkan baris baru).
///   * Langkah memasak minimal 1 butir (dipisahkan baris baru).
/// - CLO C: Navigator.pop(context, resepBaru) untuk mengembalikan objek Resep baru ke pemanggil (HomeScreen).
/// - CLO C: Layout adaptif & pencegahan overflow dengan SingleChildScrollView dan LayoutBuilder.
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

  String _kategoriTerpilih = 'Tradisional';
  String _tingkatKesulitan = 'Sedang';

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _durasiController.dispose();
    _bahanController.dispose();
    _langkahController.dispose();
    super.dispose();
  }

  void _simpanResep() {
    // Validasi seluruh input form
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Mohon lengkapi seluruh field dengan data yang valid.'),
            backgroundColor: WarnaAplikasi.bahaya,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }

    // Parsing bahan & langkah per baris menjadi List<String>
    final daftarBahan = _bahanController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final daftarLangkah = _langkahController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Fallback aset gambar berdasarkan kategori
    String gambarDefault = 'assets/IMG/sate.png';
    if (_kategoriTerpilih == 'Tradisional') {
      gambarDefault = 'assets/IMG/soto.png';
    } else if (_kategoriTerpilih == 'Minuman') {
      gambarDefault = 'assets/IMG/gudeg.png';
    }

    // Instansiasi objek Resep baru
    final resepBaru = Resep(
      id: 'r_${DateTime.now().millisecondsSinceEpoch}',
      nama: _namaController.text.trim(),
      kategori: _kategoriTerpilih,
      deskripsi: _deskripsiController.text.trim(),
      gambar: gambarDefault,
      durasiMenit: int.tryParse(_durasiController.text.trim()) ?? 30,
      porsi: 4,
      tingkatKesulitan: _tingkatKesulitan,
      bahan: daftarBahan,
      langkah: daftarLangkah,
    );

    // Kembalikan objek Resep baru ke HomeScreen via Navigator.pop
    Navigator.pop(context, resepBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep Baru'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final paddingHorizontal = lebar >= 600 ? 32.0 : 16.0;

            return Center(
              child: ConstrainedBox(
                // Pembatasan lebar maksimal form di layar lebar/tablet agar tetap proporsional
                constraints: const BoxConstraints(maxWidth: 640),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal,
                    vertical: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Pembuka
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: WarnaAplikasi.aksen.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: WarnaAplikasi.aksen.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.tips_and_updates_outlined,
                                color: WarnaAplikasi.primer,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Bagikan resep masakan nusantara andalanmu ke dalam aplikasi!',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: WarnaAplikasi.teksUtama,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Input 1: Nama Resep
                        _labelInput('Nama Resep *'),
                        TextFormField(
                          controller: _namaController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Contoh: Rendang Daging Padang',
                            prefixIcon: Icon(Icons.restaurant, size: 20),
                          ),
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
                        const SizedBox(height: 16),

                        // Dropdown: Kategori Resep
                        _labelInput('Kategori Masakan *'),
                        DropdownButtonFormField<String>(
                          initialValue: _kategoriTerpilih,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.category_outlined, size: 20),
                          ),
                          items: DataResep.kategori
                              .where((k) => k != 'Semua')
                              .map(
                                (kat) => DropdownMenuItem(
                                  value: kat,
                                  child: Text(kat),
                                ),
                              )
                              .toList(),
                          onChanged: (nilai) {
                            if (nilai != null) {
                              setState(() => _kategoriTerpilih = nilai);
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // Input 2: Deskripsi Singkat
                        _labelInput('Deskripsi Singkat *'),
                        TextFormField(
                          controller: _deskripsiController,
                          textInputAction: TextInputAction.next,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: 'Contoh: Masakan daging sapi bercita rasa rempah khas Minang',
                            prefixIcon: Icon(Icons.description_outlined, size: 20),
                          ),
                          validator: (nilai) {
                            if (nilai == null || nilai.trim().isEmpty) {
                              return 'Deskripsi resep wajib diisi';
                            }
                            if (nilai.trim().length < 5) {
                              return 'Deskripsi resep minimal 5 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Row: Durasi dan Tingkat Kesulitan
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Input 3: Durasi Memasak (Numeric)
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _labelInput('Durasi (Menit) *'),
                                  TextFormField(
                                    controller: _durasiController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: 'Misal: 45',
                                      prefixIcon: Icon(Icons.schedule, size: 20),
                                    ),
                                    validator: (nilai) {
                                      if (nilai == null || nilai.trim().isEmpty) {
                                        return 'Durasi wajib diisi';
                                      }
                                      final durasi = int.tryParse(nilai.trim());
                                      if (durasi == null) {
                                        return 'Harus berupa angka';
                                      }
                                      if (durasi < 1 || durasi > 600) {
                                        return 'Antara 1 - 600 menit';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Pilihan Tingkat Kesulitan
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _labelInput('Tingkat Kesulitan'),
                                  DropdownButtonFormField<String>(
                                    initialValue: _tingkatKesulitan,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.speed, size: 20),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Mudah',
                                        child: Text('Mudah'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Sedang',
                                        child: Text('Sedang'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Sulit',
                                        child: Text('Sulit'),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() => _tingkatKesulitan = val);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Input 4: Bahan-bahan (Multi-line)
                        _labelInput('Bahan-bahan (1 bahan per baris) *'),
                        TextFormField(
                          controller: _bahanController,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: '500 gr daging sapi segar\n5 siung bawang putih\n3 lembar daun salam',
                          ),
                          validator: (nilai) {
                            if (nilai == null || nilai.trim().isEmpty) {
                              return 'Bahan-bahan wajib diisi';
                            }
                            final list = nilai
                                .split('\n')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty);
                            if (list.isEmpty) {
                              return 'Minimal cantumkan 1 bahan';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Input 5: Langkah Memasak (Multi-line)
                        _labelInput('Cara Membuat (1 langkah per baris) *'),
                        TextFormField(
                          controller: _langkahController,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Tumis bumbu halus hingga harum\nMasukkan daging dan santan kental\nMasak hingga kuah mengental',
                          ),
                          validator: (nilai) {
                            if (nilai == null || nilai.trim().isEmpty) {
                              return 'Langkah memasak wajib diisi';
                            }
                            final list = nilai
                                .split('\n')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty);
                            if (list.isEmpty) {
                              return 'Minimal cantumkan 1 langkah pembuatan';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 28),

                        // Tombol Aksi Simpan & Batal
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _simpanResep,
                            icon: const Icon(Icons.save_outlined),
                            label: const Text('Simpan Resep Masakan'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: WarnaAplikasi.batas),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: WarnaAplikasi.teksSekunder),
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
