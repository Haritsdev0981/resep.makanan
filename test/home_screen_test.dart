import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/screens/home_screen.dart';

void main() {
  setUp(() {
    DataResep.reset();
  });

  Widget buatHomeScreen({String username = 'Harits'}) {
    return MaterialApp(
      home: HomeScreen(username: username),
    );
  }

  group('HomeScreen Widget & Interactivity Tests (CLO C)', () {
    testWidgets('Menampilkan sapaan nama pengguna dengan benar',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen(username: 'Harits'));
      await tester.pumpAndSettle();

      expect(find.text('Halo, Harits 👋'), findsOneWidget);
      expect(find.text('Koleksi Resep Pilihan'), findsOneWidget);
    });

    testWidgets('Menampilkan search field, banner, dan category chips',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Semua'), findsOneWidget);
      expect(find.text('Tradisional'), findsWidgets);
      expect(find.text('Seafood'), findsWidgets);
      expect(find.text('Resep Rekomendasi Populer'), findsOneWidget);
    });

    testWidgets('Pencarian menyaring resep secara real-time (setState)',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      // Sebelum pencarian
      expect(find.text('Sate Kambing'), findsWidgets);

      // Cari kata kunci yang spesifik: "Gudeg"
      await tester.enterText(find.byType(TextField), 'Gudeg');
      await tester.pumpAndSettle();

      expect(find.text('Gudeg Bu Aan'), findsWidgets);
      expect(find.text('Sate Kambing'), findsNothing);
    });

    testWidgets('Tampilan kosong muncul bila pencarian tidak cocok',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Burger Keju 999');
      await tester.pumpAndSettle();

      expect(find.text('Resep tidak ditemukan'), findsOneWidget);
      expect(find.text('Reset Filter'), findsOneWidget);

      // Klik tombol reset filter
      await tester.tap(find.text('Reset Filter'));
      await tester.pumpAndSettle();

      expect(find.text('Resep tidak ditemukan'), findsNothing);
      expect(find.text('Sate Kambing'), findsWidgets);
    });

    testWidgets('Filter chip kategori menyaring resep sesuai kategori',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      // Pilih kategori Seafood
      await tester.tap(find.text('Seafood'));
      await tester.pumpAndSettle();

      expect(find.text('Udang Saus Padang'), findsWidgets);
      expect(find.text('Ikan Bakar Kecap'), findsWidgets);
      expect(find.text('Sate Kambing'), findsNothing);
    });

    testWidgets('Tombol favorit interaktif memperbarui state dan counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      // Counter awal favorit adalah 0
      expect(find.text('0'), findsOneWidget);

      // Cari tombol favorit pertama dan tap
      final tombolFavorit = find.byIcon(Icons.favorite_border).first;
      await tester.tap(tombolFavorit);
      await tester.pumpAndSettle();

      // Counter bertambah jadi 1
      expect(find.text('1'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('FAB Tambah Resep tersedia', (WidgetTester tester) async {
      await tester.pumpWidget(buatHomeScreen());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Tambah Resep'), findsOneWidget);
    });
  });
}
