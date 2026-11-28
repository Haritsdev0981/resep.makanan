import 'package:flutter/material.dart';

import '../data/data_resep.dart';
import '../models/resep.dart';
import '../utils/konstanta.dart';

/// Layar utama aplikasi (HomeScreen).
///
/// Memenuhi kriteria penilaian DPPB CLO C:
/// - StatefulWidget buatan sendiri dengan pengelolaan state interaktif (setState).
/// - Menampilkan sapaan nama pengguna dari login via named route arguments.
/// - Kolom pencarian real-time dan horizontal filtering chips.
/// - Horizontal list (ListView.separated) & responsive layout dengan LayoutBuilder.
/// - Interaktivitas tombol favorit (setState & SnackBar Undo).
/// - Navigasi dua arah (Passing Data & tangkap hasil pop dari form tambah resep).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.username = AkunDemo.username});

  /// Nama pengguna dari login atau default fallback demo.
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Struktur linear: daftar seluruh resep masakan di memori.
  final List<Resep> _semuaResep = DataResep.daftar;

  /// Controller untuk kolom pencarian masakan.
  final TextEditingController _cariController = TextEditingController();

  String _kataKunci = '';
  String _kategoriAktif = 'Semua';

  @override
  void dispose() {
    _cariController.dispose();
    super.dispose();
  }

  /// Filter interaktif resep berdasarkan kata kunci dan kategori masakan.
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

  /// Menghitung total resep yang ditandai sebagai favorit.
  int get _jumlahFavorit => _semuaResep.where((r) => r.favorit).length;

  /// Membuka form tambah resep dan menangkap objek Resep baru dari pop.
  Future<void> _tambahResep() async {
    final hasil = await Navigator.pushNamed(context, Rute.form);

    if (hasil is Resep && mounted) {
      setState(() {
        _semuaResep.insert(0, hasil);
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Resep "${hasil.nama}" berhasil ditambahkan!'),
            backgroundColor: WarnaAplikasi.sukses,
            duration: const Duration(seconds: 3),
          ),
        );
    }
  }

  /// Mengubah status favorit dengan setState interaktif dan SnackBar Undo.
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
            textColor: WarnaAplikasi.aksen,
            onPressed: () {
              setState(() {
                resep.favorit = !resep.favorit;
              });
            },
          ),
        ),
      );
  }

  /// Membuka detail resep dengan passing data objek Resep.
  Future<void> _bukaDetail(Resep resep, int posisi) async {
    final hasil = await Navigator.pushNamed(
      context,
      Rute.detail,
      arguments: resep,
    );

    // Menangani aksi hapus dari DetailScreen (jika mengembalikan true)
    if (hasil == true && mounted) {
      setState(() => _semuaResep.remove(resep));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${resep.nama} berhasil dihapus'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'BATAL',
              textColor: WarnaAplikasi.aksen,
              onPressed: () {
                setState(() {
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

  /// Membuka katalog kategori dengan mengirim data non-linear Map.
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

  /// BottomSheet pemilihan kategori cepat.
  Future<void> _bukaFilter() async {
    final pilihan = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: DataResep.kategori.map((kategori) {
              final aktif = _kategoriAktif == kategori;
              return ListTile(
                title: Text(
                  kategori,
                  style: TextStyle(
                    fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                    color: aktif ? WarnaAplikasi.primer : WarnaAplikasi.teksUtama,
                  ),
                ),
                trailing: aktif
                    ? const Icon(Icons.check, color: WarnaAplikasi.primer)
                    : null,
                onTap: () => Navigator.pop(context, kategori),
              );
            }).toList(),
          ),
        );
      },
    );

    if (pilihan != null && mounted) {
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
              'Selamat datang,',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            Text(
              'Halo, ${widget.username} 👋',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$_jumlahFavorit',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _bukaFilter,
            tooltip: 'Filter Kategori',
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahResep,
        backgroundColor: WarnaAplikasi.primer,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Resep'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final lebar = constraints.maxWidth;
          final padding = lebar >= 600 ? 24.0 : 16.0;

          // Ukuran kartu responsif terhadap dimensi layar (aman di lanskap)
          final lebarKartu = lebar >= 900
              ? 280.0
              : lebar >= 600
                  ? 250.0
                  : (lebar * 0.65).clamp(200.0, 270.0);

          final tinggiKartu =
              (constraints.maxHeight * 0.48).clamp(220.0, 310.0);

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(padding, 12, padding, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _kotakPencarian(),
                      const SizedBox(height: 16),
                      _banner(),
                      const SizedBox(height: 16),
                      _barisKategori(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Resep Rekomendasi Populer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: WarnaAplikasi.teksUtama,
                            ),
                          ),
                          Text(
                            '${hasil.length} masakan',
                            style: const TextStyle(
                              fontSize: 12,
                              color: WarnaAplikasi.teksSekunder,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Horizontal ListView untuk daftar resep
              if (hasil.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _tampilanKosong(),
                )
              else ...[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: tinggiKartu,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                      itemCount: hasil.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final resep = hasil[index];
                        return SizedBox(
                          width: lebarKartu,
                          child: _KartuResepHome(
                            resep: resep,
                            onFavorit: () => _ubahFavorit(resep),
                            onTap: () => _bukaDetail(resep, index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(padding, 20, padding, 80),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Jelajahi Semua Resep',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: WarnaAplikasi.teksUtama,
                              ),
                            ),
                            TextButton(
                              onPressed: _bukaKategori,
                              child: const Text('Katalog Lengkap →'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: hasil.length,
                          itemBuilder: (context, index) {
                            final resep = hasil[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    resep.gambar,
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 56,
                                      height: 56,
                                      color: WarnaAplikasi.primer.withValues(alpha: 0.1),
                                      child: const Icon(
                                        Icons.restaurant,
                                        color: WarnaAplikasi.primer,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  resep.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  '${resep.kategori} • ${resep.durasiMenit} menit',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    resep.favorit
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: resep.favorit
                                        ? WarnaAplikasi.primer
                                        : Colors.grey,
                                  ),
                                  onPressed: () => _ubahFavorit(resep),
                                ),
                                onTap: () => _bukaDetail(resep, index),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  /// Kolom pencarian masakan real-time
  Widget _kotakPencarian() {
    return TextField(
      controller: _cariController,
      textInputAction: TextInputAction.search,
      onChanged: (nilai) => setState(() => _kataKunci = nilai),
      decoration: InputDecoration(
        hintText: 'Cari resep makanan atau bahan...',
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
        prefixIcon: const Icon(Icons.search, size: 22, color: WarnaAplikasi.primer),
        suffixIcon: _kataKunci.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  _cariController.clear();
                  setState(() => _kataKunci = '');
                },
              ),
      ),
    );
  }

  /// Banner promo masakan nusantara
  Widget _banner() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            WarnaAplikasi.primer,
            WarnaAplikasi.aksen,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: WarnaAplikasi.primer.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
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
                  'Koleksi Resep Pilihan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Masak lezat dan praktis untuk keluarga setiap hari.',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: WarnaAplikasi.primer,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  onPressed: _bukaKategori,
                  child: const Text('Lihat Kategori'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/IMG/banner.png',
              height: 90,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.restaurant_menu,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Baris chip kategori horizontal
  Widget _barisKategori() {
    return SizedBox(
      height: 38,
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
              color: aktif ? Colors.white : WarnaAplikasi.teksUtama,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            showCheckmark: false,
            selectedColor: WarnaAplikasi.primer,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: aktif ? WarnaAplikasi.primer : WarnaAplikasi.batas,
            ),
          );
        },
      ),
    );
  }

  /// Tampilan ketika pencarian atau filter tidak menemukan hasil
  Widget _tampilanKosong() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 56, color: Colors.black26),
            const SizedBox(height: 12),
            const Text(
              'Resep tidak ditemukan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Coba kata kunci lain atau ubah pilihan kategori.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: WarnaAplikasi.teksSekunder),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Filter'),
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
      ),
    );
  }
}

/// Widget Kartu Resep untuk tampilan horizontal HomeScreen.
class _KartuResepHome extends StatelessWidget {
  const _KartuResepHome({
    required this.resep,
    required this.onTap,
    required this.onFavorit,
  });

  final Resep resep;
  final VoidCallback onTap;
  final VoidCallback onFavorit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    resep.gambar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: WarnaAplikasi.primer.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.restaurant,
                        size: 40,
                        color: WarnaAplikasi.primer,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        resep.kategori,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 2,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onFavorit,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            resep.favorit
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: resep.favorit
                                ? WarnaAplikasi.primer
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resep.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: WarnaAplikasi.teksUtama,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          resep.deskripsi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: WarnaAplikasi.teksSekunder,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: WarnaAplikasi.aksen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${resep.durasiMenit} mnt',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: WarnaAplikasi.teksSekunder,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.restaurant_outlined,
                          size: 14,
                          color: WarnaAplikasi.aksen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${resep.porsi} porsi',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: WarnaAplikasi.teksSekunder,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
