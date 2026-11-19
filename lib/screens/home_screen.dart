import 'package:flutter/material.dart';

import '../data/data_resep.dart';
import '../models/resep.dart';
import '../utils/konstanta.dart';
import '../widgets/kartu_resep.dart';
import '../widgets/tombol_utama.dart';

/// Layar utama. Tampilan awal dipertahankan: sapaan, kolom pencarian,
/// banner, lalu daftar resep.
///
/// Daftar resep ditampilkan **horizontal** (scroll ke kanan), sedangkan
/// halaman "Lihat Lainnya" (KategoriScreen) tetap **vertikal**.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.username = AkunDemo.username});

  /// Username dari halaman login, dipakai untuk sapaan.
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Struktur linear: seluruh resep.
  /// Memakai satu List bersama dari DataResep supaya perubahan dari layar
  /// lain (form, detail, kategori) langsung terlihat di sini.
  final List<Resep> _semuaResep = DataResep.daftar;

  final TextEditingController _cariController = TextEditingController();

  String _kataKunci = '';
  String _kategoriAktif = 'Semua';

  @override
  void dispose() {
    _cariController.dispose();
    super.dispose();
  }

  /// Menyaring resep berdasarkan kata kunci dan kategori aktif.
  List<Resep> get _hasilFilter {
    return _semuaResep.where((resep) {
      final cocokKategori =
          _kategoriAktif == 'Semua' || resep.kategori == _kategoriAktif;
      final cocokKataKunci = _kataKunci.isEmpty ||
          resep.nama.toLowerCase().contains(_kataKunci.toLowerCase()) ||
          resep.deskripsi.toLowerCase().contains(_kataKunci.toLowerCase());
      return cocokKategori && cocokKataKunci;
    }).toList();
  }

  int get _jumlahFavorit => _semuaResep.where((r) => r.favorit).length;

  /// Membuka form dan menerima objek Resep baru lewat hasil Navigator.pop.
  Future<void> _tambahResep() async {
    final hasil = await Navigator.pushNamed(context, Rute.form);

    if (hasil is Resep) {
      setState(() {
        _semuaResep.insert(0, hasil);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${hasil.nama} berhasil ditambahkan'),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  void _ubahFavorit(Resep resep) {
    setState(() {
      resep.favorit = !resep.favorit;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            resep.favorit
                ? '${resep.nama} ditambahkan ke favorit'
                : '${resep.nama} dihapus dari favorit',
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'BATAL',
            textColor: Warna.amber,
            onPressed: () {
              setState(() {
                resep.favorit = !resep.favorit;
              });
            },
          ),
        ),
      );
  }

  /// Membuka detail. Jika detail mengembalikan `true`, resep dihapus dari list
  /// dan SnackBar dengan aksi BATAL ditampilkan untuk mengembalikannya.
  Future<void> _bukaDetail(Resep resep, int posisi) async {
    final hasil = await Navigator.pushNamed(
      context,
      Rute.detail,
      arguments: resep,
    );

    if (hasil == true && mounted) {
      setState(() => _semuaResep.remove(resep));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${resep.nama} dihapus'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'BATAL',
              textColor: Warna.amber,
              onPressed: () {
                setState(() {
                  // Dikembalikan ke posisi semula.
                  final target =
                      posisi > _semuaResep.length ? _semuaResep.length : posisi;
                  _semuaResep.insert(target, resep);
                });
              },
            ),
          ),
        );
    }
  }

  /// Membuka layar kategori dengan mengirim Map, lalu menerima kembali List
  /// hasil perubahan (misalnya resep yang dihapus dari layar kategori).
  Future<void> _bukaKategori() async {
    final hasil = await Navigator.pushNamed(
      context,
      Rute.kategori,
      arguments: DataResep.perKategori(_semuaResep),
    );

    if (hasil is List<Resep> && mounted) {
      setState(() {
        _semuaResep
          ..clear()
          ..addAll(hasil);
      });
    }
  }

  Future<void> _bukaFilter() async {
    // BottomSheet untuk memilih kategori.
    final pilihan = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: DataResep.kategori.map((kategori) {
              return ListTile(
                title: Text(kategori),
                trailing: _kategoriAktif == kategori
                    ? const Icon(Icons.check, color: Warna.merah)
                    : null,
                onTap: () => Navigator.pop(context, kategori),
              );
            }).toList(),
          ),
        );
      },
    );

    if (pilihan != null) {
      setState(() => _kategoriAktif = pilihan);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasil = _hasilFilter;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Halo,',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 2),
            Text(
              // Interpolasi string: nama pengguna dari halaman login.
              '${widget.username} 👋',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // Jumlah favorit tampil di AppBar.
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, color: Warna.merah, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$_jumlahFavorit',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: _bukaFilter,
            tooltip: 'Filter kategori',
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahResep,
        backgroundColor: Warna.merah,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Resep'),
      ),
      // LayoutBuilder membuat tampilan berbeda untuk layar sempit dan lebar.
      body: LayoutBuilder(
        builder: (context, constraints) {
          final lebar = constraints.maxWidth;
          final padding = lebar >= 600 ? 24.0 : 16.0;

          // Ukuran kartu pada daftar horizontal. Lebar mengikuti layar agar
          // di layar sempit tetap terlihat satu kartu + sedikit kartu berikutnya
          // (petunjuk bahwa daftar bisa digeser ke kanan).
          final lebarKartu = lebar >= 900
              ? 280.0
              : lebar >= 600
                  ? 250.0
                  : (lebar * 0.62).clamp(190.0, 260.0);

          // Tinggi kartu mengikuti tinggi layar supaya tidak pernah melebihi
          // ruang yang tersedia (aman di landscape).
          final tinggiKartu =
              (constraints.maxHeight * 0.46).clamp(210.0, 290.0);

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(padding, 8, padding, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _kotakPencarian(),
                      const SizedBox(height: 16),
                      _banner(),
                      const SizedBox(height: 16),
                      _barisKategori(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Resep untukmu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${hasil.length} resep',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Warna.teksSamar,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Daftar resep di Home: digeser ke KANAN (horizontal).
              if (hasil.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _kosong(),
                )
              else
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: tinggiKartu,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                      itemCount: hasil.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final resep = hasil[index];
                        return SizedBox(
                          width: lebarKartu,
                          child: KartuResep(
                            resep: resep,
                            onFavorit: () => _ubahFavorit(resep),
                            onTap: () => _bukaDetail(resep, index),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              // Ruang bawah supaya kartu terakhir tidak tertutup FAB.
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
      ),
    );
  }

  Widget _kotakPencarian() {
    return TextField(
      controller: _cariController,
      textInputAction: TextInputAction.search,
      onChanged: (nilai) => setState(() => _kataKunci = nilai),
      decoration: InputDecoration(
        hintText: 'Cari resep makanan',
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: _kataKunci.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () {
                  _cariController.clear();
                  setState(() => _kataKunci = '');
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Warna.merah),
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      decoration: BoxDecoration(
        color: Warna.krem,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Resep Andalan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Ibu rumah tangga',
                  style: TextStyle(fontSize: 12, color: Warna.teksSamar),
                ),
                const SizedBox(height: 12),
                TombolUtama(
                  label: 'Lihat Lainnya',
                  lebarPenuh: false,
                  onPressed: _bukaKategori,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            'assets/IMG/banner.png',
            height: 96,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _barisKategori() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DataResep.kategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final kategori = DataResep.kategori[index];
          final aktif = kategori == _kategoriAktif;

          return ChoiceChip(
            label: Text(kategori),
            selected: aktif,
            onSelected: (_) => setState(() => _kategoriAktif = kategori),
            labelStyle: TextStyle(
              color: aktif ? Colors.white : Warna.teks,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            showCheckmark: false,
            selectedColor: Warna.merah,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: aktif ? Warna.merah : const Color(0xFFE6E6E6),
            ),
          );
        },
      ),
    );
  }

  Widget _kosong() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 56, color: Colors.black26),
          const SizedBox(height: 12),
          const Text(
            'Resep tidak ditemukan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Coba kata kunci lain atau ubah kategori.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Warna.teksSamar),
          ),
          const SizedBox(height: 16),
          TombolUtama(
            label: 'Reset filter',
            lebarPenuh: false,
            ikon: Icons.refresh,
            onPressed: () {
              _cariController.clear();
              setState(() {
                _kataKunci = '';
                _kategoriAktif = 'Semua';
              });
            },
          ),
        ],
      ),
    );
  }
}
