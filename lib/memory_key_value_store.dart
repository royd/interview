import 'package:interview/key_value_store.dart';

class MemoryKeyValueStore implements KeyValueStore {
  final _map = <String, String>{};

  @override
  Future<String?> getString(String key) async {
    return _map[key];
  }

  @override
  Future<bool> setString(String key, String value) async {
    _map[key] = value;

    return true;
  }
}
