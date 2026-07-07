import 'package:hive_flutter/hive_flutter.dart';

/// Local storage wrapper using Hive for fast key-value persistence.
class LocalStorage {
  LocalStorage._();

  static late Box _box;

  /// Initialize the default Hive box.
  static Future<void> init() async {
    _box = await Hive.openBox('student_hub_settings');
  }

  // ── String ──
  static String? getString(String key) => _box.get(key) as String?;
  static Future<void> setString(String key, String value) => _box.put(key, value);

  // ── Int ──
  static int? getInt(String key) => _box.get(key) as int?;
  static Future<void> setInt(String key, int value) => _box.put(key, value);

  // ── Bool ──
  static bool getBool(String key, {bool defaultValue = false}) =>
      _box.get(key, defaultValue: defaultValue) as bool;
  static Future<void> setBool(String key, bool value) => _box.put(key, value);

  // ── Double ──
  static double? getDouble(String key) => _box.get(key) as double?;
  static Future<void> setDouble(String key, double value) => _box.put(key, value);

  // ── Dynamic ──
  static dynamic get(String key) => _box.get(key);
  static Future<void> set(String key, dynamic value) => _box.put(key, value);

  // ── Delete ──
  static Future<void> delete(String key) => _box.delete(key);
  static Future<int> clear() => _box.clear();

  // ── Check ──
  static bool containsKey(String key) => _box.containsKey(key);
}
