import 'dart:convert';

import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          id: '',
          name: '',
          email: '',
          password: '',
          address: '',
          type: '',
          token: '',
          cart: [],
        ));

  void setUser(String user) {
    log.v(jsonDecode(user));
    state = User.fromJson(user);
  }

  void setUserFromModel(User user) {
    state = user;
  }
}
