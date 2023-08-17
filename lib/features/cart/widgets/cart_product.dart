import 'package:amazon/features/products_detail/services/product_detail_services.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProduct extends ConsumerStatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  ConsumerState<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends ConsumerState<CartProduct> {
  final ProductDetailService productDetailService = ProductDetailService();

  void increaseQuantity(Product product) {
    productDetailService.addToCart(
        context: context, ref: ref, product: product);
  }

  void decreaseQuantity(Product product) {
    productDetailService.decreaseFromProduct(
        context: context, ref: ref, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final cartItem =
        ref.watch(userProvider.select((value) => value.cart[widget.index]));
    final product = cartItem.product;
    final quantity = cartItem.quantity;
    return Column(
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
        ),
        Container(
          margin: const EdgeInsets.all(10).copyWith(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async => decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 34,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  width: 35,
                  height: 38,
                  alignment: Alignment.center,
                  child: Text(quantity.toString()),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async => increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 34,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
