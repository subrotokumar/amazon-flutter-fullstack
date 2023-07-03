import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: const Text(
            'Deal of the day',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1627885793933-584e53987c14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXx6WWptaS1KMVdLa3x8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
          height: 200,
          fit: BoxFit.fitWidth,
        )
      ],
    );
  }
}
