import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/main.dart';
import 'package:submission_dicoding/screens/form_screen.dart';
import 'package:submission_dicoding/screens/home_screen.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

void main() {
  setUp(() {
    DataResep.reset();
  });

  group('FormScreen Tests (ISSUE-06)', () {
    testWidgets('Tampilan form render dengan seluruh field dan controller',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.form));
      await tester.pumpAndSettle();

      expect(find.text('Tambah Resep Baru'), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      // 5 TextFormField: nama, deskripsi, durasi, bahan, langkah
      expect(find.byType(TextFormField), findsNWidgets(5));
      // 2 DropdownButtonFormField: kategori dan kesulitan
      expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton, 'Simpan Resep Masakan'),
          findsOneWidget);
    });

    testWidgets('Validasi form menampilkan error saat field kosong',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.form));
      await tester.pumpAndSettle();

      // Scroll ke tombol simpan sebelum di-tap
      final tombolSimpan =
          find.widgetWithText(ElevatedButton, 'Simpan Resep Masakan');
      await tester.ensureVisible(tombolSimpan);
      await tester.tap(tombolSimpan);
      await tester.pumpAndSettle();

      // Validasi pesan kesalahan spesifik
      expect(find.text('Nama resep wajib diisi'), findsOneWidget);
      expect(find.text('Deskripsi resep wajib diisi'), findsOneWidget);
      expect(find.text('Durasi wajib diisi'), findsOneWidget);
      expect(find.text('Bahan-bahan wajib diisi'), findsOneWidget);
      expect(find.text('Langkah memasak wajib diisi'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
        'Validasi batas karakter nama, deskripsi, dan durasi di luar rentang',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.form));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'ab'); // < 3 karakter
      await tester.enterText(fields.at(1), 'abc'); // < 5 karakter
      await tester.enterText(fields.at(2), '999'); // > 600 menit
      await tester.enterText(fields.at(3), 'Garam');
      await tester.enterText(fields.at(4), 'Aduk');

      final tombolSimpan =
          find.widgetWithText(ElevatedButton, 'Simpan Resep Masakan');
      await tester.ensureVisible(tombolSimpan);
      await tester.tap(tombolSimpan);
      await tester.pumpAndSettle();

      expect(find.text('Nama resep minimal 3 karakter'), findsOneWidget);
      expect(find.text('Deskripsi resep minimal 5 karakter'), findsOneWidget);
      expect(find.text('Antara 1 - 600 menit'), findsOneWidget);
    });

    testWidgets(
        'Mengisi form dengan valid mengembalikan objek Resep baru ke HomeScreen',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.home));
      await tester.pumpAndSettle();

      // Buka FormScreen dari HomeScreen FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(FormScreen), findsOneWidget);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Gulai Ayam Khas Minang');
      await tester.enterText(
          fields.at(1), 'Gulai ayam dengan rempah kuning santan kental');
      await tester.enterText(fields.at(2), '40');
      await tester.enterText(
          fields.at(3), '1 ekor ayam potong\n500 ml santan\nBumbu gulai');
      await tester.enterText(
          fields.at(4), 'Tumis bumbu gulai\nMasukkan ayam\nTuang santan dan masak');

      // Scroll ke tombol simpan sebelum di-tap
      final tombolSimpan =
          find.widgetWithText(ElevatedButton, 'Simpan Resep Masakan');
      await tester.ensureVisible(tombolSimpan);
      await tester.tap(tombolSimpan);
      await tester.pumpAndSettle();

      // Layar kembali ke HomeScreen (pop)
      expect(find.byType(HomeScreen), findsOneWidget);
      // SnackBar sukses muncul
      expect(find.text('Resep "Gulai Ayam Khas Minang" berhasil ditambahkan!'),
          findsOneWidget);
      // Resep baru tampil di HomeScreen
      expect(find.text('Gulai Ayam Khas Minang'), findsOneWidget);
    });
  });
}
