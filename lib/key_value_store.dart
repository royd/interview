abstract class KeyValueStore {
  Future<String?> getString(String key);

  Future<bool> setString(String key, String value);
}
