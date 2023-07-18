import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Consumer(builder: (context, ref, child) {
                final user = ref.watch(userProvider);
                return Text(
                  'Delivery to ${user.name} - ${user.address}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 2, right: 10),
            child: Icon(Icons.arrow_drop_down),
          )
        ],
      ),
    );
  }
}
