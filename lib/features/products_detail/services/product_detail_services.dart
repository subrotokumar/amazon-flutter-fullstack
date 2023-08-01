// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
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
