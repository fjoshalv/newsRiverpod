import 'package:news_riverpod/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RouteManager {
  const RouteManager(this.router);
  final GoRouter router;
}

final routeManagerProvider = Provider<RouteManager>((ref) {
  return RouteManager(ref.watch(goRouterProvider));
});
