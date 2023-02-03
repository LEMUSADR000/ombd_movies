import 'package:ombd_movies/services/local/storage/migration.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ASSUMPTION: We want to have an initial migration for setting up a migration
/// id. We could do this through the storage_impl initializer but this allows
/// for easier traceability
class LocalStorageMigrationV1 extends Migration {
  LocalStorageMigrationV1(SharedPreferences sharedPreferences)
      : super(sharedPreferences);

  @override
  int get id => 0;

  @override
  Future<void> migration(SharedPreferences prefs) async {
    // migration logic here
  }
}
