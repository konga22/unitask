import 'package:flutter/material.dart';

class SubjectLabel extends StatelessWidget {
  final String text;

  const SubjectLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: .circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: .w700, fontSize: 12),
      ),
    );
  }
}
