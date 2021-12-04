import 'package:json_annotation/json_annotation.dart';

part 'book_dto.g.dart';

@JsonSerializable()
class BookDto {
  const BookDto({
    this.id,
    this.title,
    this.authors,
    this.imageUrl,
  });

  final String? id;
  final String? title;
  final String? authors;
  final String? imageUrl;

  factory BookDto.fromJson(Map<String, dynamic> json) =>
      _$BookDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookDtoToJson(this);
}
