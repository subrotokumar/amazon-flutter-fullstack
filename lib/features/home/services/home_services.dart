// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amazon/models/product.dart';

class HomeSerices {
  Future<List<Product>?> getListOfProducts({
    required BuildContext context,
    required WidgetRef ref,
    required String category,
  }) async {
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
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

  Future<Product> dealOfTheDay({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/producct/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
