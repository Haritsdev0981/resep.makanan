import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/models/resep.dart';
import 'package:submission_dicoding/screens/detail_screen.dart';
import 'package:submission_dicoding/screens/form_screen.dart';
import 'package:submission_dicoding/screens/home_screen.dart';
import 'package:submission_dicoding/screens/kategori_screen.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

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

/// Mengambil ListView horizontal pertama di halaman.
ScrollableState? cariScrollable(WidgetTester tester, Axis arah) {
  final semua = tester.stateList<ScrollableState>(find.byType(Scrollable));
  for (final s in semua) {
    if (s.widget.axisDirection == AxisDirection.right ||
        s.widget.axisDirection == AxisDirection.left) {
      if (arah == Axis.horizontal) return s;
    }
    if (s.widget.axisDirection == AxisDirection.down ||
        s.widget.axisDirection == AxisDirection.up) {
      if (arah == Axis.vertical) return s;
    }
  }
  return null;
}

void main() {
  setUp(DataResep.reset);

  testWidgets('daftar resep di Home memakai scroll horizontal', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(appUji());
    await tester.pumpAndSettle();

    // Ada ListView dengan scrollDirection horizontal (chip + daftar resep).
    final listViewHorizontal = tester
        .widgetList<ListView>(find.byType(ListView))
        .where((lv) => lv.scrollDirection == Axis.horizontal)
        .toList();

    expect(listViewHorizontal, isNotEmpty);
    expect(find.text('Sate Kambing'), findsOneWidget);

    // Cari ListView horizontal yang membungkus kartu resep (bukan baris chip).
    final listKartu = find.ancestor(
      of: find.text('Sate Kambing'),
      matching: find.byWidgetPredicate(
        (w) => w is ListView && w.scrollDirection == Axis.horizontal,
      ),
    );
    expect(listKartu, findsOneWidget);

    final posisiAwal = tester.getTopLeft(find.text('Sate Kambing')).dx;

    // Geser daftar ke kiri: kartu bergerak ke kiri, artinya daftar bisa
    // digeser ke kanan untuk melihat resep berikutnya.
    await tester.drag(listKartu, const Offset(-200, 0));
    await tester.pumpAndSettle();

    final posisiAkhir = tester.getTopLeft(find.text('Sate Kambing')).dx;
    expect(posisiAkhir, lessThan(posisiAwal));
  });

  testWidgets('halaman Kategori tetap scroll vertikal', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    final data = DataResep.perKategori(DataResep.daftar);
    await tester.pumpWidget(
      MaterialApp(
        theme: temaAplikasi(),
        home: KategoriScreen(data: data),
      ),
    );
    await tester.pumpAndSettle();

    // ListView utama vertikal.
    final listViewVertikal = tester
        .widgetList<ListView>(find.byType(ListView))
        .where((lv) => lv.scrollDirection == Axis.vertical)
        .toList();

    expect(listViewVertikal, isNotEmpty);

    // Tidak ada ListView horizontal di halaman ini.
    final listViewHorizontal = tester
        .widgetList<ListView>(find.byType(ListView))
        .where((lv) => lv.scrollDirection == Axis.horizontal)
        .toList();

    expect(listViewHorizontal, isEmpty);
  });

  testWidgets('Home horizontal tidak overflow di landscape', (tester) async {
    aturUkuran(tester, const Size(844, 390));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(appUji());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Home menampilkan username dari login', (tester) async {
    aturUkuran(tester, const Size(390, 844));
    addTearDown(() => resetUkuran(tester));

    await tester.pumpWidget(
      MaterialApp(
          theme: temaAplikasi(), home: const HomeScreen(username: 'ares')),
    );
    await tester.pumpAndSettle();

    expect(find.text('ares 👋'), findsOneWidget);
  });
}
