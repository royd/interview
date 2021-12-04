import 'package:flutter_test/flutter_test.dart';
import 'package:interview/book_client_impl.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/memory_key_value_store.dart';
import 'package:interview/sample_book_data.dart';

void main() {
  test(
    'Retrieves count',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final sampleBooks = sampleBookData.books!;

      final response = await client.getCount();
      expect(
        response.count,
        sampleBooks.length,
        reason: 'Incorrect count.',
      );
    },
  );

  test(
    'Deletes book',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final sampleBooks = sampleBookData.books!;

      await client.getCount();

      final bookId = sampleBooks.first.id!;

      expect(
        _containsBook(bookId, client.books),
        isTrue,
        reason: 'Does not contain book.',
      );

      await client.deleteBook(
        id: bookId,
      );

      expect(
        _containsBook(bookId, client.books),
        isFalse,
        reason: 'Does contain book.',
      );
    },
  );

  test(
    'Gets book',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final id = sampleBookData.books!.first.id!;

      final response = await client.getBook(
        id: id,
      );
      final book = response.book;

      expect(
        book,
        isNotNull,
        reason: 'Did not add book.',
      );

      expect(
        book?.id,
        id,
        reason: 'Book ids do not match',
      );
    },
  );

  test(
    'Updates book',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final id = sampleBookData.books!.first.id!;
      final responseOne = await client.getBook(
        id: id,
      );
      final book = responseOne.book!;

      final newTitle = 'New Title';
      final newBook = BookDto(
        id: id,
        title: newTitle,
        authors: book.authors,
        imageUrl: book.imageUrl,
      );

      await client.putBook(
        book: newBook,
      );

      final responseTwo = await client.getBook(
        id: id,
      );
      final updatedBook = responseTwo.book!;

      expect(
        updatedBook.id,
        id,
        reason: 'Book ID changed.',
      );

      expect(
        updatedBook.title,
        newTitle,
        reason: 'Did not update book.',
      );
    },
  );

  test(
    'Adds book',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final id = await client.putBook(
        book: BookDto(),
      );

      final response = await client.getBook(
        id: id,
      );
      final book = response.book;

      expect(
        book,
        isNotNull,
        reason: 'Did not add book.',
      );
    },
  );

  test(
    'Gets book at index',
    () async {
      final client = BookClientImpl(
        store: MemoryKeyValueStore(),
      );

      final sampleBooks = sampleBookData.books!;
      for (var i = 0; i < sampleBooks.length; i++) {
        final response = await client.getBookAtIndex(
          index: i,
        );

        expect(
          response.book,
          isNotNull,
          reason: 'Failed to get book at index: $i',
        );

        expect(
          response.book!.id,
          sampleBooks[i].id,
          reason: 'Book IDs did not match.',
        );
      }
    },
  );
}

bool _containsBook(String id, List<BookDto> books) {
  final book =
      books.cast<BookDto?>().firstWhere((e) => e?.id == id, orElse: () => null);

  return book != null;
}
