import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/main.dart';
import 'package:submission_dicoding/screens/home_screen.dart';
import 'package:submission_dicoding/screens/login_screen.dart';
import 'package:submission_dicoding/utils/konstanta.dart';

void main() {
  group('SplashScreen Tests (ISSUE-03)', () {
    testWidgets('SplashScreen berpindah ke LoginScreen setelah timer 2 detik',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.splash));

      // Verifikasi tampilan awal SplashScreen
      expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
      expect(find.text('Resep Masakan Nusantara'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Jalankan timer 2 detik
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Memastikan sudah pindah ke LoginScreen dan tidak bisa kembali ke Splash
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Masuk untuk menjelajahi dan mengelola resep'),
          findsOneWidget);
    });
  });

  group('LoginScreen Form & Validation Tests (ISSUE-03)', () {
    testWidgets('Menampilkan error validasi saat username dan password kosong',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      // Tekan tombol Masuk tanpa mengisi field
      await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
      await tester.pumpAndSettle();

      // Verifikasi pesan validasi muncul
      expect(find.text('Username wajib diisi'), findsOneWidget);
      expect(find.text('Password wajib diisi'), findsOneWidget);
    });

    testWidgets(
        'Menampilkan error validasi saat karakter kurang dari batas minimum',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'ab'); // < 3 karakter
      await tester.enterText(textFields.at(1), '12345'); // < 6 karakter

      await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
      await tester.pumpAndSettle();

      expect(find.text('Username minimal 3 karakter'), findsOneWidget);
      expect(find.text('Password minimal 6 karakter'), findsOneWidget);
    });

    testWidgets('Show/Hide password toggle berfungsi dengan setState',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      final passwordFieldFinder = find.byType(EditableText).last;
      EditableText passwordField = tester.widget(passwordFieldFinder);
      expect(passwordField.obscureText, isTrue);

      // Tekan ikon show/hide password
      final toggleIcon = find.byIcon(Icons.visibility_off_outlined);
      expect(toggleIcon, findsOneWidget);
      await tester.tap(toggleIcon);
      await tester.pumpAndSettle();

      // Verifikasi status obscureText berubah menjadi false
      passwordField = tester.widget(passwordFieldFinder);
      expect(passwordField.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets(
        'Menampilkan SnackBar saat username atau password tidak cocok dengan AkunDemo',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'user_salah');
      await tester.enterText(textFields.at(1), 'pass_salah');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Username atau password salah. Silakan coba lagi.'),
          findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets(
        'Berhasil login dengan kredensial benar dan berpindah ke HomeScreen',
        (tester) async {
      await tester.pumpWidget(const AplikasiResep(ruteAwal: Rute.login));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), AkunDemo.username);
      await tester.enterText(textFields.at(1), AkunDemo.password);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
      await tester.pumpAndSettle();

      // Verifikasi berhasil masuk ke HomeScreen dan menampilkan argument nama pengguna
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Halo, ${AkunDemo.username} 👋'), findsOneWidget);
    });
  });
}
