// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDto _$BookDtoFromJson(Map<String, dynamic> json) => BookDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      authors: json['authors'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$BookDtoToJson(BookDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'imageUrl': instance.imageUrl,
    };
