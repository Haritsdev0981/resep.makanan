import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/models/resep.dart';

void main() {
  group('Resep Model & Data Layer Test (CLO B & C)', () {
    test('Model Resep dapat diinstansiasi dengan benar', () {
      final resep = Resep(
        id: 'test-1',
        nama: 'Rendang Sapi',
        kategori: 'Tradisional',
        deskripsi: 'Daging sapi rempah khas Minang',
        gambar: 'assets/IMG/sate.png',
        durasiMenit: 120,
        porsi: 6,
        tingkatKesulitan: 'Sulit',
        bahan: ['500g Daging', 'Santan', 'Rempah'],
        langkah: ['Tumis bumbu', 'Masukkan daging', 'Masak hingga berminyak'],
      );

      expect(resep.id, 'test-1');
      expect(resep.nama, 'Rendang Sapi');
      expect(resep.jumlahBahan, 3);
      expect(resep.jumlahLangkah, 3);
      expect(resep.favorit, false);
      expect(resep.gambarUrl, 'assets/IMG/sate.png');
    });

    test('Method copyWith bekerja memperbarui field tanpa mengubah nilai asli', () {
      final resepAsli = Resep(
        id: 'test-2',
        nama: 'Nasi Liwet',
        kategori: 'Tradisional',
        deskripsi: 'Nasi gurih teri',
        gambar: 'assets/IMG/banner.png',
        durasiMenit: 45,
        porsi: 4,
        bahan: ['Beras', 'Teri', 'Santan'],
        langkah: ['Cuci beras', 'Masak di rice cooker'],
      );

      final resepBaru = resepAsli.copyWith(
        favorit: true,
        durasiMenit: 50,
      );

      expect(resepBaru.favorit, true);
      expect(resepBaru.durasiMenit, 50);
      expect(resepBaru.nama, resepAsli.nama);
      expect(resepAsli.favorit, false); // immutability check
    });

    test('DataResep.semua() memuat minimal 6 data resep nusantara', () {
      final daftar = DataResep.semua();
      expect(daftar.length, greaterThanOrEqualTo(6));
      expect(daftar.length, 9);
    });

    test('DataResep.perKategori() menghasilkan Map non-linear yang valid', () {
      final daftar = DataResep.semua();
      final mapKategori = DataResep.perKategori(daftar);

      expect(mapKategori, isA<Map<String, List<Resep>>>());
      expect(mapKategori.containsKey('Tradisional'), true);
      expect(mapKategori.containsKey('Cepat Saji'), true);
      expect(mapKategori.containsKey('Seafood'), true);
      expect(mapKategori.containsKey('Minuman'), true);

      expect(mapKategori['Tradisional']!.length, greaterThanOrEqualTo(3));
    });

    test('DataResep.reset() mengembalikan list ke kondisi default', () {
      DataResep.daftar.clear();
      expect(DataResep.daftar.isEmpty, true);

      DataResep.reset();
      expect(DataResep.daftar.length, 9);
    });
  });
}
