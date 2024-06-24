// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final String routeName;
  const NavigationButton({
    super.key,
    required this.label,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, routeName),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
