import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lilit/screens/home/home_screen.dart';
import 'package:lilit/screens/login/login_screen.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  final AuthStore authStore;

  AppRouter(this.authStore);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: HomeRoute.page,
          guards: [AuthGuard(authStore)],
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [AuthGuard(authStore)];
}

class AuthGuard extends AutoRouteGuard {
  final AuthStore authStore;

  AuthGuard(this.authStore);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authStore.isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(LoginRoute());
    }
  }
}
