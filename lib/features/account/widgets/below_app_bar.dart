import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BelowAppBar extends ConsumerWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
