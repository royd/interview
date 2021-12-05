import 'package:flutter/material.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/edit_book.dart';
import 'package:interview/app_localizations.dart';
import 'package:interview/edit_book_kind.dart';
import 'package:interview/edit_book_response.dart';
import 'package:interview/library_build_data.dart';
import 'package:interview/library_model.dart';
import 'package:interview/library_item.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class Library extends StatefulWidget {
  Library({
    required this.title,
    Key? key,
  }) : super(key: key);

  static const addBookButtonKey = ValueKey('library_add_book');

  final String title;

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final _subscriptions = CompositeSubscription();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LibraryModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: StreamBuilder<LibararyBuildData>(
        initialData: model.data.valueOrNull,
        stream: model.data,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) => LibraryItem(
              index: index,
              onEdit: _onEdit,
            ),
            itemCount: data.count,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: Library.addBookButtonKey,
        onPressed: _onEdit,
        tooltip: actionAddBook,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscriptions.dispose();

    super.dispose();
  }

  void _onEdit({
    BookDto? book,
  }) async {
    final response = await Navigator.of(context).push<EditBookResponse>(
      MaterialPageRoute(
        builder: (context) => EditBook(
          initialData: book,
        ),
      ),
    );

    if (response != null) {
      final model = Provider.of<LibraryModel>(
        context,
        listen: false,
      );

      switch (response.kind) {
        case EditBookKind.cancel:
          // Do nothing.
          break;
        case EditBookKind.delete:
          model.deleteBook(
            id: response.book!.id!,
          );
          break;
        case EditBookKind.update:
        case EditBookKind.add:
          model.putBook(
            book: response.book!,
          );
          break;
      }
    }
  }
}
