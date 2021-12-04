// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksDto _$BooksDtoFromJson(Map<String, dynamic> json) => BooksDto(
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksDtoToJson(BooksDto instance) => <String, dynamic>{
      'books': instance.books,
    };
