import 'package:flutter_test/flutter_test.dart';
import 'package:interview/app.dart';
import 'package:interview/library_item.dart';
import 'package:interview/memory_key_value_store.dart';

void main() {
  testWidgets('Loads library item', (WidgetTester tester) async {
    await tester.pumpWidget(
      App(
        store: MemoryKeyValueStore(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(LibraryItem.getKey(0)), findsOneWidget);
  });
}
