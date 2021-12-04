import 'package:flutter/widgets.dart';
import 'package:interview/client/get_book_response.dart';
import 'package:interview/client/get_count_response.dart';
import 'package:interview/client/models/book_dto.dart';

abstract class BookClient extends ChangeNotifier {
  Future<GetCountResponse> getCount();

  Future<GetBookResponse> getBook({
    required String id,
  });

  Future<GetBookResponse> getBookAtIndex({
    required int index,
  });

  Future<String> putBook({
    required BookDto book,
  });

  Future deleteBook({
    required String id,
  });
}
