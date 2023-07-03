import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  GlobalVariables.categoryImages.elementAt(index)['image']!,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              Text(
                GlobalVariables.categoryImages.elementAt(index)['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
