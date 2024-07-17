import 'package:flutter/material.dart';
import 'package:news_riverpod/src/features/news/presentation/home/home_tabs.dart';
import 'package:news_riverpod/src/utils/app_strings.dart';
import 'package:go_router/go_router.dart';

class HomeShellScreen extends StatelessWidget {
  const HomeShellScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: navigationShell.currentIndex == index,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Make a scaffold with a bottom navigation bar that supports tabs
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: HomeTabs.values
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
