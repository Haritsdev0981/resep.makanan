import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/models/resep.dart';
import 'package:submission_dicoding/screens/detail_screen.dart';
import 'package:submission_dicoding/screens/form_screen.dart';
import 'package:submission_dicoding/screens/home_screen.dart';
import 'package:submission_dicoding/screens/kategori_screen.dart';
import 'package:submission_dicoding/data/data_resep.dart';

/// Membungkus layar dengan MaterialApp agar navigasi & theme tersedia.
Widget bungkus(Widget child, {Size ukuran = const Size(390, 844)}) {
  return MaterialApp(
    home: child,
  );
}

void aturUkuran(WidgetTester tester, Size ukuran) {
  tester.view.physicalSize = ukuran;
  tester.view.devicePixelRatio = 1.0;
}

void resetUkuran(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

void main() {
  // Ukuran layar yang diuji: ponsel sempit, ponsel biasa, tablet, landscape.
  const ukuranUji = <String, Size>{
    'ponsel 320': Size(320, 640),
    'ponsel 390': Size(390, 844),
    'ponsel 430': Size(430, 932),
    'tablet 800': Size(800, 1000),
    'landscape 844x390': Size(844, 390),
  };

  for (final entri in ukuranUji.entries) {
    testWidgets('HomeScreen tidak overflow di ${entri.key}', (tester) async {
      aturUkuran(tester, entri.value);
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(
        MaterialApp(
            theme: ThemeData(useMaterial3: true), home: const HomeScreen()),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  }

  for (final entri in ukuranUji.entries) {
    testWidgets('DetailScreen tidak overflow di ${entri.key}', (tester) async {
      aturUkuran(tester, entri.value);
      addTearDown(() => resetUkuran(tester));

      final resep = DataResep.semua().first;
      await tester.pumpWidget(
        MaterialApp(
            theme: ThemeData(useMaterial3: true),
            home: DetailScreen(resep: resep)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  }

  for (final entri in ukuranUji.entries) {
    testWidgets('FormScreen tidak overflow di ${entri.key}', (tester) async {
      aturUkuran(tester, entri.value);
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(
        MaterialApp(
            theme: ThemeData(useMaterial3: true), home: const FormScreen()),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  }

  for (final entri in ukuranUji.entries) {
    testWidgets('KategoriScreen tidak overflow di ${entri.key}',
        (tester) async {
      aturUkuran(tester, entri.value);
      addTearDown(() => resetUkuran(tester));

      final data = DataResep.perKategori(DataResep.semua());
      await tester.pumpWidget(
        MaterialApp(
            theme: ThemeData(useMaterial3: true),
            home: KategoriScreen(data: data)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Pencarian menyaring daftar resep', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(
      MaterialApp(
          theme: ThemeData(useMaterial3: true), home: const HomeScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sate Kambing'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'soto');
    await tester.pumpAndSettle();

    expect(find.text('Soto Betawi'), findsOneWidget);
    expect(find.text('Sate Kambing'), findsNothing);
  });

  testWidgets('Favorit menambah jumlah di AppBar', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(
      MaterialApp(
          theme: ThemeData(useMaterial3: true), home: const HomeScreen()),
    );
    await tester.pumpAndSettle();

    // Awalnya belum ada favorit.
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Form menampilkan validasi saat kosong', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(
      MaterialApp(
          theme: ThemeData(useMaterial3: true), home: const FormScreen()),
    );
    await tester.pumpAndSettle();

    // Tombol simpan ada di bawah, jadi gulir dulu sebelum ditekan.
    await tester.scrollUntilVisible(
      find.text('Simpan resep'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Simpan resep'));
    await tester.pumpAndSettle();

    expect(find.text('Nama resep wajib diisi'), findsOneWidget);
    expect(find.text('Deskripsi wajib diisi'), findsOneWidget);
  });

  testWidgets('DataResep.perKategori mengelompokkan dengan benar',
      (tester) async {
    final data = DataResep.perKategori(DataResep.semua());

    expect(
        data.keys.toSet(), {'Tradisional', 'Cepat Saji', 'Seafood', 'Minuman'});
    expect(data['Tradisional']!.length, 3);
    expect(data['Cepat Saji']!.length, 2);
    expect(data['Seafood']!.length, 2);
    expect(data['Minuman']!.length, 2);
  });

  testWidgets('Model Resep menyimpan list bahan dan langkah', (tester) async {
    final resep = Resep(
      id: 'x',
      nama: 'Uji',
      kategori: 'Minuman',
      deskripsi: 'd',
      gambar: 'assets/IMG/sate.png',
      durasiMenit: 5,
      porsi: 1,
      bahan: const ['a', 'b'],
      langkah: const ['1', '2', '3'],
    );

    expect(resep.jumlahBahan, 2);
    expect(resep.jumlahLangkah, 3);
    expect(resep.favorit, isFalse);
  });

  // Uji dengan skala teks besar: kasus paling rawan overflow.
  for (final skala in [1.5, 2.0]) {
    testWidgets('HomeScreen aman pada skala teks $skala', (tester) async {
      aturUkuran(tester, const Size(360, 720));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(skala)),
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('DetailScreen aman pada skala teks $skala', (tester) async {
      aturUkuran(tester, const Size(360, 720));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(skala)),
            child: DetailScreen(resep: DataResep.semua().first),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  }
}
