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
        const SizedBox(height: 8),
        CachedNetworkImage(
          imageUrl:
              'https://images.unsplash.com/photo-1627885793933-584e53987c14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXx6WWptaS1KMVdLa3x8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
          height: 200,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            '\$ ${100}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Euphoria Cosmetics',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 6; i++)
                CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1560769629-975ec94e6a86?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2R1Y3RzfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See All Deals',
            style: TextStyle(color: Colors.cyan.shade800),
          ),
        ),
      ],
    );
  }
}
