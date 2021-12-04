import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview/client/get_book_response.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/library_model.dart';
import 'package:interview/library_item_book.dart';

import 'package:provider/provider.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem({
    required int index,
    required void Function({
      BookDto? book,
    })
        onEdit,
    Key? key,
  })  : _index = index,
        _onEdit = onEdit,
        super(
          key: key,
        );

  static ValueKey getKey(int index) => ValueKey(
        'library_item_$index',
      );

  final int _index;
  final void Function({
    BookDto? book,
  }) _onEdit;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LibraryModel>(context);

    return Container(
      key: getKey(_index),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: FutureBuilder<GetBookResponse>(
        future: model.getBook(index: _index),
        builder: (context, snapshot) {
          final response = snapshot.data;
          final book = response?.book;

          return GestureDetector(
            onTap: () => _onEdit(
              book: book,
            ),
            child: AnimatedSwitcher(
              duration: Duration(
                milliseconds: 300,
              ),
              child: LibraryItemBook(
                key: ValueKey(
                  book?.id,
                ),
                book: book,
              ),
            ),
          );
        },
      ),
    );
  }
}
