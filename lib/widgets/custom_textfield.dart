import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.onChanged ,
    required this.hintText,
    this.validator,
  });
  Function(String)? onChanged ;
  final String hintText;
  String? Function(String?)? validator ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ,
      
      onChanged: onChanged ,
      decoration: InputDecoration(
        hintText: hintText,
        
        hintStyle: const TextStyle(color: kSecondaryColor , fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
