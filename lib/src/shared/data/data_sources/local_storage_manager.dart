import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

part 'local_storage_manager.g.dart';

class LocalStorageManager {
  const LocalStorageManager({
    required this.database,
    required this.store,
  });

  final Database database;
  final StoreRef store;

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
      store: StoreRef.main(),
    );
  }
}

@riverpod
LocalStorageManager localStorageManager(LocalStorageManagerRef ref) {
  throw UnimplementedError();
}
