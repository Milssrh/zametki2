import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());
    expect(find.text('Мои заметки'), findsOneWidget);
  });
}