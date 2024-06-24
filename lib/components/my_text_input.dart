import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  const MyTextInput(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}