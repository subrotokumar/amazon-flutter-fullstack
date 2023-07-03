import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map((item) {
          return Builder(
            builder: (context) => Image.network(
              item,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
        ),
      ),
    );
  }
}
