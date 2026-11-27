import 'package:flutter_test/flutter_test.dart';
import 'package:submission_dicoding/main.dart';

void main() {
  testWidgets('Starter template loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Resep Makanan - Starter Template'), findsOneWidget);
    expect(find.text('Selamat Datang di Proyek Resep Makanan'), findsOneWidget);
  });
}
