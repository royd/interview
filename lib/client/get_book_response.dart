import 'package:interview/client/models/book_dto.dart';
import 'package:interview/client/client_error.dart';

class GetBookResponse {
  GetBookResponse({
    this.book,
    this.error,
  });

  final BookDto? book;
  final ClientError? error;

  bool get isSuccess => error == null && book != null;
}
