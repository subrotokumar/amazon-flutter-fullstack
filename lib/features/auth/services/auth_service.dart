// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        address: '',
        type: '',
        token: '',
        password: password,
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse('$uri/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account is created successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      log.v(res.body);
      log.v(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final pref = await SharedPreferences.getInstance();
          ref.read(userProvider.notifier).setUser(res.body);
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          context.go(BottomBar.path);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(WidgetRef ref) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token') ?? '';
      if (token.isEmpty) {
        await pref.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': token
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response) {
        http.Response userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-auth-token': token,
          },
        );
        if (userResponse.statusCode == 200) {
          final userNotifier = ref.read(userProvider.notifier);
          userNotifier.setUser(userResponse.body);
        } else {
          log.e(
              'Error getting userData : ${jsonDecode(userResponse.body)['error']}');
        }
      }
    } catch (e) {}
  }
}
