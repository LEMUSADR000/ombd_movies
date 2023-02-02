abstract class LocalStorage {
  Future<void> init();
  Future<bool> clearStorage();

  Future<bool> toggleFavorite(String id);
  Future<bool> setMigrationId(int id);

  Set<String> get favorites;
  int? get migrationId;
}

abstract class StorageKeys {
  static const String kMigrationId = 'kMigrationId';
  static const String kFavorites = 'kFavorites';
}
