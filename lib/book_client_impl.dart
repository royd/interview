import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interview/client/book_client.dart';
import 'package:interview/client/get_count_response.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/client/models/books_dto.dart';
import 'package:interview/client/get_book_response.dart';
import 'package:interview/key_value_store.dart';
import 'package:interview/sample_book_data.dart';
import 'package:uuid/uuid.dart';

class BookClientImpl extends BookClient {
  BookClientImpl({
    required KeyValueStore store,
  }) : _store = store {
    _init();
  }

  static const _key = 'interview.books';

  final KeyValueStore _store;
  final _initCompleter = Completer();

  @visibleForTesting
  late final List<BookDto> books;

  @override
  Future<GetCountResponse> getCount() async {
    await _initCompleter.future;

    return GetCountResponse(
      count: books.length,
    );
  }

  @override
  Future<GetBookResponse> getBook({
    required String id,
  }) async {
    await _initCompleter.future;

    final book = books.firstWhere((e) => e.id == id);

    return GetBookResponse(
      book: book,
    );
  }

  @override
  Future<GetBookResponse> getBookAtIndex({
    required int index,
  }) async {
    await _initCompleter.future;

    if (index >= books.length) {
      throw Exception('Requested invalid index: $index');
    }

    return GetBookResponse(
      book: books[index],
    );
  }

  @override
  Future<String> putBook({
    required BookDto book,
  }) async {
    String id;

    await _initCompleter.future;

    if (book.id != null) {
      id = book.id!;

      books.removeWhere((e) => e.id == book.id);

      books.add(book);
    } else {
      id = Uuid().v1();

      books.add(
        BookDto(
          id: id,
          title: book.title,
          authors: book.authors,
          imageUrl: book.imageUrl,
        ),
      );
    }

    await _saveBooks();

    notifyListeners();

    return id;
  }

  @override
  Future deleteBook({
    required String id,
  }) async {
    await _initCompleter.future;

    books.removeWhere((e) => e.id == id);

    await _saveBooks();

    notifyListeners();
  }

  Future _saveBooks() async {
    final json = jsonEncode(
      BooksDto(
        books: books,
      ),
    );

    await _store.setString(_key, json);
  }

  Future _init() async {
    final json = await _store.getString(_key);

    try {
      // Insert initial sample data on first run.
      if (json == null) {
        final json = jsonEncode(sampleBookData);
        await _store.setString(_key, json);

        books = [
          ...sampleBookData.books!,
        ];
      } else {
        books = BooksDto.fromJson(jsonDecode(json)).books!;
      }
    } finally {
      _initCompleter.complete();
    }
  }
}
