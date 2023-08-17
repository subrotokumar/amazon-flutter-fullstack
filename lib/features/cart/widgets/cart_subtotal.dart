import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSubTotal extends ConsumerWidget {
  const CartSubTotal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(userProvider.select((value) => value.cart)).toList();
    double sum = 0;
    cart.map((item) => sum += item.product.price * item.quantity).toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            ' ₹ ${sum.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
