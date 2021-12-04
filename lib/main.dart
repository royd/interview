import 'package:flutter/material.dart';
import 'package:interview/shared_preferences_key_value_store.dart';

import 'app.dart';

void main() {
  runApp(
    App(
      store: SharedPreferencesKeyValueStore(),
    ),
  );
}
