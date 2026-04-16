import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;

  const TextDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Expanded(child: Divider()),
        Text('또는', style: TextStyle(color: Colors.grey)),
        Expanded(child: Divider()),
      ],
    );
  }
}
