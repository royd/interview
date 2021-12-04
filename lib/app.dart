import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview/app_localizations.dart';
import 'package:interview/book_client_impl.dart';
import 'package:interview/key_value_store.dart';
import 'package:interview/library.dart';
import 'package:interview/library_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({
    required KeyValueStore store,
  }) : _store = store;

  final KeyValueStore _store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider<LibraryModel>(
        create: (context) => LibraryModel(
          client: BookClientImpl(
            store: _store,
          ),
        ),
        dispose: (context, model) => model.dispose(),
        child: Library(
          title: appTitle,
        ),
      ),
    );
  }
}
