/// Model utama aplikasi: satu resep masakan.
///
/// Struktur data linear yang dipakai di seluruh aplikasi adalah `List<Resep>`.
/// Setiap resep juga menyimpan `List<String>` di dalamnya (bahan dan langkah),
/// sehingga objek ini sekaligus contoh struktur data bersarang.
class Resep {
  Resep({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.gambar,
    required this.durasiMenit,
    required this.porsi,
    required this.bahan,
    required this.langkah,
    this.favorit = false,
  });

  final String id;
  final String nama;
  final String kategori;
  final String deskripsi;
  final String gambar;
  final int durasiMenit;
  final int porsi;

  /// Daftar bahan: struktur data linear di dalam objek (bersarang).
  final List<String> bahan;

  /// Daftar langkah memasak.
  final List<String> langkah;

  /// Status favorit bisa berubah, diubah lewat setState di layar.
  bool favorit;

  int get jumlahBahan => bahan.length;

  int get jumlahLangkah => langkah.length;
}
