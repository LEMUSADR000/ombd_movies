import 'package:flutter/foundation.dart';
import 'package:ombd_movies/services/local/storage/migration.dart';
import 'package:ombd_movies/services/local/storage/migrations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MigrationManager {
  final List<Migration> migrations = [];

  MigrationManager({required SharedPreferences sharedPreferences}) {
    migrations.add(LocalStorageMigrationV1(sharedPreferences));
  }

  Future<void> execute() async {
    for (final Migration migration in migrations) {
      if (migration.shouldExecute()) {
        if (kDebugMode) {
          print('Execute migration: ${migration.id}');
        }
        await migration.execute();
      }
    }
  }
}
