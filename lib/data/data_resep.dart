import '../models/resep.dart';

/// Data dummy aplikasi. Semua disimpan di memori (tanpa database/API).
class DataResep {
  const DataResep._();

  /// Daftar utama yang dipakai bersama seluruh layar.
  ///
  /// Dibuat `final` (satu objek List) supaya perubahan dari layar mana pun
  /// langsung terlihat di layar lain, tanpa perlu state management tambahan.
  static final List<Resep> daftar = semua();

  /// Mengembalikan data ke kondisi awal. Dipakai oleh widget test agar setiap
  /// test mulai dari data yang bersih.
  static void reset() {
    daftar
      ..clear()
      ..addAll(semua());
  }

  /// Struktur data linear: daftar utama seluruh resep.
  static List<Resep> semua() => [
        Resep(
          id: 'r1',
          nama: 'Sate Kambing',
          kategori: 'Tradisional',
          deskripsi: 'Kecap manis, daging kambing, bawang goreng',
          gambar: 'assets/IMG/sate.png',
          durasiMenit: 45,
          porsi: 4,
          bahan: const [
            '500 gram daging kambing, potong dadu 2 cm',
            'Tusuk sate secukupnya, rendam air',
            '50 gram kubis, iris halus',
            '2 buah tomat merah, potong',
            '10 buah cabai rawit, iris',
            '10 butir bawang merah, iris',
            '5 sdm kecap manis',
            '1 buah jeruk nipis',
          ],
          langkah: const [
            'Tusuk daging dengan tusukan sate, isi 4 potong per tusuk.',
            'Campur semua bahan olesan, lalu oleskan ke daging.',
            'Bakar di atas bara api sambil dioles bumbu hingga kecokelatan.',
            'Tata bersama lalapan, tuang kecap manis, sajikan.',
          ],
        ),
        Resep(
          id: 'r2',
          nama: 'Soto Betawi',
          kategori: 'Tradisional',
          deskripsi: 'Daging sapi, tomat, kerupuk, daun bawang',
          gambar: 'assets/IMG/soto.png',
          durasiMenit: 90,
          porsi: 5,
          bahan: const [
            '500 gram daging sapi',
            '2,5 liter air',
            '200 gram babat, rebus dan potong',
            '500 ml santan',
            '4 batang serai, memarkan',
            '10 lembar daun jeruk',
            '3 lembar daun salam',
            'Garam, merica, dan gula secukupnya',
          ],
          langkah: const [
            'Rebus daging sampai empuk, potong dadu, simpan kaldunya.',
            'Masukkan daging, babat, dan paru ke dalam kaldu, didihkan.',
            'Tumis bumbu halus bersama rempah, tuang ke rebusan.',
            'Masukkan santan dan bumbu, masak hingga matang.',
            'Sajikan dengan tomat, kerupuk, dan daun bawang.',
          ],
        ),
        Resep(
          id: 'r3',
          nama: 'Gudeg Bu Aan',
          kategori: 'Tradisional',
          deskripsi: 'Nangka manis, krecek, aneka bacem',
          gambar: 'assets/IMG/gudeg.png',
          durasiMenit: 180,
          porsi: 6,
          bahan: const [
            '1 kg nangka muda, potong dadu',
            '5 butir telur ayam rebus',
            '1,5 liter santan sedang',
            '500 ml santan kental',
            '120 gram gula jawa',
            '3 lembar daun salam',
            '3 cm lengkuas, memarkan',
            'Bawang merah, bawang putih, kemiri, ketumbar',
          ],
          langkah: const [
            'Rebus nangka muda hingga lunak, angkat dan tiriskan.',
            'Haluskan semua bumbu hingga benar-benar halus.',
            'Masak nangka, telur, santan, dan bumbu dalam panci.',
            'Masak dengan api sedang hingga bumbu meresap dan kuah susut.',
            'Tuang santan kental, masak hingga kuah benar-benar susut.',
          ],
        ),
        Resep(
          id: 'r4',
          nama: 'Nasi Goreng Kampung',
          kategori: 'Cepat Saji',
          deskripsi: 'Nasi, telur, kecap, bawang goreng',
          gambar: 'assets/IMG/sate.png',
          durasiMenit: 15,
          porsi: 2,
          bahan: const [
            '2 piring nasi putih',
            '2 butir telur',
            '3 siung bawang putih, cincang',
            '2 sdm kecap manis',
            '1 batang daun bawang',
            'Garam dan merica secukupnya',
          ],
          langkah: const [
            'Tumis bawang putih hingga harum.',
            'Masukkan telur, buat orak-arik.',
            'Tambahkan nasi, kecap, garam, dan merica, aduk rata.',
            'Taburi daun bawang dan bawang goreng, sajikan hangat.',
          ],
        ),
        Resep(
          id: 'r5',
          nama: 'Mie Goreng Jawa',
          kategori: 'Cepat Saji',
          deskripsi: 'Mie kuning, kol, sawi, telur',
          gambar: 'assets/IMG/soto.png',
          durasiMenit: 20,
          porsi: 2,
          bahan: const [
            '200 gram mie kuning',
            '100 gram kol, iris',
            '1 ikat sawi hijau',
            '1 butir telur',
            '2 sdm kecap manis',
            'Bawang merah dan bawang putih',
          ],
          langkah: const [
            'Tumis bawang hingga harum, masukkan telur.',
            'Tambahkan kol dan sawi, aduk hingga layu.',
            'Masukkan mie dan kecap, aduk rata.',
            'Masak sebentar, angkat dan sajikan.',
          ],
        ),
        Resep(
          id: 'r6',
          nama: 'Udang Saus Padang',
          kategori: 'Seafood',
          deskripsi: 'Udang, saus tomat, cabai, bawang',
          gambar: 'assets/IMG/gudeg.png',
          durasiMenit: 30,
          porsi: 3,
          bahan: const [
            '500 gram udang, kupas',
            '3 sdm saus tomat',
            '5 buah cabai merah, haluskan',
            '3 siung bawang putih',
            '1 buah bawang bombai, iris',
            'Garam, gula, dan air secukupnya',
          ],
          langkah: const [
            'Tumis bawang putih dan bombai hingga harum.',
            'Masukkan cabai halus dan saus tomat.',
            'Tambahkan udang, masak hingga berubah warna.',
            'Bumbui garam dan gula, masak hingga saus mengental.',
          ],
        ),
        Resep(
          id: 'r7',
          nama: 'Ikan Bakar Kecap',
          kategori: 'Seafood',
          deskripsi: 'Ikan nila, kecap, jeruk nipis',
          gambar: 'assets/IMG/sate.png',
          durasiMenit: 35,
          porsi: 2,
          bahan: const [
            '2 ekor ikan nila',
            '4 sdm kecap manis',
            '1 buah jeruk nipis',
            '3 siung bawang putih',
            '2 sdm margarin',
            'Garam secukupnya',
          ],
          langkah: const [
            'Lumuri ikan dengan jeruk nipis dan garam, diamkan 10 menit.',
            'Campur kecap, bawang putih, dan margarin sebagai olesan.',
            'Bakar ikan sambil dioles bumbu hingga matang.',
            'Sajikan dengan sambal dan lalapan.',
          ],
        ),
        Resep(
          id: 'r8',
          nama: 'Es Teh Lemon',
          kategori: 'Minuman',
          deskripsi: 'Teh, lemon, gula, es batu',
          gambar: 'assets/IMG/soto.png',
          durasiMenit: 10,
          porsi: 2,
          bahan: const [
            '2 kantong teh celup',
            '1 buah lemon, iris',
            '3 sdm gula pasir',
            '400 ml air panas',
            'Es batu secukupnya',
          ],
          langkah: const [
            'Seduh teh dengan air panas, tambahkan gula, aduk.',
            'Diamkan hingga hangat, lalu saring.',
            'Tuang ke gelas berisi es batu.',
            'Tambahkan irisan lemon, sajikan.',
          ],
        ),
        Resep(
          id: 'r9',
          nama: 'Jus Alpukat',
          kategori: 'Minuman',
          deskripsi: 'Alpukat, susu, gula, es',
          gambar: 'assets/IMG/gudeg.png',
          durasiMenit: 10,
          porsi: 2,
          bahan: const [
            '2 buah alpukat matang',
            '200 ml susu cair',
            '3 sdm gula pasir',
            '100 ml air dingin',
            'Es batu secukupnya',
          ],
          langkah: const [
            'Keruk daging alpukat, masukkan ke blender.',
            'Tambahkan susu, gula, dan air dingin.',
            'Blender hingga halus.',
            'Sajikan dengan es batu dan susu di atasnya.',
          ],
        ),
      ];

  /// Struktur data non-linear: Map yang mengelompokkan resep per kategori.
  /// Setiap value adalah `List<Resep>`, jadi ini Map berisi List.
  static Map<String, List<Resep>> perKategori(List<Resep> daftar) {
    final hasil = <String, List<Resep>>{};
    for (final resep in daftar) {
      hasil.putIfAbsent(resep.kategori, () => <Resep>[]).add(resep);
    }
    return hasil;
  }

  /// Daftar nama kategori untuk chip filter.
  static const List<String> kategori = [
    'Semua',
    'Tradisional',
    'Cepat Saji',
    'Seafood',
    'Minuman',
  ];
}
