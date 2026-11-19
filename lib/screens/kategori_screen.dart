import 'package:flutter/material.dart';

import '../models/resep.dart';
import '../utils/konstanta.dart';
import '../widgets/kartu_resep.dart';

/// Layar kategori. Menerima `Map<String, List<Resep>>` lewat arguments,
/// jadi ini contoh pemakaian struktur data non-linear (Map berisi List).
///
/// Saat kembali, layar ini mengirim `List<Resep>` hasil gabungan ke Home
/// lewat `Navigator.pop`, supaya perubahan (misalnya hapus) tetap konsisten.
class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key, required this.data});

  final Map<String, List<Resep>> data;

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  late Map<String, List<Resep>> _data;

  @override
  void initState() {
    super.initState();
    // Salinan Map agar perubahan di layar ini tidak mengubah data pemanggil
    // secara langsung; hasil akhirnya dikirim saat layar ditutup.
    _data = {
      for (final entri in widget.data.entries)
        entri.key: List<Resep>.from(entri.value),
    };
  }

  /// Menggabungkan kembali Map menjadi List untuk dikirim ke Home.
  List<Resep> get _datar {
    return [for (final daftar in _data.values) ...daftar];
  }

  void _kembali() => Navigator.pop(context, _datar);

  Future<void> _bukaDetail(Resep resep) async {
    final hasil = await Navigator.pushNamed(
      context,
      Rute.detail,
      arguments: resep,
    );

    if (hasil == true && mounted) {
      setState(() {
        // Menghapus dari List di dalam Map, lalu membuang kategori kosong.
        for (final daftar in _data.values) {
          daftar.remove(resep);
        }
        _data.removeWhere((_, daftar) => daftar.isEmpty);
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${resep.nama} dihapus'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'BATAL',
              textColor: Warna.amber,
              onPressed: () {
                setState(() {
                  _data
                      .putIfAbsent(
                        resep.kategori,
                        () => <Resep>[],
                      )
                      .add(resep);
                });
              },
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map diubah menjadi daftar entri agar bisa dipakai ListView.builder.
    final entri = _data.entries.toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _kembali();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _kembali,
          ),
          title: const Text(
            'Resep per Kategori',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final kolom = lebar >= 900 ? 3 : (lebar >= 600 ? 2 : 1);
            final padding = lebar >= 600 ? 24.0 : 16.0;

            if (entri.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada resep.',
                  style: TextStyle(color: Warna.teksSamar),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(padding, 12, padding, 24),
              itemCount: entri.length,
              itemBuilder: (context, index) {
                final kategori = entri[index].key;
                final daftar = entri[index].value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              kategori,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Warna.krem,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${daftar.length} resep',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Warna.merah,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: kolom,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: kolom > 1 ? 238 : 242,
                        ),
                        itemCount: daftar.length,
                        itemBuilder: (context, i) {
                          final resep = daftar[i];
                          return KartuResep(
                            resep: resep,
                            ringkas: kolom > 1,
                            onTap: () => _bukaDetail(resep),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
