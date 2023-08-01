import 'package:amazon/features/products_detail/screens/products_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/models/product.dart';
import 'package:go_router/go_router.dart';

class CategoryDealScreen extends ConsumerStatefulWidget {
  static const String path = '/category/:category';
  static const String name = 'category';
  const CategoryDealScreen({super.key, required this.category});
  final String category;

  @override
  ConsumerState<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends ConsumerState<CategoryDealScreen> {
  final HomeSerices homeSerices = HomeSerices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fatchCategoryProducts();
  }

  fatchCategoryProducts() async {
    products = await homeSerices.getListOfProducts(
        context: context, ref: ref, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.appBarGradient),
                ),
                title: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/amazon_in.png',
                        width: 120,
                        height: 45,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text('Keep shpoing for ${widget.category}'),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products![index];
                      return GestureDetector(
                        onTap: () => context.pushNamed(
                          ProductDetailScreen.name,
                          pathParameters: {
                            'id': product.id!,
                            'name': product.name.replaceAll('', '_'),
                          },
                          extra: product,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CachedNetworkImage(
                                    imageUrl: product.images.first,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 0, top: 5, right: 15),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
