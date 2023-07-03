import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

final router = Provider<GoRouter>(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const MyHomePage();
        },
      ),
      GoRoute(
        path: AuthScreen.path,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: BottomBar.path,
        builder: (context, state) => const BottomBar(),
      ),
    ],
  ),
);
