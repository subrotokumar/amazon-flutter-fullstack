import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/address/screens/address_screen.dart';
import 'package:amazon/features/cart/widgets/cart_product.dart';
import 'package:amazon/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navToSearchScreen(String searchQuery) {
    context.pushNamed(
      SearchScreen.name,
      pathParameters: {'searchQuery': searchQuery},
    );
  }

  void navToAddressScreen() {
    context.pushNamed(AddressScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  // margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navToSearchScreen,
                      onTapOutside: (v) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                size: 23,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 16),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.white38, width: 1),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final length =
            ref.watch(userProvider.select((value) => value.cart.length));
        return SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              const CartSubTotal(),
              if (length > 0)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onTap: navToAddressScreen,
                    label: 'Proceed to Buy ($length) items',
                    color: Colors.yellow.shade600,
                  ),
                ),
              const SizedBox(height: 15),
              Container(
                color: Colors.black.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(height: 5),
              for (int i = 0; i < length; i++) CartProduct(index: i),
            ],
          ),
        );
      }),
    );
  }
}
