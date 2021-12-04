import 'package:interview/client/models/book_dto.dart';
import 'package:interview/edit_book_kind.dart';

class EditBookResponse {
  EditBookResponse({
    required this.kind,
    this.book,
  });

  final BookDto? book;
  final EditBookKind kind;
}
