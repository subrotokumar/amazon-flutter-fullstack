// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon/constants/env.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AdminService {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    required WidgetRef ref,
  }) async {
    try {
      final cloudnary = CloudinaryPublic(ENV.cloudname, ENV.uploadPreset);
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudnary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        category: category,
        description: description,
        images: imageUrl,
        price: price,
        quantity: quantity,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': ref.read(userProvider).token,
        },
        body: product.toJson(),
      );
      log.v(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () => showSnackBar(context, 'Product added successfully'),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>?> getListOfProducts(
      BuildContext context, WidgetRef ref) async {
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/products'),
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

  Future<List<Product>?> deleteProduct({
    required BuildContext context,
    required WidgetRef ref,
    required VoidCallback onSuccess,
    required Product product,
  }) async {
    List<Product> productList = [];
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json',
                'x-auth-token': ref.read(userProvider).token,
              },
              body: jsonEncode({'id': product.id}));
      log.v(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e, s) {
      log.wtf(s);
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
