import 'package:flutter/material.dart';

class AccountBotton extends StatelessWidget {
  const AccountBotton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
