import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_riverpod/src/app.dart';
import 'package:news_riverpod/src/shared/data/data_sources/local_storage_manager.dart';
import 'package:news_riverpod/src/utils/app_constants.dart';
import 'package:news_riverpod/src/utils/app_strings.dart';

class AppBootstrap {
  Widget createRootWidget(ProviderContainer container) {
    _registerErrorHandlers();
    return UncontrolledProviderScope(
      container: container,
      child: const App(),
    );
  }

  Future<void> initDotEnv() async {
    await dotenv.load(fileName: AppConstants.dotEnvFilePath);
  }

  void _registerErrorHandlers() {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      if (kDebugMode) {
        // * Print the error to the console in debug mode
        log('Error: $error');
        log('Stack: $stack');
      }
      return true;
    };

    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(AppStrings.errorOccurred),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }
}
