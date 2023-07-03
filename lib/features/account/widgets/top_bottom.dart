import 'package:amazon/features/account/widgets/account_botton.dart';
import 'package:flutter/material.dart';

class TopBottons extends StatefulWidget {
  const TopBottons({super.key});

  @override
  State<TopBottons> createState() => _TopBottonsState();
}

class _TopBottonsState extends State<TopBottons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              AccountBotton(text: 'Your Orders', onPressed: () {}),
              AccountBotton(text: 'Turn Seller', onPressed: () {}),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AccountBotton(text: 'Log Out', onPressed: () {}),
              AccountBotton(text: 'Your Wishlist', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
