import 'package:hive_flutter/hive_flutter.dart';

/// Lightweight cache layer built on Hive.
///
/// Stores JSON-serializable Maps with a TTL (time-to-live).
/// When the real API is connected, wrap repository calls with
/// [get] / [put] to enable offline-first behaviour.
class CacheManager {
  static const _metaBoxName = 'cache_meta';

  /// Initialize Hive. Call once at app startup.
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Open (or reuse) a named Hive box for a specific data domain.
  static Future<Box<dynamic>> openBox(String name) async {
    if (Hive.isBoxOpen(name)) return Hive.box(name);
    return Hive.openBox(name);
  }

  /// Store a value under [key] in [boxName] with an expiry timestamp.
  static Future<void> put(
    String boxName,
    String key,
    dynamic value, {
    Duration ttl = const Duration(minutes: 15),
  }) async {
    final box = await openBox(boxName);
    await box.put(key, value);

    // Store expiry timestamp in a separate meta box.
    final meta = await openBox(_metaBoxName);
    await meta.put(
      '${boxName}_$key',
      DateTime.now().add(ttl).millisecondsSinceEpoch,
    );
  }

  /// Retrieve a cached value. Returns `null` if missing or expired.
  static Future<T?> get<T>(String boxName, String key) async {
    final meta = await openBox(_metaBoxName);
    final expiryMs = meta.get('${boxName}_$key');
    if (expiryMs is int && DateTime.now().millisecondsSinceEpoch > expiryMs) {
      // Expired — remove stale entry.
      final box = await openBox(boxName);
      await box.delete(key);
      await meta.delete('${boxName}_$key');
      return null;
    }

    final box = await openBox(boxName);
    return box.get(key) as T?;
  }

  /// Check whether a non-expired value exists for [key].
  static Future<bool> has(String boxName, String key) async {
    final value = await get(boxName, key);
    return value != null;
  }

  /// Remove a specific entry.
  static Future<void> remove(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
    final meta = await openBox(_metaBoxName);
    await meta.delete('${boxName}_$key');
  }

  /// Clear all entries in a specific box.
  static Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  /// Clear all caches (useful on logout).
  static Future<void> clearAll() async {
    await Hive.deleteFromDisk();
    await init();
  }
}
