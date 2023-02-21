import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}
