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

class SearchService {
  Future<List<Product>> fetchSearchProduct(
      BuildContext context, WidgetRef ref, String searchQuery) async {
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
      );
      log.v(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
                Product.fromJson(jsonEncode(jsonDecode(response.body)[i])));
          }
        },
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
