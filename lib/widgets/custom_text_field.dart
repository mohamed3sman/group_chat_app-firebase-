import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.labelText, this.onChanged, this.obsecureText = false});

  String labelText;
  bool? obsecureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is Required';
        }
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      obscureText: obsecureText!,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
