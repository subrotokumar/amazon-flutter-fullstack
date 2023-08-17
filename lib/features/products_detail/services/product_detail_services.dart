// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  void addToCart({
    required BuildContext context,
    required WidgetRef ref,
    required Product product,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/user/add-to-cart'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = ref.read(userProvider);
          user = user.copyWith(
            cart: (jsonDecode(response.body)['cart'] as List)
                .map((e) => CartItem.fromMap(e))
                .toList(),
          );
          ref.read(userProvider.notifier).setUserFromModel(user);
        },
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
  }

  void decreaseFromProduct({
    required BuildContext context,
    required WidgetRef ref,
    required Product product,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/user/decrease-from-cart'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = ref.read(userProvider);
          user = user.copyWith(
            cart: (jsonDecode(response.body)['cart'] as List)
                .map((e) => CartItem.fromMap(e))
                .toList(),
          );
          ref.read(userProvider.notifier).setUserFromModel(user);
        },
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required WidgetRef ref,
    required double rating,
    required Product product,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
  }
}
