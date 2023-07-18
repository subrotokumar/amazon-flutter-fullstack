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
        ));

  void setUser(String user) {
    state = User.fromJson(user);
  }
}
