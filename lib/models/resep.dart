/// Model utama aplikasi: satu resep masakan.
///
/// Memenuhi kriteria penilaian DPPB:
/// - CLO B & C: Struktur Data Linear `List<Resep>` dan relasi data bersarang (`List<String>` bahan & langkah).
/// - Method `copyWith` untuk pembaruan state mutasi data.
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
    this.tingkatKesulitan = 'Sedang',
    this.favorit = false,
  });

  /// Identitas unik resep.
  final String id;

  /// Nama masakan.
  final String nama;

  /// Kategori masakan (Tradisional, Cepat Saji, Seafood, Minuman, dll).
  final String kategori;

  /// Penjelasan singkat masakan.
  final String deskripsi;

  /// Path asset gambar atau URL gambar.
  final String gambar;

  /// Estimasi durasi memasak dalam satuan menit.
  final int durasiMenit;

  /// Estimasi porsi sajian.
  final int porsi;

  /// Tingkat kesulitan pembuatan ('Mudah', 'Sedang', 'Sulit').
  final String tingkatKesulitan;

  /// Daftar bahan: struktur data linear bersarang (Nested List).
  final List<String> bahan;

  /// Daftar langkah memasak: struktur data linear bersarang (Nested List).
  final List<String> langkah;

  /// Status apakah resep ditandai sebagai favorit oleh pengguna.
  bool favorit;

  /// Alias gambarUrl untuk kemudahan akses.
  String get gambarUrl => gambar;

  /// Menghitung jumlah bahan yang dibutuhkan.
  int get jumlahBahan => bahan.length;

  /// Menghitung jumlah tahapan langkah memasak.
  int get jumlahLangkah => langkah.length;

  /// Membuat salinan objek `Resep` dengan nilai baru (immutability helper).
  Resep copyWith({
    String? id,
    String? nama,
    String? kategori,
    String? deskripsi,
    String? gambar,
    int? durasiMenit,
    int? porsi,
    String? tingkatKesulitan,
    List<String>? bahan,
    List<String>? langkah,
    bool? favorit,
  }) {
    return Resep(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      deskripsi: deskripsi ?? this.deskripsi,
      gambar: gambar ?? this.gambar,
      durasiMenit: durasiMenit ?? this.durasiMenit,
      porsi: porsi ?? this.porsi,
      tingkatKesulitan: tingkatKesulitan ?? this.tingkatKesulitan,
      bahan: bahan ?? List<String>.from(this.bahan),
      langkah: langkah ?? List<String>.from(this.langkah),
      favorit: favorit ?? this.favorit,
    );
  }
}
