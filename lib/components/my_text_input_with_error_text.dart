import 'package:flutter/material.dart';
import 'package:week8/components/input_with_error_text.dart';

// ignore: must_be_immutable
class MyTextInputWithErrorText extends StatelessWidget {
  InputWithErrorText input;
  final bool obscureText;
  final String hintText;
  final TextInputType keyboardType;

  MyTextInputWithErrorText({
    super.key,
    required this.input,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          input.valueText = value;
        },
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: input.errorText,
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
