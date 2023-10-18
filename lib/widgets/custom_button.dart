import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(12)),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ))),
    );
  }
}
