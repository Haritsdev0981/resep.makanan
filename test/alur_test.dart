import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/models/resep.dart';
import 'package:submission_dicoding/screens/detail_screen.dart';
import 'package:submission_dicoding/screens/form_screen.dart';
import 'package:submission_dicoding/screens/home_screen.dart';
import 'package:submission_dicoding/screens/kategori_screen.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

/// Data dummy dipakai bersama; reset sebelum setiap test.

/// Harness test: Home dipasang di route '/', route lain sama seperti main.dart.
/// Ini menghindari stack ganda yang timbul dari initialRoute bernama.
Widget appUji() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: temaAplikasi(),
    initialRoute: '/',
    routes: {
      '/': (_) => const HomeScreen(),
      Rute.form: (_) => const FormScreen(),
      Rute.detail: (context) {
        final resep = ModalRoute.of(context)!.settings.arguments as Resep;
        return DetailScreen(resep: resep);
      },
      Rute.kategori: (context) {
        final data = ModalRoute.of(context)!.settings.arguments
            as Map<String, List<Resep>>;
        return KategoriScreen(data: data);
      },
    },
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
  setUp(DataResep.reset);

  testWidgets('Hapus dari detail mengembalikan true ke pemanggil', (
    tester,
  ) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    final resep = DataResep.semua().first;
    Object? hasil;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  hasil = await Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      builder: (_) => DetailScreen(resep: resep),
                    ),
                  );
                },
                child: const Text('buka'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('buka'));
    await tester.pumpAndSettle();

    // Tekan ikon hapus di AppBar.
    await tester.tap(find.byTooltip('Hapus resep'));
    await tester.pumpAndSettle();

    expect(find.text('Hapus resep?'), findsOneWidget);

    await tester.tap(find.text('HAPUS'));
    await tester.pumpAndSettle();

    expect(hasil, isTrue);
    expect(find.text('buka'), findsOneWidget);
  });

  testWidgets('Batal pada AlertDialog tidak menghapus', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    final resep = DataResep.semua().first;
    Object? hasil;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  hasil = await Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      builder: (_) => DetailScreen(resep: resep),
                    ),
                  );
                },
                child: const Text('buka'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('buka'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Hapus resep'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('BATAL'));
    await tester.pumpAndSettle();

    expect(hasil, isNull);
    expect(find.text('Hapus resep?'), findsNothing);
    // Masih di halaman detail.
    expect(find.text('Bahan-bahan'), findsOneWidget);
  });

  testWidgets('Home menampilkan SnackBar BATAL setelah resep dihapus', (
    tester,
  ) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(appUji());
    await tester.pumpAndSettle();

    expect(find.text('Sate Kambing'), findsOneWidget);

    // Buka detail kartu pertama.
    await tester.tap(find.text('Sate Kambing'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Hapus resep'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('HAPUS'));
    await tester.pumpAndSettle();

    // Kembali ke Home: resep hilang dan SnackBar punya aksi BATAL.
    expect(find.text('Sate Kambing'), findsNothing);
    expect(find.text('Sate Kambing dihapus'), findsOneWidget);
    expect(find.widgetWithText(SnackBarAction, 'BATAL'), findsOneWidget);

    // Tekan BATAL: resep kembali ke daftar.
    await tester.tap(find.text('BATAL'));
    await tester.pumpAndSettle();

    expect(find.text('Sate Kambing'), findsOneWidget);
  });

  testWidgets('Filter kategori lewat BottomSheet mengubah daftar', (
    tester,
  ) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(appUji());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    // BottomSheet berisi pilihan kategori.
    expect(find.byType(BottomSheet), findsOneWidget);

    await tester.tap(find.text('Minuman').last);
    await tester.pumpAndSettle();

    // Hanya minuman yang tampil.
    expect(find.text('Es Teh Lemon'), findsOneWidget);
    expect(find.text('Sate Kambing'), findsNothing);
  });

  testWidgets('Resep baru dari form muncul di Home', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(appUji());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resep'));
    await tester.pumpAndSettle();

    expect(find.text('Tambah Resep'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contoh: Nasi Goreng Kampung'),
      'Rendang Padang',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contoh: Nasi, telur, kecap'),
      'Daging sapi, santan, rempah',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contoh: 30'),
      '120',
    );
    await tester.enterText(
      find.widgetWithText(
          TextFormField, '500 gram daging\n3 siung bawang putih'),
      '1 kg daging sapi\n2 liter santan',
    );
    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        'Tumis bawang hingga harum\nMasukkan nasi, aduk rata',
      ),
      'Haluskan bumbu\nMasak dengan santan hingga empuk',
    );

    await tester.scrollUntilVisible(
      find.text('Simpan resep'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Simpan resep'));
    await tester.pumpAndSettle();

    expect(find.text('Rendang Padang berhasil ditambahkan'), findsOneWidget);
    expect(find.text('Rendang Padang'), findsOneWidget);
  });
}
