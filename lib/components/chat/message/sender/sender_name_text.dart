import 'package:flutter/material.dart';

class SenderNameText extends StatelessWidget {
  const SenderNameText({
    super.key,
    required this.sendername,
  });
  final String sendername;
  @override
  Widget build(BuildContext context) {
    return Text(sendername);
  }
}
