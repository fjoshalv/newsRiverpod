import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

part 'local_storage_manager.g.dart';

class LocalStorageManager {
  const LocalStorageManager({
    required this.database,
    required this.mainStore,
  });

  final Database database;
  final StoreRef mainStore;

  static Future<Database> initDatabase(String filename) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return await databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  }

  static Future<LocalStorageManager> initDefault({
    String filename = 'default.db',
  }) async {
    final db = await initDatabase(filename);
    return LocalStorageManager(
      database: db,
      mainStore: StoreRef.main(),
    );
  }

  Future<T?> getRecordInCustomStore<T>({
    required String key,
    required StoreRef store,
  }) async {
    return await store.record(key).get(database) as T?;
  }

  Future<void> saveInCustomStore<T>(
    T data, {
    required StoreRef store,
    required String key,
  }) async {
    await store.record(key).add(database, data);
  }

  Future<void> deleteInCustomStore<T>(
    String key, {
    required StoreRef store,
  }) async {
    await store.record(key).delete(database);
  }

  Stream<List<T>> watchRecordsInCustomStore<T>({
    required StoreRef store,
    Finder? finder,
  }) {
    return store.query(finder: finder).onSnapshots(database).map((event) {
      return event.map((snapshot) {
        return snapshot.value as T;
      }).toList();
    });
  }
}

@riverpod
LocalStorageManager localStorageManager(LocalStorageManagerRef ref) {
  throw UnimplementedError();
}
