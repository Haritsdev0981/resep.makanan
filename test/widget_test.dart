import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/main.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

void main() {
  group('Named Routes & Setup Architecture Test', () {
    testWidgets('Aplikasi boots ke SplashScreen pada rute awal default',
        (WidgetTester tester) async {
      await tester.pumpWidget(const AplikasiResep());

      expect(find.text('Resep Masakan Nusantara'), findsOneWidget);
      expect(find.text('Lanjut ke Login'), findsOneWidget);
    });

    testWidgets('Aplikasi dapat dibuka langsung ke rute login',
        (WidgetTester tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      expect(find.text('Masuk Aplikasi'), findsOneWidget);
      expect(find.text('Masuk sebagai Tamu / Demo'), findsOneWidget);
    });

    testWidgets('Aplikasi dapat dibuka langsung ke rute home dengan argument username',
        (WidgetTester tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.home));

      expect(find.text('Halo, ares!'), findsOneWidget);
      expect(find.text('Tambah Resep Baru'), findsOneWidget);
    });

    test('Konstanta rute terdefinisi dengan benar', () {
      expect(Rute.splash, '/');
      expect(Rute.login, '/login');
      expect(Rute.home, '/home');
      expect(Rute.detail, '/detail');
      expect(Rute.form, '/form');
      expect(Rute.kategori, '/kategori');
    });

    test('Kredensial akun demo terdefinisi', () {
      expect(AkunDemo.username, 'ares');
      expect(AkunDemo.password, 'ares123');
    });

    test('Warna tema aplikasi terdefinisi', () {
      expect(WarnaAplikasi.primer, const Color(0xFFD35400));
      expect(WarnaAplikasi.aksen, const Color(0xFFF39C12));
    });
  });
}
