import 'package:flutter/material.dart';

import 'package:amazon/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.label,
  });
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        backgroundColor: GlobalVariables.secondaryColor,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}
