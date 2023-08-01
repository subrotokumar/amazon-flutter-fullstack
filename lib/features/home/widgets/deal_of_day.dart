import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/products_detail/screens/products_detail_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DealOfDay extends ConsumerStatefulWidget {
  const DealOfDay({super.key});

  @override
  ConsumerState<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends ConsumerState<DealOfDay> {
  Product? product;
  final homeServices = HomeSerices();

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  fetchDealOfTheDay() async {
    product = await homeServices.dealOfTheDay(context: context, ref: ref);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Loader();
    } else if (product!.name.isEmpty) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          context.pushNamed(
            ProductDetailScreen.name,
            pathParameters: {
              'id': product!.id!,
              'name': product!.name.replaceAll('', '_'),
            },
            extra: product,
          );
        },
        child: Column(
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
              imageUrl: product!.images.first,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
              child: Text(
                '\$ ${product?.price ?? 0}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
              child: Text(
                product?.name ?? '',
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
                  for (int i = 0; i < product!.images.length; i++)
                    CachedNetworkImage(
                      imageUrl: product!.images.elementAt(i),
                      fit: BoxFit.contain,
                      width: 100,
                      height: 100,
                    ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'See All Deals',
                style: TextStyle(color: Colors.cyan.shade800),
              ),
            ),
          ],
        ),
      );
    }
  }
}
