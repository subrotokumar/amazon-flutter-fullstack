import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});
  static const String path = "/buy/address";
  static const String name = "confirm-address";

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final addressKey = GlobalKey<FormState>();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final address = ref.watch(userProvider.select((value) => value.address));
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (address.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Text(
                            address,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('OR'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  Form(
                    key: addressKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: buildingController,
                          hintText: 'Flat / Building',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: addressController,
                          hintText: 'Address',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: cityController,
                          hintText: 'City',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: pinController,
                          hintText: 'Pin code',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          label: 'Continue',
                          onTap: () async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
