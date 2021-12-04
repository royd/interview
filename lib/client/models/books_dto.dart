import 'package:interview/client/models/book_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_dto.g.dart';

@JsonSerializable()
class BooksDto {
  const BooksDto({
    this.books,
  });

  final List<BookDto>? books;

  factory BooksDto.fromJson(Map<String, dynamic> json) =>
      _$BooksDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BooksDtoToJson(this);
}
