import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview/client/models/book_dto.dart';

import 'library_item_placeholder_box.dart';

class LibraryItemBook extends StatelessWidget {
  const LibraryItemBook({
    required this.book,
    Key? key,
  }) : super(key: key);

  final _paddingTop = 6.0;
  final _imageWidth = 90.0;
  final _imageHeight = 140.0;

  final BookDto? book;

  @override
  Widget build(BuildContext context) {
    Widget image;
    Widget title;
    Widget authors;
    if (book == null) {
      image = LibraryItemPlaceholderBox(
        width: _imageWidth,
        height: _imageHeight,
      );

      title = LibraryItemPlaceholderBox(
        width: 100,
        height: 20,
      );
      authors = LibraryItemPlaceholderBox(
        width: 60,
        height: 16,
      );
    } else {
      final imageUrl = book!.imageUrl;

      image = (imageUrl == null || imageUrl.isEmpty)
          ? LibraryItemPlaceholderBox(
              width: _imageWidth,
              height: _imageHeight,
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: _imageWidth,
              height: _imageHeight,
              placeholder: (context, url) => LibraryItemPlaceholderBox(
                width: _imageWidth,
                height: _imageHeight,
              ),
            );

      final theme = Theme.of(context);

      final titleText = book!.title;

      title = titleText == null
          ? Container()
          : Text(
              titleText,
              style: theme.textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            );

      final authorsText = book!.authors;

      authors = authorsText == null
          ? Container()
          : Text(
              authorsText,
              style: theme.textTheme.subtitle2,
              overflow: TextOverflow.ellipsis,
            );
    }

    return Container(
      height: 190,
      child: Column(
        children: [
          image,
          Container(
            padding: EdgeInsets.only(
              top: _paddingTop,
            ),
            child: title,
          ),
          Container(
            padding: EdgeInsets.only(
              top: _paddingTop,
            ),
            child: authors,
          ),
        ],
      ),
    );
  }
}
