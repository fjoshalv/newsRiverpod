import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_turnkey_test/src/shared/data/data_sources/local_storage_manager.dart';
import 'package:flutter_turnkey_test/src/utils/app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Initialize needed dependencies
  final localStorageManager = await _initLocalStorage();

  // * Override unimplemented providers
  final container = ProviderContainer(
    overrides: [
      localStorageManagerProvider.overrideWithValue(localStorageManager),
    ],
  );

  final appBootstrap = AppBootstrap();

  await appBootstrap.initDotEnv();

  final root = appBootstrap.createRootWidget(container);

  runApp(root);
}

Future<LocalStorageManager> _initLocalStorage() {
  return LocalStorageManager.initDefault();
}
