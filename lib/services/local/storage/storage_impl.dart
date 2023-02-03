import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ombd_movies/services/local/storage/migration_manager.dart';
import 'package:ombd_movies/services/local/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImpl implements LocalStorage {
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final MigrationManager migrationManager =
        MigrationManager(sharedPreferences: _sharedPreferences);
    await migrationManager.execute();
  }

  // ---- Write section start -------------------

  @override
  Future<bool> setMigrationId(int id) =>
      _sharedPreferences.setInt(StorageKeys.kMigrationId, id);

  @override
  Future<bool> toggleFavorite(String id) async {
    final Set<String> current =
        _sharedPreferences.getStringList(StorageKeys.kFavorites)?.toSet() ??
            <String>{};
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }

    return _sharedPreferences.setStringList(
        StorageKeys.kFavorites, current.toList(growable: false));
  }

  // ---- Write section end ----------------------

  // ---- Read section start ---------------------

  @override
  int? get migrationId => _sharedPreferences.getInt(StorageKeys.kMigrationId);

  @override
  List<String> get favorites =>
      _sharedPreferences.getStringList(StorageKeys.kFavorites) ?? [];

  // ---- Read section end ------------------------

  /// ASSUMPTION: We will want to eventually allow for a user to clear storage.
  /// this use case is more common in a situation where we have login/logout.
  @override
  Future<bool> clearStorage() async {
    final bool isCleared = await _sharedPreferences.clear();

    if (kDebugMode) {
      isCleared
          ? print('Local storage has been cleared')
          : print('Cannot clear local storage');
    }

    return isCleared;
  }
}
