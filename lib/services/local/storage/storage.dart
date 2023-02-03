/// ASSUMPTION: Local storage will be stubbed in unit tests
abstract class LocalStorage {
  Future<void> init();
  Future<bool> clearStorage();

  Future<bool> toggleFavorite(String id);
  Future<bool> setMigrationId(int id);

  List<String> get favorites;
  int? get migrationId;
}

abstract class StorageKeys {
  static const String kMigrationId = 'kMigrationId';
  static const String kFavorites = 'kFavorites';
}
