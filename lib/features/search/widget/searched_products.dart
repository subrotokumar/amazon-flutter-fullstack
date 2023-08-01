import 'package:amazon/common/widgets/stars.dart';
import 'package:amazon/features/products_detail/screens/products_detail_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchedProductWinget extends StatelessWidget {
  const SearchedProductWinget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    double rating = 0;
    if (product.ratings != null) {
      for (int i = 0; i < product.ratings!.length; i++) {
        rating += product.ratings![i].rating;
      }
      if (rating != 0) {
        rating /= product.ratings!.length;
      }
    }
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          ProductDetailScreen.name,
          pathParameters: {
            'id': product.id!,
            'name': product.name.replaceAll('', '_'),
          },
          extra: product,
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: product.images.first,
                  fit: BoxFit.fitHeight,
                  height: 135,
                  width: 135,
                ),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Stars(rating: rating),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\$${product.price}',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text('Eligible for FREE Shipping'),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
