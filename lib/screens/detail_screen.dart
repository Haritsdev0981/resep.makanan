import 'package:flutter/material.dart';

import '../data/data_resep.dart';
import '../models/resep.dart';
import '../utils/konstanta.dart';
import '../widgets/tombol_utama.dart';

/// Layar detail resep. Menerima satu objek [Resep] lewat arguments.
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.resep});

  final Resep resep;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _sudahDibuka = false;

  Resep get resep => widget.resep;

  void _ubahFavorit() {
    setState(() => resep.favorit = !resep.favorit);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            resep.favorit
                ? '${resep.nama} ada di favorit'
                : '${resep.nama} dihapus dari favorit',
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'BATAL',
            textColor: Warna.amber,
            onPressed: () => setState(() => resep.favorit = !resep.favorit),
          ),
        ),
      );
  }

  /// AlertDialog: konfirmasi aksi penting (menghapus resep dari daftar).
  Future<void> _konfirmasiHapus() async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus resep?'),
          content: Text(
            '${resep.nama} akan dihapus dari daftar resep. '
            'Tindakan ini tidak bisa dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('BATAL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'HAPUS',
                style: TextStyle(color: Warna.merah),
              ),
            ),
          ],
        );
      },
    );

    if (setuju == true && mounted) {
      // Hapus dari daftar bersama, lalu kembali membawa penanda `true`.
      // Dengan begitu penghapusan tetap benar dari layar mana pun Detail dibuka
      // (dari Home maupun dari Kategori/form).
      DataResep.daftar.remove(resep);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Warna.latar,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                tooltip: 'Favorit',
                onPressed: _ubahFavorit,
                icon: Icon(
                  resep.favorit ? Icons.favorite : Icons.favorite_border,
                  color: Warna.merah,
                ),
              ),
              IconButton(
                tooltip: 'Hapus resep',
                onPressed: _konfirmasiHapus,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                resep.gambar,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Warna.krem,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: Warna.merah,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final lebar = constraints.maxWidth;
                final padding = lebar >= 600 ? 24.0 : 16.0;

                return Padding(
                  padding: EdgeInsets.fromLTRB(padding, 16, padding, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resep.nama,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        resep.deskripsi,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Warna.teksSamar,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _infoSingkat(),
                      const SizedBox(height: 20),

                      const JudulBagian(
                        teks: 'Bahan-bahan',
                        ikon: Icons.shopping_basket_outlined,
                      ),
                      // ListView.builder di dalam Column perlu shrinkWrap.
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resep.bahan.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Warna.merah,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    resep.bahan[index],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      const JudulBagian(
                        teks: 'Cara membuat',
                        ikon: Icons.soup_kitchen_outlined,
                      ),
                      ...List.generate(resep.langkah.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Warna.krem,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Warna.merah,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  resep.langkah[index],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 12),
                      TombolUtama(
                        label: _sudahDibuka
                            ? 'Sudah selesai dimasak'
                            : 'Tandai sedang dimasak',
                        ikon: _sudahDibuka
                            ? Icons.check_circle_outline
                            : Icons.local_fire_department_outlined,
                        onPressed: () {
                          setState(() => _sudahDibuka = !_sudahDibuka);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  _sudahDibuka
                                      ? 'Selamat memasak!'
                                      : 'Tanda dimasak dibatalkan',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSingkat() {
    // Row dengan Expanded di tiap item supaya tidak overflow.
    return Row(
      children: [
        Expanded(
          child: _kotakInfo(
            Icons.schedule,
            '${resep.durasiMenit} menit',
            'Durasi',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
              _kotakInfo(Icons.people_outline, '${resep.porsi} porsi', 'Porsi'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _kotakInfo(
            Icons.format_list_numbered,
            '${resep.jumlahLangkah} langkah',
            'Langkah',
          ),
        ),
      ],
    );
  }

  Widget _kotakInfo(IconData ikon, String nilai, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, size: 18, color: Warna.merah),
          const SizedBox(height: 6),
          Text(
            nilai,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Warna.teksSamar),
          ),
        ],
      ),
    );
  }
}
