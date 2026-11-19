import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/data/data_resep.dart';
import 'package:submission_dicoding/screens/login_screen.dart';
import 'package:submission_dicoding/screens/splash_screen.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

void aturUkuran(WidgetTester tester, Size ukuran) {
  tester.view.physicalSize = ukuran;
  tester.view.devicePixelRatio = 1.0;
}

void resetUkuran(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

Widget appLogin() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: temaAplikasi(),
    initialRoute: '/',
    routes: {
      '/': (_) => const LoginScreen(),
      Rute.home: (_) => const HomeScreenUji(),
    },
  );
}

/// Home tiruan sederhana untuk memastikan navigasi login berhasil.
class HomeScreenUji extends StatelessWidget {
  const HomeScreenUji({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('HALAMAN HOME')));
  }
}

void main() {
  setUp(DataResep.reset);

  group('LoginScreen', () {
    testWidgets('tampil dengan field username dan password', (tester) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      expect(find.text('Resep Makanan'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Masukkan username'),
          findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Masukkan password'),
          findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);
      // Petunjuk akun demo ditampilkan.
      expect(find.text('Akun demo: ares / ares123'), findsOneWidget);
    });

    testWidgets('validasi: field kosong menampilkan pesan kesalahan', (
      tester,
    ) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Username wajib diisi'), findsOneWidget);
      expect(find.text('Password wajib diisi'), findsOneWidget);
      // Tidak berpindah halaman.
      expect(find.text('HALAMAN HOME'), findsNothing);
    });

    testWidgets('password salah menampilkan SnackBar dan tidak masuk', (
      tester,
    ) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan username'),
        'ares',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan password'),
        'salah123',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(
        find.text('Username atau password salah. Coba lagi.'),
        findsOneWidget,
      );
      expect(find.text('HALAMAN HOME'), findsNothing);
    });

    testWidgets('username benar password salah tetap ditolak', (tester) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan username'),
        'budi',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan password'),
        'ares123',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(
        find.text('Username atau password salah. Coba lagi.'),
        findsOneWidget,
      );
    });

    testWidgets('ares / ares123 berhasil masuk ke Home', (tester) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan username'),
        'ares',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Masukkan password'),
        'ares123',
      );
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('HALAMAN HOME'), findsOneWidget);
    });

    testWidgets('tombol mata menampilkan / menyembunyikan password', (
      tester,
    ) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(appLogin());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('login tidak overflow di berbagai ukuran layar', (
      tester,
    ) async {
      const ukuran = <Size>[
        Size(320, 640),
        Size(390, 844),
        Size(800, 1000),
        Size(844, 390),
      ];

      for (final u in ukuran) {
        aturUkuran(tester, u);
        await tester.pumpWidget(appLogin());
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'ukuran $u');
      }

      resetUkuran(tester);
    });
  });

  group('SplashScreen', () {
    testWidgets('setelah splash pindah ke Login', (tester) async {
      aturUkuran(tester, const Size(390, 844));
      addTearDown(() => resetUkuran(tester));

      await tester.pumpWidget(
        MaterialApp(
          theme: temaAplikasi(),
          initialRoute: '/',
          routes: {
            '/': (_) => const SplashScreen(),
            Rute.login: (_) => const LoginScreen(),
            Rute.home: (_) => const HomeScreenUji(),
          },
        ),
      );

      await tester.pump();
      // Splash menunggu 1400 ms sebelum pindah ke Login.
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // Sudah di halaman login, bukan Home.
      expect(find.text('Masuk'), findsOneWidget);
      expect(find.text('HALAMAN HOME'), findsNothing);
    });
  });
}
