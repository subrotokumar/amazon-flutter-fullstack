import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        child: Image.network(
          image,
          fit: BoxFit.fitHeight,
          width: 180,
        ),
      ),
    );
  }
}
