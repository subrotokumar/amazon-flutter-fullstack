import 'package:amazon/features/auth/home/screens/home_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final router = Provider<GoRouter>((ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            final user = ref.read(userProvider);
            return (user.token.isNotEmpty) ? HomeScreen() : AuthScreen();
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
      ],
    ));
