import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_store.g.dart';

class LocalStore {
  final SharedPreferences _prefs;
  const LocalStore(this._prefs);

  List<Map<String, dynamic>> readJsonList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return <Map<String, dynamic>>[];
    final decoded = json.decode(raw);
    if (decoded is! List) return <Map<String, dynamic>>[];
    return decoded
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList(growable: true);
  }

  Future<bool> writeJsonList(
      String key, List<Map<String, dynamic>> items) async {
    return _prefs.setString(key, json.encode(items));
  }

  Map<String, dynamic>? readJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    final decoded = json.decode(raw);
    if (decoded is! Map) return null;
    return Map<String, dynamic>.from(decoded);
  }

  Future<bool> writeJson(String key, Map<String, dynamic> value) async {
    return _prefs.setString(key, json.encode(value));
  }

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  bool containsKey(String key) => _prefs.containsKey(key);
}

@Riverpod(keepAlive: true)
LocalStore localStore(Ref ref) =>
    throw UnimplementedError('localStoreProvider must be overridden in main()');
