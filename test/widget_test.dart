
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaris_lab/main.dart';

void main() {
  testWidgets('Aplikasi Inventaris menampilkan halaman Login',
          (WidgetTester tester) async {

        // Menjalankan aplikasi Inventaris
        await tester.pumpWidget(const InventarisApp());

        // Memastikan halaman Login tampil
        expect(find.text('INVENTARIS LAB KOMPUTER'), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('LOGIN'), findsOneWidget);
      });
}
