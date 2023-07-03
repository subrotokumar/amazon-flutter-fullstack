import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widgets/below_app_bar.dart';
import 'package:amazon/features/account/widgets/order.dart';
import 'package:amazon/features/account/widgets/top_bottom.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(Icons.notifications_outlined),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          BelowAppBar(),
          TopBottons(),
          Order(),
        ],
      ),
    );
  }
}
