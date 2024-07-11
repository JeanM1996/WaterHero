import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waterhero/features/authentication/login/presentation/login_page.dart';
import 'package:waterhero/features/authentication/register/presentation/register_page.dart';
import 'package:waterhero/features/authentication/restore_password/presentation/restore_page.dart';
import 'package:waterhero/features/comsumption/presentation/dashboard/comsumption_page.dart';
import 'package:waterhero/features/main/main_page.dart';
import 'package:waterhero/features/promotions/presentation/dashboard/promotions_page.dart';
import 'package:waterhero/features/tips/presentation/dashboard/tips_page.dart';
import 'package:waterhero/splash_page/splash_page.dart';

/// TODO: ESTE ARCHIVO EMPIEZA YA A SER MUY LARGO
/// 1. SEPARAR LOS PATHS DE LAS RUTAS EN UN ARCHIVO APARTE
/// 2. TIENE LOGICA DENTRO DE EL, EL ROUTER SOLO DEBERÍA LLAMAR UNA PAGE Y ENVIARLE ARGUMENTOS
class Routes {
  static const String rootRoute = '/';
  static const String loginRoute = '/login';
  static const String recoveryPasswordRoute = '/recover-password';
  static const String registerRoute = '/register';
  static const String tipsRoute = '/tips';
  static const String promotionsRoute = '/promotions';
  static const String comsumptionRoute = '/comsumption';
}

final router = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: Routes.rootRoute,
      pageBuilder: (context, state) =>
          page(state: state, child: const SplashPage()),
    ),
    GoRoute(
      path: Routes.loginRoute,
      pageBuilder: (context, state) =>
          page(state: state, child: const LoginPage()),
    ),
    GoRoute(
      path: Routes.recoveryPasswordRoute,
      pageBuilder: (context, state) =>
          page(state: state, child: const RestorePage()),
    ),
    GoRoute(
      path: Routes.registerRoute,
      pageBuilder: (context, state) =>
          page(state: state, child: const RegisterPage()),
    ),
    GoRoute(
      path: Routes.comsumptionRoute,
      pageBuilder: (context, state) => page(
        state: state,
        child: const MainPage(
          pageTitle: '',
          pageState: 0,
          child: ComsumptionPage(
            {},
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.tipsRoute,
      pageBuilder: (context, state) => page(
        state: state,
        child: const MainPage(
          pageTitle: '',
          pageState: 1,
          child: TipsPage(
            {},
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.promotionsRoute,
      pageBuilder: (context, state) => page(
        state: state,
        child: const MainPage(
          pageTitle: '',
          pageState: 2,
          child: PromotionsPage(
            {},
          ),
        ),
      ),
    ),
  ],
);

dynamic page({required GoRouterState state, required Widget child}) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

final goRouterProvider = Provider<GoRouter>((ref) => router);
