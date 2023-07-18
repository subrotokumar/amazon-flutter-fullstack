// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:amazon/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(secondary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      routerConfig: ref.watch(router),
    );
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  static const String path = "/";
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await AuthService().getUserData(ref);
    (ref.read(userProvider).token.isEmpty)
        ? context.go(AuthScreen.path)
        : (ref.read(userProvider).type == 'user'
            ? context.go(BottomBar.path)
            : context.go(AdminScreen.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/amazon_in.png',
          width: 200,
        ),
      ),
    );
  }
}
