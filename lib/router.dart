import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/home/screens/category_deal_screen.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/products_detail/screens/products_detail_screen.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'constants/global_variables.dart';
import 'main.dart';

final router = Provider<GoRouter>(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
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
      GoRoute(
        path: AdminScreen.path,
        builder: (context, state) => const AdminScreen(),
      ),
      GoRoute(
        path: AddProductScreen.path,
        builder: (context, state) => const AddProductScreen(),
      ),
      GoRoute(
        name: CategoryDealScreen.name,
        path: CategoryDealScreen.path,
        builder: (context, state) => CategoryDealScreen(
          category: state.pathParameters['category']!,
        ),
      ),
      GoRoute(
        name: SearchScreen.name,
        path: SearchScreen.path,
        builder: (context, state) => SearchScreen(
          searchQuery: state.pathParameters['searchQuery'] ?? '',
        ),
      ),
      GoRoute(
          name: ProductDetailScreen.name,
          path: ProductDetailScreen.path,
          builder: (context, state) => ProductDetailScreen(
                product: state.extra as Product,
              )),
    ],
    redirect: (context, state) {
      log.wtf(state.fullPath);
      return null;
    },
  ),
);
