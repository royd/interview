import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:interview/app_localizations.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/edit_book_kind.dart';
import 'package:interview/edit_book_response.dart';

class EditBook extends StatefulWidget {
  const EditBook({
    this.initialData,
    Key? key,
  }) : super(key: key);

  final BookDto? initialData;

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _imageUrlController;
  late final TextEditingController _titleController;
  late final TextEditingController _authorsController;

  @override
  void initState() {
    super.initState();

    _imageUrlController = TextEditingController(
      text: widget.initialData?.imageUrl,
    );

    _titleController = TextEditingController(
      text: widget.initialData?.title,
    );

    _authorsController = TextEditingController(
      text: widget.initialData?.authors,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final id = widget.initialData?.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appTitle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(
              EditBookResponse(
                kind: EditBookKind.cancel,
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: id == null
                ? null
                : () {
                    Navigator.of(context).pop(
                      EditBookResponse(
                        kind: EditBookKind.delete,
                        book: widget.initialData,
                      ),
                    );
                  },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.tab): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: titleLabel,
                      hintText: titleHint,
                    ),
                    validator: _validateRequiredText,
                  ),
                  TextFormField(
                    controller: _authorsController,
                    decoration: InputDecoration(
                      labelText: authorLabel,
                      hintText: authorHint,
                    ),
                    validator: _validateRequiredText,
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      labelText: imageUrlLabel,
                      hintText: imageUrlHint,
                    ),
                    validator: _validateUri,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 12,
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        final form = _formKey.currentState!;
                        if (form.validate()) {
                          final book = BookDto(
                            id: widget.initialData?.id,
                            title: _titleController.text,
                            authors: _authorsController.text,
                            imageUrl: _imageUrlController.text,
                          );

                          Navigator.of(context).pop(
                            EditBookResponse(
                              kind: EditBookKind.add,
                              book: book,
                            ),
                          );
                        }
                      },
                      color: Colors.blue,
                      child: Text(
                        saveLabel,
                        style: theme.textTheme.button?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _imageUrlController.dispose();
    _titleController.dispose();
    _authorsController.dispose();
  }

  String? _validateRequiredText(String? value) {
    return (value == null || value.isEmpty) ? errorRequiredField : null;
  }

  String? _validateUri(String? value) {
    String? error;

    if (value != null && value.isNotEmpty) {
      final uri = Uri.tryParse(value);
      if (uri == null || uri.host == '') {
        error = errorInvalidUrl;
      }
    }

    return error;
  }
}
