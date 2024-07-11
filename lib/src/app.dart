import 'package:flutter/material.dart';
import 'package:flutter_turnkey_test/src/utils/app_strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const Material(
        child: Center(
          child: Text(AppStrings.helloWorld),
        ),
      ),
    );
  }
}
