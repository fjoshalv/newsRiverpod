import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_turnkey_test/src/shared/data/data_sources/local_storage_manager.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../../../mocks.dart';

void main() {
  late MockDatabase database;
  late MockStoreRef store;

  setUp(() {
    database = MockDatabase();
    store = MockStoreRef();
  });

  LocalStorageManager makeLocalStorageManager() {
    return LocalStorageManager(
      database: database,
      store: store,
    );
  }

  group('Database Initialization', () {
    // * This is needed to mock the path_provider plugin responses
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/path_provider'),
              (MethodCall methodCall) async {
        return '.';
      });
    });

    test(
      'initDatabase should return a Database',
      () async {
        final db = await LocalStorageManager.initDatabase('test.db');

        expect(db, isA<Database>());

        // * Close the database and delete the file so that it doesn't persist
        await db.close();
        await databaseFactoryIo.deleteDatabase(db.path);
      },
    );

    test('initDefault should return a LocalStorageManager', () async {
      final manager = await LocalStorageManager.initDefault(
        filename: 'unit_test.db',
      );
      expect(manager, isA<LocalStorageManager>());

      // * Close the database and delete the file so that it doesn't persist
      await manager.database.close();
      await databaseFactoryIo.deleteDatabase(manager.database.path);
    });
  });
}
