import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      maxRadius: 50,
      foregroundImage: AssetImage(kLogo),
    );
  }
}
