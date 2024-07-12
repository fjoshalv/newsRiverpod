import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_turnkey_test/src/routing/app_router.dart';
import 'package:flutter_turnkey_test/src/utils/app_strings.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      title: AppStrings.appName,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
