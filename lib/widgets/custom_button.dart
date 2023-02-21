import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, this.onPressed});
  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      onPressed: onPressed,
      color: Colors.white,
      textColor: const Color(0xff2b475e),
      child: Text(text),
    );
  }
}
