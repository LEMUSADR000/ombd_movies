import 'package:flutter/foundation.dart';
import 'package:ombd_movies/services/local/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ASSUMPTION: Any model data that is persisted can benefit from having migration
/// logic attached to it, better safe than sorry!
abstract class Migration {
  final SharedPreferences _sharedPreferences;

  Migration(this._sharedPreferences);

  int get id;

  Future<void> migration(SharedPreferences prefs);

  Future<void> execute() async {
    try {
      await migration(_sharedPreferences);
      _success();
    } catch (err, stackTrace) {
      if (kDebugMode) {
        print('Cannot execute migration $id\n\n$err\n\n$stackTrace');
      }
    }
  }

  bool shouldExecute() {
    final int? lastMigrationId =
        _sharedPreferences.getInt(StorageKeys.kMigrationId);
    return lastMigrationId == null || lastMigrationId < id;
  }

  void _success() {
    _sharedPreferences.setInt(StorageKeys.kMigrationId, id);

    if (kDebugMode) {
      print('Migration $id successfully executed');
    }
  }
}
