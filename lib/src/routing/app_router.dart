import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/home/home_shell_screen.dart';
import 'package:flutter_turnkey_test/src/features/news/presentation/home/home_tabs.dart';
import 'package:flutter_turnkey_test/src/routing/app_route.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _trendsNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>();
final _bookmarksNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.trends.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShellScreen(navigationShell: navigationShell);
        },
        branches: List.generate(
          HomeTabs.values.length,
          (index) => HomeTabs.values[index].branch,
        ),
      ),
    ],
  );
});

extension HomeTabsRouting on HomeTabs {
  StatefulShellBranch get branch {
    return switch (this) {
      HomeTabs.trends => _createShellBranch(
          navigatorKey: _trendsNavigatorKey,
          routes: [
            const _Route(
              route: AppRoute.trends,
              page: Center(
                child: Text('Trends'),
              ),
            ),
          ],
        ),
      HomeTabs.search => _createShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            const _Route(
              route: AppRoute.search,
              page: Center(
                child: Text('Search'),
              ),
            ),
          ],
        ),
      HomeTabs.bookmarks => _createShellBranch(
          navigatorKey: _bookmarksNavigatorKey,
          routes: [
            const _Route(
              route: AppRoute.bookmarks,
              page: Center(
                child: Text('Bookmarks'),
              ),
            ),
          ],
        ),
    };
  }
}

GoRoute _createSimpleRoute({
  required AppRoute route,
  required Widget page,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  return GoRoute(
    path: route.path,
    name: route.name,
    parentNavigatorKey: parentNavigatorKey ?? _rootNavigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: page,
    ),
  );
}

StatefulShellBranch _createShellBranch({
  required GlobalKey<NavigatorState>? navigatorKey,
  List<_Route>? routes,
}) {
  return StatefulShellBranch(navigatorKey: navigatorKey, routes: [
    if (routes != null)
      ...List.generate(
        routes.length,
        (index) => _createSimpleRoute(
            route: routes[index].route,
            page: routes[index].page,
            parentNavigatorKey: navigatorKey),
      ),
  ]);
}

class _Route {
  final AppRoute route;
  final Widget page;

  const _Route({
    required this.route,
    required this.page,
  });
}
