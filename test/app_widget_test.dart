import 'package:flutter_test/flutter_test.dart';
import 'package:interview/app.dart';
import 'package:interview/edit_book.dart';
import 'package:interview/library.dart';
import 'package:interview/library_item.dart';
import 'package:interview/memory_key_value_store.dart';
import 'package:interview/sample_book_data.dart';

void main() {
  testWidgets('Loads first library item', (tester) async {
    await tester.pumpWidget(
      App(
        store: MemoryKeyValueStore(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(LibraryItem.getKey(0)), findsOneWidget);
  });

  testWidgets('Loads last libray item', (tester) async {
    await tester.pumpWidget(
      App(
        store: MemoryKeyValueStore(),
      ),
    );

    await tester.pumpAndSettle();

    final lastIndex = sampleBookData.books!.length - 1;

    final lastItemFinder = find.byKey(LibraryItem.getKey(lastIndex));

    await tester.scrollUntilVisible(lastItemFinder, 50);

    expect(lastItemFinder, findsOneWidget);
  });

  testWidgets('Adds library item', (tester) async {
    await tester.pumpWidget(
      App(
        store: MemoryKeyValueStore(),
      ),
    );

    await tester.pumpAndSettle();

    final addButtonFinder = find.byKey(Library.addBookButtonKey);

    expect(addButtonFinder, findsOneWidget);

    await tester.tap(addButtonFinder);

    await tester.pumpAndSettle();

    final titleFinder = find.byKey(EditBook.titleKey);

    expect(titleFinder, findsOneWidget);

    final title = 'New Book';

    await tester.enterText(titleFinder, title);

    final authors = 'New Author';

    await tester.enterText(find.byKey(EditBook.authorsKey), authors);

    await tester.tap(find.byKey(EditBook.saveButtonKey));

    await tester.pumpAndSettle();

    final lastIndex = sampleBookData.books!.length;

    final lastItemFinder = find.byKey(LibraryItem.getKey(lastIndex));

    await tester.scrollUntilVisible(lastItemFinder, 50);

    expect(lastItemFinder, findsOneWidget);

    expect(find.text(title), findsOneWidget);

    expect(find.text(authors), findsOneWidget);
  });
}
