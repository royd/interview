import 'package:interview/key_value_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeyValueStore implements KeyValueStore {
  @override
  Future<String?> getString(String key) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.setString(key, value);
  }
}
